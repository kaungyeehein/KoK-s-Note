# Google Cloud

## Professional Cloud Architech (PCA)

---

### Certification exam guide

| Section | Title                                                     | Exam |
|---------|-----------------------------------------------------------|------|
| 1       | Designing and planning a cloud solution architecture      | 24%  | 
| 2       | Managing and provisioning a solution infrastructure       | 15%  |
| 3       | Designing for security and compliance                     | 18%  |
| 4       | Analyzing and optimizing technical and business processes | 18%  |
| 5       | Managing implementation                                   | 11%  |
| 6       | Ensuring solution and operations reliability              | 14%  |

Note: Each exam includes 2 case studies for (20~30% of Exam).

---

#### Section 1: Designing and planning a cloud solution architecture (~24% of the exam)

1.1 Designing a solution infrastructure that meets business requirements. Considerations include:

- Business use cases and product strategy
- Cost optimization
- Supporting the application design
- Integration with external systems
- Movement of data
- Design decision trade-offs
- Build, buy, modify, or deprecate
- Success measurements (e.g., key performance indicators [KPI], return on investment [ROI], metrics)
- Compliance and observability

1.2 Designing a solution infrastructure that meets technical requirements. Considerations include:

- High availability and failover design
- Elasticity of cloud resources with respect to quotas and limits
- Scalability to meet growth requirements
- Performance and latency

1.3 Designing network, storage, and compute resources. Considerations include:

- Integration with on-premises/multicloud environments
- Cloud-native networking (VPC, peering, firewalls, container networking)
- Choosing data processing technologies
- Choosing appropriate storage types (e.g., object, file, databases)
- Choosing compute resources (e.g., preemptible, custom machine type, specialized workload)
- Mapping compute needs to platform products

1.4 Creating a migration plan (i.e., documents and architectural diagrams). Considerations include:

- Integrating solutions with existing systems
- Migrating systems and data to support the solution
- Software license mapping
- Network planning
- Testing and proofs of concept
- Dependency management planning

1.5 Envisioning future solution improvements. Considerations include:

- Cloud and technology improvements
- Evolution of business needs
- Evangelism and advocacy

---

#### Section 2: Managing and provisioning a solution infrastructure (~15% of the exam)

2.1 Configuring network topologies. Considerations include:

- Extending to on-premises environments (hybrid networking)
- Extending to a multicloud environment that may include Google Cloud to Google Cloud communication
- Security protection (e.g. intrusion protection, access control, firewalls)

2.2 Configuring individual storage systems. Considerations include:

- Data storage allocation
- Data processing/compute provisioning
- Security and access management
- Network configuration for data transfer and latency
- Data retention and data life cycle management
- Data growth planning

2.3 Configuring compute systems. Considerations include:

- Compute resource provisioning
- Compute volatility configuration (preemptible vs. standard)
- Network configuration for compute resources (Google Compute Engine, Google Kubernetes Engine, serverless networking)
- Infrastructure orchestration, resource configuration, and patch management
- Container orchestration

 ---

#### Section 3: Designing for security and compliance (~18% of the exam)

3.1 Designing for security. Considerations include:

- Identity and access management (IAM)
- Resource hierarchy (organizations, folders, projects)
- Data security (key management, encryption, secret management)
- Separation of duties (SoD)
- Security controls (e.g., auditing, VPC Service Controls, context aware access, organization policy)
- Managing customer-managed encryption keys with Cloud Key Management Service
- Remote access

3.2 Designing for compliance. Considerations include:

- Legislation (e.g., health record privacy, children’s privacy, data privacy, and ownership)
- Commercial (e.g., sensitive data such as credit card information handling, personally identifiable information [PII])
- Industry certifications (e.g., SOC 2)
- Audits (including logs)

---

#### Section 4: Analyzing and optimizing technical and business processes (~18% of the exam)

4.1 Analyzing and defining technical processes. Considerations include:

- Software development life cycle (SDLC)
- Continuous integration / continuous deployment
- Troubleshooting / root cause analysis best practices
- Testing and validation of software and infrastructure
- Service catalog and provisioning
- Business continuity and disaster recovery

4.2 Analyzing and defining business processes. Considerations include:

- Stakeholder management (e.g. influencing and facilitation)
- Change management
- Team assessment / skills readiness
- Decision-making processes
- Customer success management
- Cost optimization / resource optimization (capex / opex)

4.3 Developing procedures to ensure reliability of solutions in production (e.g., chaos engineering, penetration testing)

---

#### Section 5: Managing implementation (~11% of the exam)

5.1 Advising development/operation teams to ensure successful deployment of the solution. Considerations include:

- Application development
- API best practices
- Testing frameworks (load/unit/integration)
- Data and system migration and management tooling

5.2 Interacting with Google Cloud programmatically. Considerations include:

- Google Cloud Shell
- Google Cloud SDK (gcloud, gsutil and bq)
- Cloud Emulators (e.g. Cloud Bigtable, Datastore, Spanner, Pub/Sub, Firestore)

---

#### Section 6: Ensuring solution and operations reliability (~14% of the exam)

6.1 Monitoring/logging/profiling/alerting solution
6.2 Deployment and release management
6.3 Assisting with the support of deployed solutions
6.4 Evaluating quality control measures

---

### Compute

- Bare Metal Solution
- VMware Engine
- Google Compute Engine (GCE)
    - Standard VM
        - General-purpose workloads: N4, N2, N2D, N1, C3, C3D, E2, Tau T2D, Tau T2A
        - Storage-optimized: Z3
        - Compute-optimized: H3, C2, C2D
        - Memory-optimized: X4, M3, M2, M1
        - Accelerator-optimized: A3, A2, G2
    - Preemptible VM (Only run 24 hr)
        - Spot VM (latest version: No max limit)
    - Managed Instance Groups (MIGs)
    - Sole-tenant Nodes (Dedicated Host)
- Google Kubernet Engine (GKE): Pod, Deployment, StatefulSets, DaemonSets, and Jobs.
    - Autopilot 
    - Standard
- App Engine (Based on GKE) Stateful
    - Standard environment (Go, Java, Node.js, Php, Python, Ruby)
    - Flexible environment (Standard, .Net, Custom runtimes)
- Cloud Run (Based on K-Native) Stateless
- Cloud Function
    - Event-driven architectures

### Storage

- Object Store
    - Cloud Storage
        - Standard Class
        - Nearline Class (1 month)
        - Coldline Class (3 months)
        - Archive Class (1 year)
- Block Store
    - Persistent Disk
        - Standard: HDD
        - Balance: SSD
        - Performance: SSD
        - Extreme: SSD
    - Local SSD
- File Store (NAS)
    - Filestore
        - Basic Tier
        - High Scale Tier

### Database

- Relational
    - Cloud SQL
    - Cloud Spanner
    - Bare Metal Solution
- Non Relational (NoSQL)
    - Firestore (Firebase) 
        - Datastore mode
        - Native mode
    - Cloud Bigtable
        - 10ms latency
        - Petabyte scale
    - Memorystore
    
### Data Analytics

- Capture
    - Cloud Pub/Sub
    - Data Transfer Service
    - Storage Transfer Service
    - Cloud IoT Core
- Process
    - Cloud Dataflow
    - Cloud Dataproc
    - Cloud Dataprep
- Store
    - Cloud Storage (Data Lake)
    - BigQuery Storage (Data Warehouse)
- Analyze
    - BigQuery Analysis Engine
- Use
    - Vertex AI
    - Tensorflow
    - Looker
    - Data Studio
- Other
    - Cloud Data Fusion
    - Data Catalog
    - Data Stream
    - Cloud Composer

### DevOps

- Cloud Source Repository
- Cloud Code
- Cloud Build
- Artifact Registry
- Container Registry 
- Cloud Deploy
- Cloud Monitoring
- Cloud Logging

### Cloud Ops

- Cloud Trace
- Cloud Profiler
- Cloud Debugger

### Networking

- Connect
    - VPC
        - Flow logs (Logs Explorer, Flow Analyzer)
        - Private Google Access (Subnet)
            - Google APIs and services
            - Only has an internal IP address
    - VPC to VPC
        - Shared VPC (Same Organization)
        - VPC Network Peering (Diff Organization)
    - VPC to On-premise
        - Cloud VPN (Low bandwidth using IPsec)
            - HA VPN
            - Classic VPN
        - Dedicated Interconnect (Technical requirements exist)
        - Partner Interconnect (Connect using a service provider)
        - Cross-Cloud Interconnect (Multi-cloud)
    - On-premise to G-suite and Google APIs
        - Direct Peering (Connect to Google Service Edge location)
        - Carrier Peering (Connect using a service provider)
    - Cloud Router
        - Border Gateway Protocol (BGP) over Cloud Interconnect connections and Cloud VPN gateways
    - RFC 1918
        - Class A: 10.x.x.x
        - Class B: 172.16.x.x
        - Class C: 192.168.x.x
    - Cloud DNS
- Secure
    - Cloud Armor (DDoS protections for External LB)
    - Firewall
        - Network Tags
    - Packet Mirroring
    - Cloud IAP (Identity-Aware Proxy)
    - Service perimeter (VPC Service Controls)
        - Enforced mode (Denied)
        - Dry run mode (Allowed but logged)
    - Cloud NAT
- Scale
    - Cloud Load Balancer
        - Application Load Balancers: (HTTP(S)) proxy-based Layer 7 with URL map
        
            | Application LB | Built on                  | Multi-Region              | Single-Region      |
            |----------------|---------------------------|---------------------------|--------------------|
            | Enternal       | GFE or Envoy proxies      | Global, Classic (http(s)) | Regional (http(s)) |
            | Internal       | Andromeda and Envoy proxy | Cross-region (http(s))    | Regional (http(s)) |

        - Network Load Balancers: (TCP, UDP, ESP, GRE, and ICMP) Layer 4 load balancer with TLS
            - Proxy Network Load Balancers (TCP/SSL)
            
                | Proxy Network LB | Built on                  | Multi-Region              | Single-Region  |
                |------------------|---------------------------|---------------------------|----------------|
                | Enternal         | GFE or Envoy proxies      | Global, Classic (tcp/ssl) | Regional (tcp) |
                | Internal         | Andromeda and Envoy proxy | Cross-region (tcp)        | Regional (tcp) |

            - Passthrough Network Load Balancers with direct server return (DSR)
            
                | Passthrough Network LB | Built on  | Multi-Region | Single-Region                         |
                |------------------------|-----------|--------------|---------------------------------------|
                | Enternal               | Maglev    |              | Regional (tcp, udp, esp, gre, icmp)   |
                | Internal               | Andromeda |              | Regional (tcp, udp, esp, gre, icmp)   |

        `Global: Advanced traffic management` `Classic: Basic traffic management`
        
    - Cloud CDN
    
- Optimize
    - Premium Tier (Google's premium backbone)
    - Standard Tier (Regular ISP networks)
    - Network Intelligence Center
        - Network Topology
        - Connectivity Tests
        - Performance Dashboard
        - Firewall Insights
        - Network Analyzer
        - Flow Analyzer
- Modenize
    - GKE Networking
        - On-prem
        - In Anthos
    - Traffic Director
    - Service Directory

### AI/ML

- AI Solution
    - Recommendation AI
    - Document AI
    - Contact Center AI
    - Dialoglow Cx
- Pre-trained APIs
    - Vision
    - Video Intelligence
    - Translation
    - Natural Language
    - Speech-To-Text
    - Text-To-Speech
- Training
    - BigQuery ML
    - Vertex Training
    - AutoML in Vertex AI

### Security

- Secure boot and vTPM
- Security Command Center
- Identity and Access Management (IAM)
- Binary Authorization
- Data Loss Prevention (Cloud DLP API)
- Cloud Armor

### Operation

- Billing
    - labels (categorization and insight)

---

- Migrate for Compute Engine
- Anthos
    - Migrate to Containers (Migrate for Anthos)
- Apigee
- Terraform
    1. **Scope**: Confirm resource required
    2. **Author**: Configuration files based on Scope
    3. **Initialize**: Download the provider plugin & initialize directory
    4. **Plan**: View execution plan for resource
        - Created
        - Modified
        - Destroyed
    5. **Validate**: Check organization policy (CI/CD)
    6. **Apply**: Create actual infractructure resource