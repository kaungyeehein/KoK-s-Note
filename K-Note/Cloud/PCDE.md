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

## Study Note

### Enterprise Database Migration

#### Methodology

- Assess
- Plan
- Deploy
- Optimize

#### Architecture (Most difficult to Less difficult)

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

#### Database for Cloud

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

Architect for:

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

##### Availability (ရရှိနိုင်မှု)

Availability ဆိုတာကတော့ စနစ် (သို့) ဝန်ဆောင်မှုတစ်ခုဟာ သတ်မှတ်ထားတဲ့အချိန်ကာလအတွင်း အချိန်မရွေး အသုံးပြုနိုင်စွမ်းကို ဆိုလိုပါတယ်။ ရရှိနိုင်မှုမြင့်မားဖို့ဆိုရင် ပျက်စီးမှုမျိုးစုံကို ကာကွယ်ဖို့ လိုအပ်ပါတယ်။ ဥပမာ - Server တစ်ခု အလုပ်မလုပ်တဲ့အခါမှာ Failover Mechanism တွေကို အသုံးပြုပြီး  ပြန်လည်ဆောင်ရွက်နိုင်စေခြင်း။

##### Scalability (ဖွံ့ဖြိုးနိုင်မှု)

Scalability ဆိုတာကတော့ စနစ်တစ်ခုဟာ လိုအပ်ချက်အရ အင်အားကိုတိုးချဲ့နိုင်စွမ်းကို ဆိုလိုပါတယ်။ User တွေက များလာသလို၊ Data ပမာဏတွေ က ကြီးမားလာတဲ့အခါမှာ ပေါင်းထည့်နိုင်စွမ်းရှိဖို့ လိုအပ်ပါတယ်။ Scalability ကို နှစ်မျိုးခွဲခြားနိုင်ပါတယ်

	- Vertical Scalability: Server တစ်ခုကို ထပ်တိုးစွမ်းဆောင်ရည်မြှင့်တင်ခြင်း။ CPU, Memory, Storage တိုးခြင်း။
	- Horizontal Scalability: Server အရေအတွက်ကို ပေါင်းထည့်ခြင်း။

##### Durability (ခံနိုင်မှု)

Durability ဆိုတာကတော့ Data တွေကို အချိန်ကြာမြင့်စွာ ပျောက်ကွယ်ခြင်းမရှိအောင် သိမ်းဆည်းထားနိုင်စွမ်းကို ဆိုလိုပါတယ်။ Durability မြင့်မားဖို့ Data Redundancy၊ Backup Strategy တွေကို သုံးစွဲရပါတယ်။ ဥပမာ - Cloud Storage Service တစ်ခုဟာ Durability အထူးမြင့်မားဖို့ Multiple Data Centers တွေမှာ Data ကို ကူးယူထားခြင်း။

Maintenance Time = Maintenamce Windows

### Database Migration Solutions

- Relational Database (More Administration to Less Administration)
	- Bare Metal Solution (For Oracle)
	- Compute Engine
		- Linux and Windows
		- 96 cores, 100+ GB RAM
		- Pre-config SQL Server images
		- Automated with scripts or templates (Terraform)
		- Marketplace
	- Kubernetes Engine (Automation with Control Plane + Node)
		- Manual configuration for deployment
			- Persistent Volume Claim
			- Deployment
			- Service
		- Auto configuration (Helm: Package manager for Kubernetes)
	- Cloud SQL
		- 96 cores, 30 TB Disk space
		- HA for Failover
		- Automated backup and maintenance
		- MySQL, PostgreSQL, SQL Server (charged for license)
	- Cloud Spanner

#### Database security

#### Administration

- SQL Server
- Oracle databases

#### Test and Monitor database migration

#### Automation

---

#### Other Cloud Service Provider

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

