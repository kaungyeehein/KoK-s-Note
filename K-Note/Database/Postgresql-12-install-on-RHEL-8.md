# Postgresql 12 install on RHEL8

<div style="text-align: right;">KaungYeeHein's Note<br/>2024-Mar-17</div>

## Table of Contents
- [Chapter 1: Download & Install](#chapter-1-download-install)
- [Chapter 2: Change Data Directory](#chapter-2-change-data-directory)
- [Chapter 3: Enable Remote Access](#chapter-3-enable-remote-access)
- [Chapter 4: Save password in user profile](#chapter-4-save-password-in-user-profile)
- [Chapter 5: Configuration (postgresql.conf)](#chapter-5-configuration-postgresqlconf)
- [Chapter 6: Configuration (pg_hba.conf)](#chapter-6-configuration-pg_hbaconf)
- [Chapter 7: Initialize new instance](#chapter-7-initialize-new-instance)
- [Chapter 8: Tablespace](#chapter-8-tablespace)
- [Chapter 9: Schema](#chapter-9-schema)
- [Chapter 10: Install Extension](#chapter-10-install-extension)
- [Chapter 11: Cluster (New Instance)](#chapter-11-cluster-new-instance)
- [Chapter 12: User & Roles](#chapter-12-user-roles)
- [Chapter 13: Bloating in PostgreSQL](#chapter-13-bloating-in-postgresql)
- [Chapter 14: Write Ahead Logging (WAL)](#chapter-14-write-ahead-logging-wal)
- [Chapter 15: Logical Replication](#chapter-15-logical-replication)

---

## Chapter 1: Download & Install

[Download link for PostgreSQL](https://www.postgresql.org/download/linux/redhat/)

Following command will be get from above [Download link]
```SHELL
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf -qy module disable postgresql
dnf install -y postgresql12-server
/usr/pgsql-12/bin/postgresql-12-setup initdb
systemctl enable postgresql-12
systemctl start postgresql-12
```

Confirm PostgreSQL is successfully installed
```PSQL
su - postgres           -- Change to postgres user
psql                    -- Login to postgresql
postgres=# \du          -- Check user role
postgres=# \l           -- Check database
postgres=# \c <DB Name> -- Connect database
postgres=# \dt          -- Show tables
postgres=# SHOW ALL;    -- Show command
postgres=# \q           -- Quit
```

---

## Chapter 2: Change Data Directory

Check current setting
```PSQL
psql                                -- Login to postgresql
postgres=# SHOW data_directory;     -- Check current directory
postgres=# \q                       -- Quit
```

Stop service
```SHELL
systemctl stop postgresql-12        # Stop postgres service
systemctl status postgresql-12      # Check service status
```

Create directory
```SHELL
mkdir -p /postgres/data
chown postgres:postgres /postgres
chown postgres:postgres /postgres/data
chmod -R 750 /postgres
chmod -R 750 /postgres/data

su - postgres
cd /var/lib/pgsql/12/data/
cp -r * /postgres/data
cd /postgres/data
ls -lrt

cd /var/lib/pgsql/12/data
cp postgresql.conf postgresql.conf_org
vi postgresql.conf
```

postgresql.conf
```
data_directory = '/postgres/data/'
```

Restart service
```SHELL
systemctl start postgresql-12
systemctl status postgresql-12
tail -10f /var/log/messages
su - postgres
psql                                # Login to postgresql
postgres=# SHOW data_directory;     # Check new directory
postgres=# \q                       # Quit
```

---

## Chapter 3: Enable Remote Access

| Node   | IP Address   |
|--------|--------------|
| Server | 192.168.1.1  |
| Client | 192.168.1.2  |


Set postgres user password:
```PSQL
su - postgres
psql
postgres=# ALTER USER postgres WITH PASSWORD 'postgres';
```

Allow client access to server:
```SHELL
cp /var/lib/pgsql/12/data/pg_hba.conf /var/lib/pgsql/12/data/pg_hba.conf_org
vi /var/lib/pgsql/12/data/pg_hba.conf
```

pg_hba.conf
```
TYPE    DATABASE    USER    ADDRESS         METHOD
host    all         all     192.168.1.2/24  md5
```

Change listen address
```SHELL
cp /var/lib/pgsql/12/data/postgresql.conf /var/lib/pgsql/12/data/postgresql.conf_org
vi /var/lib/pgsql/12/data/postgresql.conf
```

postgresql.conf
```
listen_addresses ='localhost,192.168.1.1'
```

Restart service
```SHELL
systemctl restart postgresql-12
systemctl status postgresql-12
```

Allow firewall
```SHELL
systemctl status firewalld
firewall-cmd --permanent --add-port 5432/tcp && firewall-cmd --reload
```

Test from Client 192.168.1.2 to Server 192.168.1.1
```SHELL
psq -U postgres -h 192.168.1.1 -p 5432
```

---

## Chapter 4: Save password in user profile

Add user creditial in profile
```SHELL
cd /var/lib/pgsql/.pgpass
vi .pgpass
```

.pgpass
```
#hostname:port:database:username:password
localhost:5432:postgres:postgres:postgres
```

Change mode
```SHELL
chmod 0600 “/var/lib/pgsql/.pgpass”
```

---

## Chapter 5: Configuration (postgresql.conf)

Show configuration
```PSQL
su - postgres
psql
postgres=# SHOW config_file;
postgres=# SELECT name, setting FROM pg_settings;
postgres=# SELECT DISTINCT context FROM pg_settings;
postgres=# SHOW port;
postgres=# SHOW max_connections;
postgres=# \q
```

Edit configuration
```PSQL
postgres=# ALTER SYSTEM SET max_connectoin=200;
```

| Category          |   Parameter       |
|-------------------|-------------------|
| Connectoin & Authentication | listen_address; port; max_connections; superuser_reserved_connections; unix_socket_directories; unix_socket_group; unix_socket_permissions; bonjour; bonjour_name; |
| Resource Usage | shared_buffers; huge_pages; temp_buffers; max_prepared_transactions; work_mem; maintenance_work_men; autovacuum_work_mem; max_stack_depth; shared_memory_type; |
| WAL write ahead log | wal_level; fsync; synchronous_commit; wal_sync_method; |
| Replication (Sending Server, Master Server, Standby Server) | max_wal_senders; wal_keep_segments; wal_sender_timeout; |
| Query Tuning | enable_bitmapscan; enable_hashagg; enable_hashjoin; enable_indexscan; enable_indexonlyscan; enable_material; enable_mergejoin; |
| Reporting & Logging | log_destination; logging_collector; log_directory; log_filename; log_min_messages; |
| Autovacuum | autovacuum; log_autovacuum_min_duration; autovacuum_max_workers; autovacuum_naptime; |
| Client Connection | search_path; row_security; default_tablespace; temp_tablespaces; default_table_access_method; |
| Lock Management | deadlock_timeout; max_locks_per_transaction; max_pred_locks_per_transaction; |
| Version & Platform Compatibility | array_nulls; backslash_quote; escape_string_warning; lo_compat_privileges; operator_precedence_warning; |
| Error Handling | exit_on_error; restart_after_crash; data_sync_retry; |

---

## Chapter 6: Configuration (pg_hba.conf)

```PSQL
su - postgres
psql
postgres=# SHOW hba_file;
postgres=# CREATE ROLE pguser WITH LOGIN PASSWORD 'pguser';
postgres=# ALTER ROLE pguser PASSWORD 'pguser';
postgres=# DROP ROLE pguser;
postgres=# \q
```

Edit config
```SHELL
vi /var/lib/pgsql/12/data/pg_hba.conf
```

pg_hba.conf
```
TYPE    DATABASE    USER    ADDRESS         METHOD
host    all         all     192.168.1.2/24  md5
```

Host Type

| TYPE  | Explanation                                          |
|-------|------------------------------------------------------|
| local | Use for psql without hostname  (Unix-domain sockets) |
| host  | Use for remote host & local host                     |

Host Address 

| ADDRESS        | Explanation                                 |
|----------------|---------------------------------------------|
| 127.0.0.1/32   | Use for localhost IPv4 (Should same authentication method with IPv6) |
| ::1/128        | Use for localhost IPv6 (Should same authentication method with IPv4) |
| 192.168.1.2/24 | Use for Remote client                       |
| 0.0.0.0/0      | Use for All client (Should not use in production) |

Authentication Method

| METHOD   | Explanation                                       |
|----------|---------------------------------------------------|
| trust    | No need authentication                            |
| peer     | Authenticate with operation system on local connection, not support remote connection |
| ident    | Authenticate with (RFC 1413), perform as peer authentication on Unix-socket connections |
| password | Authenticate with plane text                      |
| md5      | Authenticate with encrypted passwords             |

---

## Chapter 7: Initialize new instance

Create instance
```SHELL
mkdir -p /postgres/data/instance1
/usr/pgsql-12/bin/pg_ctl -D /postgres/data/instance1 initdb
ls -lf /postgres/data/instance1
```

Start instance
```SHELL
/usr/pgsql-12/bin/pg_ctl -D /postgres/data/instance1 start
```

---

## Chapter 8: Tablespace

Create tablespace
```PSQL
mkdir -p /postgres/tbs1
su - postgres
psql
postgres=# CREATE TABLESPACE tbs1 LOCATION '/postgres/tbs1';
postgres=# \db+                     -- List table space
postgres=# \q
```

Check tablespace
```SHELL
ls -l /postgres/data/pg_tblspc/     # Default tablespace in data directory
ls -l /postgres/tbs1/               # New tablespace
```

Use tablespace
```PSQL
su - postgres
psql
postgres=# CREATE DATABASE db1 TABLESPACE tbs1;     -- Create DB with default tablespace
postgres=# \c db1                                   -- Connect db1
postgres=# CREATE TABLE tab1 (a int);               -- Create table with default tablespace
postgres=# CREATE TABLE tab2 (a int) TABLESPACE tbs1; -- Create table with tbs1
postgres=# CREATE TABLE tab3 (a int) TABLESPACE pg_default; -- Create table with pg_default tablespace
```

Modify tablespace
```PSQL
postgres=# ALTER TABLE tab1 SET TABLESPACE pg_default;
postgres=# ALTER TABLE ALL IN TABLESPACE tbs1 SET TABLESPACE pg_default;
postgres=# \dt+                     -- List table name
```

pg_default tablespace
```PSQL
postgres=# SHOW default_tablespace;
postgres=# SET default_tablespace = tbs1;
postgres=# CREATE TABLE foo (i int);
```

Backup tablespace
```SHELL
pg_basebackup --format=p --tablespace-mapping=/tmp/space1=/tmp/space1backup -D plainb
```

---

## Chapter 9: Schema

```PSQL
su - postgres
psql
postgres=# CREATE SCHEMA schema1;

postgres=# SHOW search_path;
postgres=# SET search_path TO schema1,public;
```

You should not use the public schema.
```PSQL
postgres=# ALTER ROLE ALL SET search_path = "$user"
```

---

## Chapter 10: Install Extension

Download required extension and do as their instruction
```PSQL
su - postgres
psql
postgres=# CREATE EXTENSION system_stats;       -- Install extension
postgres=# DROP EXTENSION system_stats;         -- Uninstall extension
```

---

## Chapter 11: Cluster (New Instance)

Check current instance
```SHELL
echo $PGDATA
cd $PGDATA & ls
ps xf
```

Create new directory with postgres (owner: postgres)
```SHELL
mkdir -p /var/lib/pgsql/12/data2
chown postgres:postgres /var/lib/pgsql/12/data2
chmod 700 /var/lib/pgsql/12/data2
```

Init DB
```SHELL
/usr/pgsql-12/bin/pg_ctl -D /var/lib/pgsql/12/data2 initdb
```

Modify Setting
```SHELL
vi /var/lib/pgsql/12/data2/postgresql.conf
```

postgresql.conf
```
port = 5433
```

Starting instance
```SHELL
/usr/pgsql-12/bin/pg_ctl -D /var/lib/pgsql/12/data2 -l /var/lib/pgsql/12/logfile2 start
ps xf
psql -p 5432 postgres
psql -p 5433 postgres
```

Stop & Reload
```SHELL
/usr/pgsql-12/bin/pg_ctl -D /var/lib/pgsql/12/data2 -l /var/lib/pgsql/12/logfile2 stop
/usr/pgsql-12/bin/pg_ctl -D /var/lib/pgsql/12/data2 -l /var/lib/pgsql/12/logfile2 reload
```

---

## Chapter 12: User & Roles

Create user = create role + login permission

- `CREATE USER testuser WITH PASSWORD 'password';`
- `CREATE ROLE testuser WITH LOGIN PASSWORD 'password';`

Remove default create permission on the public schema
```PSQL
su - postgres
psql
postgres=# REVOKE CREATE ON SCHEMA public FROM PUBLIC;
postgres=# REVOKE ALL ON DATABASE testdb FROM PUBLIC;
```

Create readonly role (Cannot login)
```PSQL
postgres=# \du                          -- Check current role
postgres=# CREATE ROLE app_readonly;
postgres=# \du                          -- Check new role

postgres=# GRANT CONNECT ON DATABASE app TO app_readonly;
postgres=# GRANT USAGE ON SCHEMA app_schema TO app_readonly;
postgres=# GRANT SELECT ON TABLE table1, table2 TO app_readonly;            -- Specific table select only
postgres=# GRANT SELECT ON ALL TABLES IN SCHEMA app_schema TO app_readonly; -- All table select only
postgres=# ALTER DEFAULT PRIVILEGES IN SCHEMA app_schema GRANT SELECT ON TABLES TO app_readonly;
postgres=# GRANT app_readonly TO testuser;
```

Create read/write role (Cannot login)
```PSQL
postgres=# \du                          -- Check current role
postgres=# CREATE ROLE app_readwrite;
postgres=# \du                          -- Check new role

postgres=# GRANT CONNECT ON DATABASE app TO app_readwrite;
postgres=# GRANT USAGE ON SCHEMA app_schema TO app_readwrite;
postgres=# GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA app_schema TO app_readwrite;
postgres=# ALTER DEFAULT PRIVILEGES IN SCHEMA app_schema GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO app_readwrite;

postgres=# GRANT USAGE ON ALL SEQUENCES IN SCHEMA app_schema TO app_readwrite;
postgres=# ALTER DEFAULT PRIVILEGES IN SCHEMA app_schema GRANT USAGE ON SEQUENCES TO app_readwrite;
postgres=# GRANT app_readwrite TO testuser;
```

Create app user (Can login)
```PSQL
postgres=# CREATE USER app_user1 WITH PASSWORD 'password';
```

Create role with (Can login)
```PSQL
postgres=# CREATE ROLE app_user2 WITH LOGIN PASSWORD 'password';
```

Remove role from user and Delete role
```PSQL
postgres=# REVOKE app_readwrite FROM testuser;
postgres=# DROP ROLE app_readwrite;
```

---

## Chapter 13: Bloating in PostgreSQL

When an existing record in a database is updated. It result in two actions.

1. Creation of a new record due to update
2. Existing old record results in a Dead Tuple

Bloating happens when rate of generation of tuples is more than rate of getting the dead tuples cleaned, it is known as bloat.

There are three options to solve bloating:

1. VACUUM FULL

```PSQL
postgres=# \c [db_name]
postgres=# ANALYZE VERBOSE;   -- Analysis database
postgres=# VACUUM FULL FREEZE VERBOSE ANALYZE;    -- Need down time, Lock & Blocking all operation to reclaims storage to OS. It copy table and doubling storage.
postgres=# REINDEX DATABASE [db_name];
postgres=# CLUSTER VERBOSE;
```

2. PG_REPACK

```SHELL
/usr/pgsql-12/bin/pg_repack -dry-run [db_name] --table [schema.table_name]
/usr/pgsql-12/bin/pg_repack -dry-run [db_name]              # Dry Run
/usr/pgsql-12/bin/pg_repack -d [db_name] --Full database    # Actual Run
```

3. AUTO VACUUM (Default:ON)

```PSQL
postgres=# SELECT name, setting FROM pg_settings WHERE name='autovacuum';
```

- AUTO VACUUM Parameter
    - autovacuum = on
    - log_autovacuum_min_duration = -1      # Milliseconds, -1 disables, no logs
    - autovacuum_max_workers = 3            # Restart required
    - autovacuum_naptime = 1min             # Time between autovacuum runs
    - autovacuum_vaccum_threshold = 50      # Minimum numbers of row update
    - autovacuum_analyze_threshold = 50     # Minimum numbers of row update
    - autovacuum_vacuum_scale_factor = 0.2  # Percentage of table size
    - autovacuum_analyze_scale_factor = 0.1 # Percentage of table size
    - autovacuum_vacuum_cost_delay = 20ms   # Vacuum cost delay

Check Dead Tuple
```PSQL
postgres=# \c [db_name]
postgres=# SELECT relname, last_vacuum, last_autovacuum, n_dead_tup FROM pg_stat_user_tables;
postgres=# SELECT relname AS "table_name", pg_size_pretty(pg_table_size(pgc.oid)) AS "space_used" FROM pg_class AS pgc LEFT JOIN pg_namespace AS pgns ON (pgns.oid = pgc.relnamespace) WHERE nspname NOT IN ('pg_catalog', 'information_schema') AND nspname !~ '^p g_toast' AND relkind IN ('r') ORDER BY pg_table_size(pgc.oid) DESC;
```

Random Dummy Data 1
```PSQL
postgres=# CREATE TABLE tab1 (a int);
postgres=# INSERT INTO tab1 SELECT generate_series FROM generate_series(1,1000000);
postgres=# UPDATE tab1 SET a = 0;
postgres=# DELETE FROM tab1;
```

Random Dummy Data 2
```SQL
CREATE TABLE Customers (
    ID  serial ,
    Name varchar(50) NOT NULL,
    Phone varchar(15) NOT NULL,
    Address varchar(50),
    Birthday date NOT NULL,
    CustomerEmail varchar(50) NOT NULL,
    PRIMARY KEY (ID)
);
INSERT INTO Customers( Name, Phone, Address,Birthday,CustomerEmail)
    SELECT  
        left(md5(random()::text),10), 
        left(md5(random()::text),10), 
        left(md5(random()::text),10),
        (now()+ random() * '2 days':: Interval) ::DATE,
        concat(left(md5(random()::text),6),'@domain.com')
    FROM generate_series(1,1000000);
UPDATE Customers SET address = 'ABC';
DELETE FROM Customers;
```

---

## Chapter 14: Write Ahead Logging (WAL)

```
ls -lrt /var/lib/pgsql/12/data/pg_wal
cat /var/lib/pgsql/12/data/postgresql.conf | grep wal_keep_segments
vi /var/lib/pgsql/12/data/postgresql.conf
```

- Parameter
    - wal_level = archive
    - max_wal_size = 1GB
    - wal_keep_segments = 10
    - archive_mode = on
    - archive_command = 'cp %p /mnt/nfs/%f'`
    - archive_timeout = 1h

- Archive
    - Copy file to NFS
        - `archive_command = 'cp %p /mnt/nfs/%f'`
    - Not overwriting
        - `archive_command = 'test ! -f /mnt/nfs/%f && cp %p /mnt/nfs/%f'`
    - Copy to S3 bucket
        - `archive_command = 's3cmd put %p s3://BUCKET/path/%f'`
    - Copy to GCP bucket
        - `archive_command = 'gsutil cp %p gs://BUCKEt/path/%f'`
    - An external script
        - `archive_command = '/opt/scripts/archive_wal %p'`

- WAL Level
    - minimal : Information needed to recover from a crash or immedicate shutdown
    - archive : Enough information to alllow the archival
    - replica : Information required to run read-only queries on a standby server
    - logical : Extract logical change sets from WAL

---

## Chapter 15: Logical Replication

Replicate from publisher to subscriber.

- Restriction
    - Database schema and DDL commands are not replicated.
    - Sequence data is not replicated.
    - TRUNCATE commands are not replicated. Use DELETE.
    - Large objects are not replicated.
    - Only replicate base tables to base tables. Views, partition root or foreign tables are not replicated.
    
Created two instances for Publisher and Subscriber. It can be two different servers.

| Host      | Port | Replication | Explanation                 |
|-----------|------|-------------|-----------------------------|
| localhost | 5432 | Publisher   | Master DB for Read/Write    |
| localhost | 5433 | Subscriber  | Replication and ReadOnly    |

Logical replication configuration

- Step 1: Configuration Publisher
    - `vi /var/lib/pgsql/12/data/postgres.conf`
        - `listen_addresses = '*'`
        - `wal_level = logical`
    - `vi /var/lib/pgsql/12/data/pg_hba.conf`
        - `host    all    all    192.168.1.1    md5`
    - `systemctl restart postgresql-12`
- Step 2: Create replication user & Publication
    - `CREATE TABLE tab1 (a int);`
    - `CREATE ROLE rep_user WITH REPLICATION LOGIN PASSWORD 'password';`
    - `GRANT ALL PRIVILEGES ON DATABASE [db_name] TO rep_user;`
    - `GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO rep_user;`
    - `CREATE PUBLICATION my_publication;`
    - `ALTER PUBLICATION my_publication ADD TABLE [table_name];`
- Step 3: Configuration Subscriber
    - `CREATE TABLE tab1 (a int);`
    - `CREATE SUBSCRIPTION my_subscription CONNECTION 'host=localhost port=5432 password=password user=rep_user dbname=[db_name]' PUBLICATION my_publication;`
- Step 4: Insert new row in Master DB
    - `INSERT INTO tab1 VALUES (1),(2),(3);`




