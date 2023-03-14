# Cloud Digital Leader

## Course 1
### Introduction to Digital Transformation with Google Cloud

- Module 1: Why cloud technology is revolutionizing business
- Module 2: Digital transformation with Google Cloud
- Module 3: Scaling the innovation mindset

[`Compute Engine`](#compute-engine),
[`Google Kubernetes Engine`](#google-kubernetes-engine),
[`Cloud Run`](#cloud-run),
[`App Engine`](#app-engine),
[`Cloud Functions`](#cloud-functions),
[`Cloud CDN`](#cloud_cdn),
[`Anthos`](#anthos)

## Course 2
### Innovating with Data and Google Cloud

- Module 1: The value of data
- Module 2: Data consolidation and analytics
- Module 3: Innovation with machine learning

[`Cloud Database`](#cloud-database),
[`Data Lake`](#data-lake), 
[`Data Warehouse`](#data-warehouse), 
[`Streaming Analytics`](#streaming-analytics), 
[`Business Intelligence`](#business-intelligence),
[`Machine Learning`](#machine-learning)

## Course 3
### Infrastructure and Application Modernization with Google Cloud

- Module 1: Modernizing IT infrastructure with Google Cloud
- Module 2: Modernizing applications with Google Cloud
- Module 3: The value of APIs

## Course 4
### Understanding Google Cloud Security and Operations

- Module 1: Financial governance in the cloud
- Module 2: Security in the cloud
- Module 3: Monitoring cloud IT services and operations

---

## Google Products

### Compute Engine

- Virtual Machines (`VM`), `GPU`, `TPU`, `Disk`
- Scale out workloads (T2A, T2D) is `Lowest Cost`
- General purpose workloads (E2, N2, N2D, N1) for `Development and Testing`
- Ultra-high memory (M2, M1) for `SAP HANA`
- Compute-intensive workloads (C3, C2, C2D) for `Game Server`, and `Latency-sensitive API`
- Most demanding applications and workloads (A2) for `ML`

### Google Kubernetes Engine

Deploy, manage, and scale containerized applications
- `Fully managed`, `Autopilot`, `4-way Autoscaling`, `Multi-cluster`

### Cloud Run

- Faster than [`App Engine`](#app-engine), `Container`, `Serverless`, `Clusterless`, `Deploy & Host`
- `Fully Managed`, `Auto-scales` (automatically scale to 0 when not in use), `15 min timeout`
- Build and deploy scalable `Containerized Apps` written in any language (including `Go`, `Python`, `Java`, `Node.js`, `.NET`, and `Ruby`)

### App Engine

- Run App on `VM`, `Container`
- `Zero server management` and `Zero configuration deployments` (`Serverless`)
- `Fully Managed`, `Auto-scaling`, and `Manual scaling`, `24 hr timeout`
- Build your application in `Node.js`, `Java`, `Ruby`, `C#`, `Go`, `Python`, or `PHP` (Popular programming languages) 

### Cloud Functions

- `Lightweight`, `Event Driving`, `Serverless`

### Cloud CDN

Content Delivery Network is deliver Web and video content with global scale and reach.
- `Fast`, `Reliable`, `Caching`

### Anthos

Anthos is the leading cloud-centric container platform
- `GCP`, `GDC`, `On-Premises`, `Multi-Cloud` (AWS, Azure)

### Cloud Database

- RDBMS [`Cloud Sql`](#cloud-sql), [`Cloud Spanner`](#cloud-spanner), [`AlloyDB`](#alloydb)
- NoSQL [`Firestore`](#firestore), [`Cloud Bigtable`](#cloud-bigtable)

### Data Warehouse

- Can store `Structured` and `Semi-structured` (current and historical)
- Can perform `Analysis` (Big-data) and `Reporting` (visualization) (eg. ad-hoc analysis, monthly, tracking, traffic, real-time, Streaming report, Data mining, science)
- Related [`BigQuery`](#bigquery), [`Dataproc`](#dataproc) and [`Dataflow`](#dataflow)

### Data Lake

- Can store `Structured`, `Semi-structured` and `Unstructured` (No Size Limits)
- Can perform `Any Data` from `Any System` at `Any Speed` in `Real-time` or `Batch mode` (eg. big data for AI, ML)
- Can analyze data using `SQL`, `Python`, `R`, or `any other language, third-party`
- Related [`BigQuery`](#bigquery), [`Dataproc`](#dataproc), [`Dataflow`](#dataflow), [`Cloud Data Fusion`](#cloud-data-fusion) and [`Cloud Storage`](#cloud-storage)

### Streaming Analytics

- Data in `Small sizes` (often in kilobytes) in a `Continuous Flow` (real-time insights)
- Related [`Pub/Sub`](#pubsub), [`Dataflow`](#dataflow), and [`BigQuery`](#bigquery)

### Business Intelligence

- BI `Collect` and `Analyze data`
- Categories `On-premises`, `Open source` and `Cloud-based`
- Related [`BigQuery`](#bigquery) and [`Looker`](#looker)

### Machine Learning

- Subset of artificial intelligence
- Autonomously learn and improve using `Neural Networks` and `Deep Learning`
- Related `AI Hub`, `AI Platform`, `AI Building BLocks`, `AI Infrastructure`, `Cloud TPU`, `TensorFlow` and `Vertex AI`

### BigQuery

- `Serverless` and `Multi Clouds` with `BI`, `ML` and `AI`
- Can perform  `Structured`, `Semi-structured` and `Unstructured` with `Enterprise Data Warehouse`
- Related `SQL`, `Vertex AI`, [`Dataflow`](#dataflow), [`Looker`](#looker)

### Dataflow

- `Stream` and `Batch` data processing with `Serverless`
- Feature `Autoscaling`, `Stream analytics`, `Real-time AI`
- Related `Python`, `SQL`, `Apache Beam SDK`, `TensorFlow`, [`Pub/Sub`](#pubsub), [`BigQuery`](#bigquery), `IoT platform`

### Dataproc

- Fully managed and automated `Big Data` open source software
- `Serverless`, or `Manage Clusters` with with `Kubernetes`
- `Apache Hadoop`, `Apache Spark`, `Apache Flink`, `Presto`, and 30+ open source tools and frameworks
- Related `Vertex AI`, [`BigQuery`](#bigquery), [`Data Lake`](#data-lake), `Dataplex`, [`Cloud Spanner`](#cloud-spanner), [`Pub/Sub`](#pubsub) and [`Cloud Data Fusion`](#cloud-data-fusion) 

### Cloud Data Fusion

Fully managed, cloud-native data integration at any scale.
- Code-free deployment (drag-and-drop interface) of ETL/ELT data pipelines
- `Serverless` and pre-built 150+ library for batch and real-time
- Related [`Data Lake`](#data-lake)

### Cloud Storage

- Can store `Unstructured` data
- Options `Standard` (Hot data), `Nearline` (30 Days), `Coldline` (90 Days) and `Archival` (365 Days)
- Feature `Object Lifecycle Management` (OLM) and `Autoclass` for static content or static media (audio or video)
- Related [`Data Warehouse`](#data-warehouse), [`BigQuery`](#bigquery), [`Dataproc`](#dataproc), `ML` and `AI`

### Pub/Sub

Scalable messaging or queue system (pull and push modes)
- Streaming into `BigQuery`, `Data Lakes` with `Dataflow`
- Related `Cloud Functions`, `App Engine`, `Cloud Run`

### Looker

Easy to build insight-powered workflows and applications
- `Real-time` view of your data, from across `Multiple Clouds`
- `Looker’s SDK`, `APIs`, and `Looker Blocks`
- Feature `LookML` (SQL), `Looker Studio`, `Looker API` (RESTful) and `Looker Blocks` (Template)

### Cloud SQL

- Relational Database service with `MySQL`, `PostgreSQL` and `SQL Server`
- Can store `Structured`
- `Fully Managed`

### Cloud Spanner

- Relational Database service with `GoogleSQL` and `PostgreSQL`
- Can store `Structured`
- `Fully Managed`, `Autoscaling` and `High Availability`

### AlloyDB

- Relational Database service with `PostgreSQL` compatible database
- Can store `Structured`
- `Fully Managed`, `Superior performance, availability, and scale`

### Firestore

- NoSQL database
- Can store `Structured`
- `Autoscaling`, `High Performance`, `Easy to use`, `Real-time`, `Mobile App`

### Cloud Bigtable

- NoSQL database
- Can store `Structured`
- `Fully Managed`, `High Performance`, `High Scalability`

---

### Short Text

- Google Cloud Product (GCP)
- Google Distributed Cloud (GDC)
- Business Intelligence (BI)
- Machine Learning (ML)
- Artificial Intelligence (AI)
- Natural Language Processing (NLP)
- Enterprise Data Warehouse (EDW)
- Extract, Transform, Load (ETL)
- Extract, Load, Transform (ELT)
- Cloud Identity and Access Management (IAM)
- Personally Identifiable Information (PII)
- Continuous Integration (CI)
- Continuous Delivery (CD)
- Continuous Training (CT)
- Flexible Resource Scheduling (FlexRS)
- Google Kubernetes Engine (GKE)
- Looker’s Modeling Language (LookerML)
