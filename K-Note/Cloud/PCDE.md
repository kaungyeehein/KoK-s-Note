# Google Cloud

## Professional Cloud Database Engineer (PCDE)

---

### Certification exam guide

| Section | Title                                                          | Exam |
|---------|----------------------------------------------------------------|------|
| 1       | Design scalable and highly available cloud database solutions  | 42%  | 
| 2       | Manage a solution that can span multiple database solutions    | 34%  |
| 3       | Migrate data solutions                                         | 14%  |
| 4       | Deploy scalable and highly available databases in Google Cloud | 10%  |

---

#### Section 1: Design scalable and highly available cloud database solutions (~42% of the exam)

1.1 Analyze relevant variables to perform database capacity and usage planning. Activities include:

- Given a scenario, perform solution sizing based on current environment workload metrics and future requirements
- Evaluate performance and cost tradeoffs of different database configurations (machine types, HDD versus SSD, etc.)
- Size database compute and storage based on performance requirements

1.2 Evaluate database high availability and disaster recovery options given the requirements. Activities include:

- Evaluate tradeoffs between multi-region, region, and zonal database deployment strategies
- Given a scenario, define maintenance windows and notifications based on application availability requirements
- Plan database upgrades for Google Cloud-managed databases

1.3 Determine how applications will connect to the database. Activities include:

- Design scalable, highly available, and secure databases
- Configure network and security (Cloud SQL Auth Proxy, CMEK, SSL certificates)
- Justify the use of session pooler services
- Assess auditing policies for managed services

1.4 Evaluate appropriate database solutions on Google Cloud. Activities include:

- Differentiate between managed and unmanaged database services (self-managed, bare metal, Google-managed databases and partner database offerings)
- Distinguish between SQL and NoSQL business requirements (structured, semi-structured, unstructured)
- Analyze the cost of running database solutions in Google Cloud (comparative analysis)
- Assess application and database dependencies

#### Section 2: Manage a solution that can span multiple database solutions (~34% of the exam)

2.1 Determine database connectivity and access management considerations. Activities include:

- Determine Identity and Access Management (IAM) policies for database connectivity and access control
- Manage database users, including authentication and access

2.2 Configure database monitoring and troubleshooting options. Activities include:

- Assess slow running queries and database locking and identify missing indexes
- Monitor and investigate database vitals: RAM, CPU storage, I/O, Cloud Logging
- Monitor and update quotas
- Investigate database resource contention
- Set up alerts for errors and performance metrics

2.3 Design database backup and recovery solutions. Activities include: 

- Given SLAs and SLOs, recommend backup and recovery options (automatic scheduled backups)
- Configure export and import data for databases
- Design for recovery time objective (RTO) and recovery point objective (RPO)

2.4 Optimize database cost and performance in Google Cloud. Activities include:

- Assess options for scaling up and scaling out.
- Scale database instances based on current and upcoming workload
- Define replication strategies
- Continuously assess and optimize the cost of running a database solution

2.5 Determine solutions to automate database tasks. Activities include:

- Perform database maintenance
- Assess table fragmentation
- Schedule database exports

#### Section 3: Migrate data solutions (~14% of the exam)

3.1 Design and implement data migration and replication. Activities include:

- Develop and execute migration strategies and plans, including zero downtime, near-zero downtime, extended outage, and fallback plans
- Reverse replication from Google Cloud to source
- Plan and perform database migration, including fallback plans and schema conversion
- Determine the correct database migration tools for a given scenario 

#### Section 4: Deploy scalable and highly available databases in Google Cloud (~10% of the exam)

4.1 Apply concepts to implement highly scalable and available databases in Google Cloud. Activities include:

- Provision high availability database solutions in Google Cloud
- Test high availability and disaster recovery strategies periodically
- Set up multi-regional replication for databases
- Assess requirements for read replicas
- Automate database instance provisioning

---

# Study Note

## Enterprise Database Migration

### 1. Migrating Enterprise Database to the Cloud

#### 1.1 Methodology Step

1. Assess
2. Plan
3. Deploy
4. Optimize

---

#### 1.2 Architecture (Most difficult to Less difficult)

- Client-server database architectures (1980s)
	- Client and Database direct connection (thin as possible)
	- Business rules & constraints by table relation, procedures and triggers
- Three-tier architectures
	- Client, Application Server and Database
	- Middle tier handles complexity
- Service-oriented architectures
	- Web Server, Firewall and Database
	- Client connect to Web Server by using http
- Microservice architectures
	- Smaller independent
	- Each service has its own database
	
---

#### 1.3 Google Cloud Database & Storage Solution

- Relational
	- Cloud SQL (Vertical scaling or Scaling up)
		- MySQL
		- PostgreSQL
		- SQL Server
	- Cloud Spanner (Horizontal scaling or Scaling out)
		- Multi-region
- NoSQL
	- Firestore
	- Memorystore (Redis)
	- Cloud Bigtable (similar Cassandra)
- Analytics
	- BigQuery
- Object
	- Cloud Storage

---

#### 1.4 Non-functional Requirement

- Availability
	- Deploying servers across more than one zone in a region or multi-region
	- Deploying load balancer with health check (regional or global)
	- One Database is main and another Database is failover (synchronized)
- Scalability
	- Write Large volume => split Database into pieces called shards (multiple nodes or servers)
		- Horizontal scaling or scaling out
	- Read replicas for analytics and reporting
		- Synchronized replication across regions => Increased latency (Strong/Immediate consistency)
		- Asynchronized replication across regions => Low latency (Eventual consistency)
- Durability
	- Backup to DR site
	
---

##### 1.4.1 Availability (ရရှိနိုင်မှု)

Availability ဆိုတာကတော့ စနစ် (သို့) ဝန်ဆောင်မှုတစ်ခုဟာ သတ်မှတ်ထားတဲ့အချိန်ကာလအတွင်း အချိန်မရွေး အသုံးပြုနိုင်စွမ်းကို ဆိုလိုပါတယ်။ ရရှိနိုင်မှုမြင့်မားဖို့ဆိုရင် ပျက်စီးမှုမျိုးစုံကို ကာကွယ်ဖို့ လိုအပ်ပါတယ်။ ဥပမာ - Server တစ်ခု အလုပ်မလုပ်တဲ့အခါမှာ Failover Mechanism တွေကို အသုံးပြုပြီး  ပြန်လည်ဆောင်ရွက်နိုင်စေခြင်း။

##### 1.4.2 Scalability (ဖွံ့ဖြိုးနိုင်မှု)

Scalability ဆိုတာကတော့ စနစ်တစ်ခုဟာ လိုအပ်ချက်အရ အင်အားကိုတိုးချဲ့နိုင်စွမ်းကို ဆိုလိုပါတယ်။ User တွေက များလာသလို၊ Data ပမာဏတွေ က ကြီးမားလာတဲ့အခါမှာ ပေါင်းထည့်နိုင်စွမ်းရှိဖို့ လိုအပ်ပါတယ်။ Scalability ကို နှစ်မျိုးခွဲခြားနိုင်ပါတယ်

- Vertical Scalability: Server တစ်ခုကို ထပ်တိုးစွမ်းဆောင်ရည်မြှင့်တင်ခြင်း။ CPU, Memory, Storage တိုးခြင်း။
- Horizontal Scalability: Server အရေအတွက်ကို ပေါင်းထည့်ခြင်း။ Server အလုံးအရေ တိုးခြင်း။

##### 1.4.3 Durability (ခံနိုင်မှု)

Durability ဆိုတာကတော့ Data တွေကို အချိန်ကြာမြင့်စွာ ပျောက်ကွယ်ခြင်းမရှိအောင် သိမ်းဆည်းထားနိုင်စွမ်းကို ဆိုလိုပါတယ်။ Durability မြင့်မားဖို့ Data Redundancy၊ Backup Strategy တွေကို သုံးစွဲရပါတယ်။ ဥပမာ - Cloud Storage Service တစ်ခုဟာ Durability အထူးမြင့်မားဖို့ Multiple Data Centers တွေမှာ Data ကို ကူးယူထားခြင်း။

Note: Data Backup work in Maintenance Time or Maintenance Windows.

---

### 2. Google Cloud Data Migration Solutions

#### 2.1 Relational Database (More Administration to Less Administration)

- **Bare Metal Solution (Dedicated HW for Oracle DB)**
	- Support all version
	- Support All autofill feature
	- Support Real Application Cluster (RAC)
	- Oracle license charges by virtual CPU (2 vCPU per CPU core)
	- GCP HW charges by physical CPU core
	- Run in google partner's data center (< 2ms)
	- Connect by Bastion host or Jump server
	- No internet access (Can setup internet Gateway)
	
- **Compute Engine**
	- Linux and Windows
	- 96 cores, 100+ GB RAM
	- Pre-config SQL Server images
	- Automated with scripts or templates (Terraform)
	- Marketplace
	
- **Kubernetes Engine (Multi-Cloud or Private Cloud or On-premises)**
	- Automation with Control Plane + Node)
	- Manual configuration for deployment
		- Persistent Volume Claim
		- Deployment
		- Service
	- Auto configuration (Helm: Package manager for Kubernetes)
	
- **Cloud SQL (Regional Managed)**
	- 96 cores, 100+ Gb RAM, 30 TB Disk space (Increase CPU, network through-put auto increase)
	- MySQL, PostgreSQL, SQL Server (charged for license)
		- Enterprise (99.95% SLA)
		- Enterprise Plus (99.99% SLA)
	- Automated backup and maintenance
		- Windows time for daily auto backup (snapshot of persistent disk)
		- Point-in-time recovery (can restore any point-in-time before disaster)
	- HA (Regional) Automatic failover to another zone (Multiple zones)
	- HDD or SSD (More expensive) Automatic increase size
	- High Volume of read (Read Replicas to multi-region)
		- Read replicas
		- Cross-region read replicas
		- Cascading read replicas
	- Cloud SQL Migration Assistant (MySQL only)
		- On-premise, Other Cloud, GCP
		
- **Cloud Spanner (Global Managed)**
	- Completely Manged (backup and maintenance, across region, horizontal scaling)
	- Regional (singal region: 99.99% SLA)
	- Multi-region (more than one region: 99.999% SLA)
		- eur3 (Belgium/Netherlands)
		- nam3 (Northern Virginia/South Carolina)
		- nam6 (Iowa/South Carolina/Oregon/Los Angeles)
		- nam-eur-asia1 (Iowa/Belgium/Taiwan)
	- 1 node per 2 TB of data (Monitor to keep under 65% CPU usage)
		
Note: Need to do lab for Read Replica

---

#### 2.2 Estimating Costs

- Compute Engine (Charge for VM)
	- vCPU, RAM, Disk space, License if applicable
- GKE (Charge for Cluster)
	- Nodes, Disk space, License if applicable
- Cloud SQL (Charge base on configuration)
	- Machine type, Disk space, HA, Replica, Backup
- Spanner (Charge for Node & Storage)
	- Nodes, Disk storage, Regional/Multi-region
- Bare Metal Solution (Subscription)
	- Right-sized HW configuration

Note: Completely managed solution like `Cloud Spanner` may initially look expensive, but when you add-in administrative overhead of other solution. It may be more cost effective than you expected.

---

### 3 Google Implementation Methodology

#### 3.1 Google Migration Methodology

1. Assess
	- Build comprehensive inventory of Apps (Database dependency each App)
	- Catalog Apps with properties and dependencies (Function dependency each Database)
	- Train and educate team
	- Build experiment and proof of concept (POC)
		- Performance
		- Scalability
		- Consistency
		- Failover
		- Network
	- Calculate total cost of ownership (TCO)
	- Choose first migration workloads
		- Balance business value with risk (Don't choose mission-critical)
		- Dependency increase, migration more difficult
		- Compliance and License 
2. Plan
	- Checklist
		1. Setup Cloud Identity account
		2. Add user and group to Cloud Identity account
		3. Setup administrator access to organization
		4. Setup billing
		5. Setup resource hierarchy
		6. Setup access control for resource hierarchy (Who, What, Which)
		7. Setup support
		8. Setup networking configuration
		9. Setup logging and monitoring
		10. Configure security setting for app and data
3. Deploy
	- Automation
		- Scripting (Shell Script)
			- Google Cloud SDK
				- gcloud, gcloud storage, bq
			- Client libraries (API)
				- Python, Java, .NET, NodeJS, etc
		- Infrastructure as Code (IaC)
			- Terraform (Multi-cloud)
		- Container Orchestration
			- Docker
			- Kubernetes
			- GKE
4. Optimize
	1. Assess new environment
	2. Optimization goals
	3. Optimize environment
	4. Measure environment
	
---

#### 3.2 Database Migration Activities

1. Transfer data from old site to new
	- Transfer time = Amount of data and bandwidth
	- Cloud Storage as staging area
		- gcloud storage command
		- Storage Transfer Service (AWS S3, Azure Storage, Other cloud buckets)
		- Transfer Service (On-premises)
		- Transfer appliance (Recommended for more than 20 TB or Longer than a week)
			- Physical Storage Device and ship it back to Google
2. Resolve data integration issues
	- ETL pipeline (Alter data before loading to database)
		- Dataflow (Managed service)
			- Apache Beam with Java or Python
		- Data Fusion (Code-free graphical tool)
			- Open-source CDAP
		- Composer (Managed workflow)
			- Apache Airflow with Python
3. Validate data migration
	- Unit test (Individual funtion, property, stored procedure, trigger, etc)
	- Integration test (Integrate with different components)
	- Regression test (New platform is consistent with older code)
4. Promote new site
	- Blue/Green deployment
	- Canary deployment
5. Retire old site

---

#### 3.3 Database Migration Approaches

(Simplest/most downtime to Least downtime/more complex)

- Scheduled maintenance (Downtime)
	- Define maintenance window for downtime
	- Migrate data to new database
	- Migrate client connection
	- Tun everything back on
- Continuous replication (Same type of Database)
	- Built-in replication tools to synchronize old to new
	- Switch client to new and retire old
- Split reading and writing (Different type of Database)
	- Clients read and write to both old and new (some amount of time)
	- Retire old
	- Require code changes on client
- Data access microservice (Different type of Database, Large number of client)
	- Encapsulate all data access in a separate service
	- Migrate all client to service
	- Service handles migration from old to new
	- This makes split reading and writing

---

### 4 Migration Strategies

- Lift and Shift VM
	- Export VM image and copy to Cloud Storage
		- Monolithic app
		- Legacy app
		- App that are virtualized
	- Migrate for Compute Engine (Automatic Completed Service)
	- Third-party migration tool
		- Assess with MigVisor (For Oracle and SQL Server)
		- Migrate with Striim (Online database migration, replica data)
- Backup and restore
	- New version of Database and Different type of Database
	- Large Database, use differential backups to minimize downtime
		1. Start Full backup and restore: take longest
		2. Then differential backups until backup-restore can be done quickly
		3. Maintenance event for database unavailable
		4. Do final backup and restore
		5. Migrate connection to new
		6. Retire old
- Live Database Migration (no downtime)
	- Database replication
		1. Old database as main
		2. Create new and configure as replica
		3. Synchronizes data with replica
		4. Migrate clients to replica and promote as main
	- Data access service to migrate large numbers of clients
		- Create Data access microservice
			1. Create service to encapsulate all data access
			2. Migrate clients to use service
			3. Replicate database and migrate service connection
		- Blue/Green deployment to migrate data access
			1. Duplicate service in cloud
			2. Test cloud service
			3. Use reverse proxy or DNS to migrate client
- Optimize database for Cloud
	- Binary data => Cloud Storage
	- Web application and session data => Firestore
	- OLAP data => BigQuery
	- Transactional data => Cloud SQL
	- Don't try to refactor application all at one, rather do it a piece at a time

---

### 5 Networking for Secure Database Connectivity

- Build secure network
	- All resources in a project
	- Custom VPC (with specific subnet)
	- Allow only known client to access database
	- Don't use external IP if not require
	- Use CIDR range as small (To reduce chance of IP conflict)
	- Always use SSL from outside Google CLoud (Within GCP encrypted by default)
- Across networks (Not external IP)
	- VPC Peering (RFC1918) (Different Organization, Project)
		- Work with Compute Engine, Kubernetes Engine, App Engine Flexible
		- Same Organization or Different Organization
		- Same Project or Different Project
		- Network Administrative separate
		- Subnet IP ranges cannot overlap
		- Transitive peering is not supported (Route cannot pass-through to third party)
	- VPNs
		- Low-volume data connection
		- Classic VPN (99.9% SLA)
		- HA VPN (99.99% SLA)
		- Support
			- Site-to-site VPN (IPSec) (1.5-3 Gbps)
				- IKEv1 and IKEv2 ciphers
			- Static routes (Classic VPN)
			- Dynamic routes (Cloud Router: BGP)
	- Interconnect (99.9% or 99.99% SLA)
		- Dedicated Interconnect (Physical connected to Google Peering Edge) (10-100 Gbps)
		- Partner Interconnect (Physical connected to Service Provider Peering Edge) (50 Mbps-10 Gbps)
	- Internet access without External IP
		- NAT Proxy using VM
		- Cloud NAT
			- Cloud Router (Regional)
	- Cloud Storage or Big Query access without External IP
		- Private Google access on Subnet configuration
	- Cloud SQL (allow private/public IPs)
		- Private IPs cannot disable due to APIs and permission after enable
- Firewall rules
	- Firewall Name: [network name]-[allow or deny]-[protocol or port]
	- Default: (All Ingress are Deny and All Egress are Allow)
	- Use Allow rules to permit ingress
	- Use Deny rules to prevent egress
- Automate network infrastructure using Terraform
	- Terraform
		- terraform init
		- terraform plan
		- terraform apply -auto-approve
		- terraform destroy -auto-approve

---

### 6 Migrating SQL Server Databases to Google Cloud

- SQL Server on Compute Engine (Lift & Shift)
	- Version (2012 to 2019)
	- Edition (Express, Web, Standard, Enterprise)
	- Shielded VM (Secure Boot, vTPM, Integrity Monitoring)
	- Additional disk (64 TB)(Pay for allocated)
		- SSD is faster
		- Standard is cheaper
	- Can setup automated Snapshot backups (best to snapshots at off-peak hours.)
		- Windows instant
			- Volume Shadow Copy Service (Online snapshot without shutting down server)
	- Best practices
		- Windows Server Advanced Firewall
		- Operation system default network setting
		- Microsoft guidance for antivirus software
		- Separate SSD persistent disk for log and data
			- Use SSD for tempdb and paging files first
		- Plan for regularly backups
			- Snapshots (can’t skip normal SQL Server maintenance)
			- Regular database and log backups
		- Cloud Monitoring agent for Microsoft Windows
	- Pre-configured VM from Marketplace
	- High Availability
		- AlwaysOn Availability Groups
			- Active Directory domain controller
			- One SQL Main Server (Failover cluster manager service)
			- One or more replicated Server (Own data replicated from main)
			- Enterprise edition
				- IP address for SQL server
				- Alias IP address or Failover Cluster
				- Alias IP address for Availability Group Listener
			- Add databases to availability groups to enable replication
		- Failover Cluster Instances
			- Microsoft Storage Spaces Direct (S2D) Virtual SAN from persistent disk (single shared storage device)
			- 2x SQL Server Enterprise edition (Active, Failover)
			- Windows Server 2016 or 2019 Datacenter editions
			- Active Directory domain controller
			- Internal Google Cloud Load Balancer
- SQL Server on Cloud SQL (Manged)
	- Run on Linux
	- Limited SQL Server version and feature
		- Not support on Linux as following
			- SQL Server Reporting Services (SSRS)
			- SQL Server Analysis Services (SSAS)
			- AD Authentication
			- Merge replication
			- Third-party distributed query
			- Linked servers
			- System extended stored procedures
			- Filetable and Filestream
			- CLR assemblies marked as Unsafe
		- Not support on Cloud SQL as following
			- SQL Server Integration Service (SSIS)
			- Bulk Insert and Openrowset
			- Always On Availability Groups
			- Database Log Shipping
			- Distributed Transaction Coordinator (MSDTC)
			- Maintenance Plans
			- Machine Learning and R Services
			- T-SQL Endpoints
			- Resource Governor
	- Edition
		- Express    (4CPU, 3.75GB RAM, 10GB)
		- Web        (16CPU,  64GB RAM, 30TB)
		- Standard   (24CPU, 104GB RAM, 30TB)
		- Enterprise (96CPU, 104GB RAM, 30TB)
	- Automates administration
		- Backup when low utilization
		- High Availability create second failover server in another zone
		- Can define maintenance windows (require reboot)
- SQL Server on GKE
	- Benefits
		- Cross-cloud and hybrid-cloud support
		- Automated creation of resources
		- Easy automation for CI/CD pipelines
		- Run the database on the same cluster as its applications
	- YAML Configure
		- Persistent Volume Claims
			1. mssql-base-volume (base volume)
			2. mssql-mdf-volume (data volume)
			3. mssql-ldf-volume (logs volume)
		- Deployment
		- Service

---

### 7 Migrating Oracle Databases to Google Cloud

- Bare Metal Solution (Oracle)
	- Support all Oracle license (Same license cost as on-premises)
	- Support all Oracle features
- Technical Specs
	- OS
		- RHEL 7.7, 8.1
		- Oracle Linux 7.7
		- SUSE 15
		- Windows 2016, 2019
		- Other
	- Hypervisor pre-installed
		- Oracle OVM 3.4.6
		- Oracle OLVM
		- Full control (Hypervisor config, license, patch, etc.)
	- Physical 16 Cores ~ 112 Cores
	- Data storage
		- All Flash NVMe
		- All Disk Storage
		- Cloud Storage for backup (Automated snapshot)
	- Network
		- High-speed connnection to GCP (100Gbps)(<2ms)
		- Client connect by VPC and VPC Peering (Using Jump Server or Bastion Host)
	- Migration
		- Oracle Native Tools
			- RMAN Data Pump
			- Transportable Tablespaces
			- Data Guard/Active Data Guard
			- GoldenGate
		- Google Native Tools
			- Oracle backup -> Cloud Storage bucket
			- Oracle backup -> Google Transfer Appliance -> Cloud Storage bucket
			- Bare Metal Solution -> Cloud Storage bucket
		- Third party Partners Tools
			- Lift and Shift tools
			- Striim for live data migration
			- Own migration scripts and procedures
	- Connection
		- Oracle Tools
			- Sqlplus client
			- SQL Developer/Toad
			- Oracle Enterprise Manager
			- etc.
		- SSH or RDP
	- HA (Oracle RAC)(99.9% SLA)
		- Regional
		- Multi-region

---

### 8 Testing and Monitoring SQL Server Database in Google Cloud

- Structural testing
	- Validate schema (table, index, foreign key, trigger, login and more)
	- Fields, data types, lengths and constraints
- Functional testing
	- All data
	- All functions
- Non-functional testing
	- Load testing for peak demand
	- Stress testing to find load at database break
- Monitoring (Cloud Logging)
	- Compute Engine VM (No need agent)
		- CPU usage
		- Network traffic
		- Disk I/O
	- Compute Engine VM (Need agent)
		- Memory usage
		- Swap usage
		- Open TCP connections
	- Application (Need agent)
		- Apache Web server
		- MySQL
		- Nginx
		- JVM
		- IIS
		- SQL Server
			- User connections
			- Transactions
			- Write transactions
	- Cloud SQL (No need agent)
		- CPU utilization
		- Storage usage
		- Memory usage
		- Read/Write operations
		- Ingress/Egress bytes
	- Logs Viewer
		- Can export to external sink (Cloud Storage, BigQuery, Pub/Sub)

---

### 9 Google Cloud Data Migration Service

Small amount => Direct transfer and Large amount => Staging transfer (Cloud Storage)

- Google Transfer service
	- Storage Transfer service (Online solution)
		- Backup from other Cloud (Amazon S3, Azure Storage, http/https)
		- Backup from on-premise
		- Store to Google Cloud Storage
		- Schedule job one time or recurring
		- Data greater than 1TB
		- Require min 300Mbps bandwidth
		- Docker-supported linux server and agent
	- gcloud command (Online solution)
		- cp, rsync
		- Data less than 1TB
	- Google Transfer Appliance (Hardware solution)
		- Encrypted automatically and remain safe until decrypted (AES256)
		- 100TB or 480TB capacity
		- Can mount as NAS
	- ETL pipelines
		- Cloud Data Fusion (Data processing & ETL pipelines)(Base on seed.run app)
			- Fully managed cloud Native Enterprise Data Integration Service
			- Clean, Match, Blend, Transform, Partition
			- Drag & Drop interface
			- Basic Edition (Development)
			- Enterprise Edition (Production & Streaming)
			- Schedule job one time or recurring
		- Cloud Composer (workflow)(Base on Apache Airflow)
			- Fully managed environment (flow with simple python code)
			- Larger work flow (detail pipeline)
			- Schedule job one time or recurring
	- Database Migration Service
		- Requirement
			- Database Migration API
			- Service Networking API
			- pglogical (PostgreSQL)
		- Source: (Connection Profile)(On-premise, Amazone, Google, Oracle)
			- MySQL
			- PostgreSQL
			- SQL Server
			- Oracle
		- Destination:
			- Cloud SQL (MySQL, PostgreSQL, SQL Server)
			- AllobyDB (PostgreSQL)
		- Job
			- One time (MySQL)
			- Continuous (MySQL, PostgreSQL)
		- Connection
			- IP allowlist (access from external)
			- Reverse-SSH tunnel via cloud-hosted VM (access from external, secure, low throughput)
			- VPC peering (VPC or VPN)
- Third-Party tools (Stream)
	- MigVisor (Assess, Plan)
		- Oracle and SQL Server
		- Database and API
		- Automatically analyze source database config, attribute, schema, object and features
	- Striim (Migrate: Deploy)
		- Online database migration
		- Replicate data to target database
		- Move bulk for historical data
		- Capture change on real-time and synchronize
		
---

### 10 Business Case

- Adaption Framework
	1. Learn: skillup technical
	2. Lead: Leadership support, Cloud governance
	3. Scale: Automate
	4. Secure: Multilayer identity
- Three phase
	1. Tactical: Individual
	2. Strategic: Broader vision
	3. Transformational: Operation

---

### Scope

- Database security
- Administration
- Test and Monitor database migration
- Automation

---

### Other Cloud Service Provider

- AWS
	- RDS (managed database solution) (auto backup, auto scaling)
		- SQL Server
		- Oracle
		- MySQL
		- Other
	- Aurora (customized MySQL)
	- EKS (Elastic Kubernetes Service)
- Azure
	- SQL Database
	- Active Directory
	- MySQL, Mongo DB
	- AKS (Azure Kubernetes Service)
- Oracle
	- All oracle features (RDS not support)
- Red Hat (Private Cloud)
	- Openshift (Kubernets)
		- Pivotal Cloud Foundry

---

# Lab

## PostgreSQL

### Pglogical

```
sudo apt install postgresql-13-pglogical

sudo su - postgres -c "gsutil cp gs://cloud-training/gsp918/pg_hba_append.conf ."
sudo su - postgres -c "gsutil cp gs://cloud-training/gsp918/postgresql_append.conf ."
sudo su - postgres -c "cat pg_hba_append.conf >> /etc/postgresql/13/main/pg_hba.conf"
sudo su - postgres -c "cat postgresql_append.conf >> /etc/postgresql/13/main/postgresql.conf"

sudo systemctl restart postgresql@13-main
```

---

```
#GSP918 - allow access to all hosts
host    all all 0.0.0.0/0   md5

#GSP918 - added configuration for pglogical database extension

wal_level = logical         # minimal, replica, or logical
max_worker_processes = 10   # one per database needed on provider node
                            # one per node needed on subscriber node
max_replication_slots = 10  # one per node needed on provider node
max_wal_senders = 10        # one per node needed on provider node
shared_preload_libraries = 'pglogical'
max_wal_size = 1GB
min_wal_size = 80MB

listen_addresses = '*'         # what IP address(es) to listen on, '*' is all
```

---

```
sudo su - postgres
psql
\c postgres;
CREATE EXTENSION pglogical;
\c orders;
CREATE EXTENSION pglogical;
\c gmemegen_db;
CREATE EXTENSION pglogical;
\l

CREATE USER migration_admin PASSWORD 'DMS_1s_cool!';
ALTER DATABASE orders OWNER TO migration_admin;
ALTER ROLE migration_admin WITH REPLICATION;

\c postgres;

GRANT USAGE ON SCHEMA pglogical TO migration_admin;
GRANT ALL ON SCHEMA pglogical TO migration_admin;

GRANT SELECT ON pglogical.tables TO migration_admin;
GRANT SELECT ON pglogical.depend TO migration_admin;
GRANT SELECT ON pglogical.local_node TO migration_admin;
GRANT SELECT ON pglogical.local_sync_status TO migration_admin;
GRANT SELECT ON pglogical.node TO migration_admin;
GRANT SELECT ON pglogical.node_interface TO migration_admin;
GRANT SELECT ON pglogical.queue TO migration_admin;
GRANT SELECT ON pglogical.replication_set TO migration_admin;
GRANT SELECT ON pglogical.replication_set_seq TO migration_admin;
GRANT SELECT ON pglogical.replication_set_table TO migration_admin;
GRANT SELECT ON pglogical.sequence_state TO migration_admin;
GRANT SELECT ON pglogical.subscription TO migration_admin;

\c orders;

GRANT USAGE ON SCHEMA pglogical TO migration_admin;
GRANT ALL ON SCHEMA pglogical TO migration_admin;

GRANT SELECT ON pglogical.tables TO migration_admin;
GRANT SELECT ON pglogical.depend TO migration_admin;
GRANT SELECT ON pglogical.local_node TO migration_admin;
GRANT SELECT ON pglogical.local_sync_status TO migration_admin;
GRANT SELECT ON pglogical.node TO migration_admin;
GRANT SELECT ON pglogical.node_interface TO migration_admin;
GRANT SELECT ON pglogical.queue TO migration_admin;
GRANT SELECT ON pglogical.replication_set TO migration_admin;
GRANT SELECT ON pglogical.replication_set_seq TO migration_admin;
GRANT SELECT ON pglogical.replication_set_table TO migration_admin;
GRANT SELECT ON pglogical.sequence_state TO migration_admin;
GRANT SELECT ON pglogical.subscription TO migration_admin;

GRANT USAGE ON SCHEMA public TO migration_admin;
GRANT ALL ON SCHEMA public TO migration_admin;

GRANT SELECT ON public.distribution_centers TO migration_admin;
GRANT SELECT ON public.inventory_items TO migration_admin;
GRANT SELECT ON public.order_items TO migration_admin;
GRANT SELECT ON public.products TO migration_admin;
GRANT SELECT ON public.users TO migration_admin;

\c gmemegen_db;

GRANT USAGE ON SCHEMA pglogical TO migration_admin;
GRANT ALL ON SCHEMA pglogical TO migration_admin;

GRANT SELECT ON pglogical.tables TO migration_admin;
GRANT SELECT ON pglogical.depend TO migration_admin;
GRANT SELECT ON pglogical.local_node TO migration_admin;
GRANT SELECT ON pglogical.local_sync_status TO migration_admin;
GRANT SELECT ON pglogical.node TO migration_admin;
GRANT SELECT ON pglogical.node_interface TO migration_admin;
GRANT SELECT ON pglogical.queue TO migration_admin;
GRANT SELECT ON pglogical.replication_set TO migration_admin;
GRANT SELECT ON pglogical.replication_set_seq TO migration_admin;
GRANT SELECT ON pglogical.replication_set_table TO migration_admin;
GRANT SELECT ON pglogical.sequence_state TO migration_admin;
GRANT SELECT ON pglogical.subscription TO migration_admin;

GRANT USAGE ON SCHEMA public TO migration_admin;
GRANT ALL ON SCHEMA public TO migration_admin;

GRANT SELECT ON public.meme TO migration_admin;

\c orders;
\dt

ALTER TABLE public.distribution_centers OWNER TO migration_admin;
ALTER TABLE public.inventory_items OWNER TO migration_admin;
ALTER TABLE public.order_items OWNER TO migration_admin;
ALTER TABLE public.products OWNER TO migration_admin;
ALTER TABLE public.users OWNER TO migration_admin;
\dt
```

---

### Postgresql on Kubernet

```
gcloud config set compute/zone "us-central1-b"
export ZONE=$(gcloud config get compute/zone)

gcloud config set compute/region "us-central1"
export REGION=$(gcloud config get compute/region)

gcloud services enable artifactregistry.googleapis.com

export PROJECT_ID=$(gcloud config list --format 'value(core.project)')
export CLOUDSQL_SERVICE_ACCOUNT=cloudsql-service-account

gcloud iam service-accounts create $CLOUDSQL_SERVICE_ACCOUNT --project=$PROJECT_ID

gcloud projects add-iam-policy-binding $PROJECT_ID \
--member="serviceAccount:$CLOUDSQL_SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com" \
--role="roles/cloudsql.admin"

gcloud iam service-accounts keys create $CLOUDSQL_SERVICE_ACCOUNT.json \
    --iam-account=$CLOUDSQL_SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com \
    --project=$PROJECT_ID

ZONE=us-central1-b
gcloud container clusters create postgres-cluster \
--zone=$ZONE --num-nodes=2

kubectl create secret generic cloudsql-instance-credentials \
--from-file=credentials.json=$CLOUDSQL_SERVICE_ACCOUNT.json

kubectl create secret generic cloudsql-db-credentials \
--from-literal=username=postgres \
--from-literal=password=supersecret! \
--from-literal=dbname=gmemegen_db

gsutil -m cp -r gs://spls/gsp919/gmemegen .
cd gmemegen

export REGION=us-central1
export PROJECT_ID=$(gcloud config list --format 'value(core.project)')
export REPO=gmemegen

gcloud auth configure-docker ${REGION}-docker.pkg.dev

gcloud artifacts repositories create $REPO \
    --repository-format=docker --location=$REGION

docker build -t ${REGION}-docker.pkg.dev/${PROJECT_ID}/gmemegen/gmemegen-app:v1 .

docker push ${REGION}-docker.pkg.dev/${PROJECT_ID}/gmemegen/gmemegen-app:v1

kubectl create -f gmemegen_deployment.yaml

kubectl get pods

kubectl expose deployment gmemegen \
    --type "LoadBalancer" \
    --port 80 --target-port 8080

kubectl describe service gmemegen

POD_NAME=$(kubectl get pods --output=json | jq -r ".items[0].metadata.name")
kubectl logs $POD_NAME gmemegen | grep "INFO"

gcloud sql connect postgres-gmemegen --user=postgres --quiet
\c gmemegen_db
select * from meme;
```

--

### Cloud SQL CMEK

```
export PROJECT_ID=$(gcloud config list --format 'value(core.project)')
gcloud beta services identity create \
    --service=sqladmin.googleapis.com \
    --project=$PROJECT_ID

export KMS_KEYRING_ID=cloud-sql-keyring
export ZONE=$(gcloud compute instances list --filter="NAME=bastion-vm" --format=json | jq -r .[].zone | awk -F "/zones/" '{print $NF}')
export REGION=${ZONE::-2}
gcloud kms keyrings create $KMS_KEYRING_ID \
    --location=$REGION

export KMS_KEY_ID=cloud-sql-key
gcloud kms keys create $KMS_KEY_ID \
 --location=$REGION \
 --keyring=$KMS_KEYRING_ID \
 --purpose=encryption

export PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} \
    --format 'value(projectNumber)')
gcloud kms keys add-iam-policy-binding $KMS_KEY_ID \
    --location=$REGION \
    --keyring=$KMS_KEYRING_ID \
    --member=serviceAccount:service-${PROJECT_NUMBER}@gcp-sa-cloud-sql.iam.gserviceaccount.com \
    --role=roles/cloudkms.cryptoKeyEncrypterDecrypter

export AUTHORIZED_IP=$(gcloud compute instances describe bastion-vm \
    --zone=$ZONE \
    --format 'value(networkInterfaces[0].accessConfigs.natIP)')
echo Authorized IP: $AUTHORIZED_IP

export CLOUD_SHELL_IP=$(curl ifconfig.me)
echo Cloud Shell IP: $CLOUD_SHELL_IP

export KEY_NAME=$(gcloud kms keys describe $KMS_KEY_ID \
    --keyring=$KMS_KEYRING_ID --location=$REGION \
    --format 'value(name)')

export CLOUDSQL_INSTANCE=postgres-orders
gcloud sql instances create $CLOUDSQL_INSTANCE \
    --project=$PROJECT_ID \
    --authorized-networks=${AUTHORIZED_IP}/32,$CLOUD_SHELL_IP/32 \
    --disk-encryption-key=$KEY_NAME \
    --database-version=POSTGRES_13 \
    --cpu=1 \
    --memory=3840MB \
    --region=$REGION \
    --root-password=supersecret!

gcloud sql instances patch $CLOUDSQL_INSTANCE \
    --database-flags cloudsql.enable_pgaudit=on,pgaudit.log=all

CREATE DATABASE orders;
\c orders;
CREATE EXTENSION pgaudit;
ALTER DATABASE orders SET pgaudit.log = 'read,write';

export SOURCE_BUCKET=gs://cloud-training/gsp920
gsutil -m cp ${SOURCE_BUCKET}/create_orders_db.sql .
gsutil -m cp ${SOURCE_BUCKET}/DDL/distribution_centers_data.csv .
gsutil -m cp ${SOURCE_BUCKET}/DDL/inventory_items_data.csv .
gsutil -m cp ${SOURCE_BUCKET}/DDL/order_items_data.csv .
gsutil -m cp ${SOURCE_BUCKET}/DDL/products_data.csv .
gsutil -m cp ${SOURCE_BUCKET}/DDL/users_data.csv .

export CLOUDSQL_INSTANCE=postgres-orders
export POSTGRESQL_IP=$(gcloud sql instances describe $CLOUDSQL_INSTANCE --format="value(ipAddresses[0].ipAddress)")
export PGPASSWORD=supersecret!
psql "sslmode=disable user=postgres hostaddr=${POSTGRESQL_IP}" \
    -c "\i create_orders_db.sql"

CREATE ROLE auditor WITH NOLOGIN;
ALTER DATABASE orders SET pgaudit.role = 'auditor';
GRANT SELECT ON order_items TO auditor;

export USERNAME=$(gcloud config list --format="value(core.account)")
export CLOUDSQL_INSTANCE=postgres-orders
export POSTGRESQL_IP=$(gcloud sql instances describe $CLOUDSQL_INSTANCE --format="value(ipAddresses[0].ipAddress)")
export PGPASSWORD=$(gcloud auth print-access-token)
psql --host=$POSTGRESQL_IP $USERNAME --dbname=orders

gcloud sql connect postgres-orders --user=postgres --quiet
\c orders
GRANT ALL PRIVILEGES ON TABLE order_items TO "student-01-af8b67e7d10f@qwiklabs.net";
\q
```

---

### Replication and Point-in-Time-Recovery

```
export CLOUD_SQL_INSTANCE=postgres-orders
gcloud sql instances describe $CLOUD_SQL_INSTANCE

date +"%R"

gcloud sql instances patch $CLOUD_SQL_INSTANCE \
    --backup-start-time=HH:MM

gcloud sql instances describe $CLOUD_SQL_INSTANCE --format 'value(settings.backupConfiguration)'

gcloud sql instances patch $CLOUD_SQL_INSTANCE \
     --enable-point-in-time-recovery \
     --retained-transaction-log-days=1

date --rfc-3339=seconds
(or)
date -u --rfc-3339=ns | sed -r 's/ /T/; s/\.([0-9]{3}).*/\.\1Z/'

export NEW_INSTANCE_NAME=postgres-orders-pitr
gcloud sql instances clone $CLOUD_SQL_INSTANCE $NEW_INSTANCE_NAME \
    --point-in-time 'TIMESTAMP'
```
