# Google Cloud
## Associate Cloud Engineer (ACE)
---

## Interacting with Google Cloud

### Cloud Shell

Create google cloud storage
```
gcloud storage buckets create gs://<BUCKET_NAME>
[OR]
gsutil mb gs://<BUCKET_NAME>
```

Copy file from `Cloud Shell` to storage buckets
```
gcloud storage cp [MY_FILE] gs://[BUCKET_NAME]
[OR]
gsutil cp [MY_FILE] gs://[BUCKET_NAME]
```

Setup default variable name
```
gcloud compute regions list
mkdir infraclass
touch infraclass/config
```

Write value in config 
```
echo INFRACLASS_REGION=[region] >> ~/infraclass/config
echo INFRACLASS_PROJECT_ID=[project_id] >> ~/infraclass/config
```

Edit `nano .profile` file and add at end
```
source infraclass/config
```

### Infrastructure Preview

Jenkin install from Marketplace
```
sudo /opt/bitnami/ctlscript.sh stop
sudo /opt/bitnami/ctlscript.sh restart
```

### Virtual Network

---

## Scaling and Automation

### HTTP/HTTPS Load Balancer

Create `Firewall Rule` for Health Check
```
Name:	fw-allow-health-checks
Network:	default
Targets:	Specified target tags
Target tags:	allow-health-checks
Source filter:	IPv4 ranges
Source IPv4 ranges:	130.211.0.0/22 and 35.191.0.0/16
Protocols and ports:	tcp and specify port 80
```

Create `Cloud NAT` configuration using Cloud Router
```
Gateway name:	nat-config
Network:	default
Region:	us-central1
Cloud Router: nat-router-us1
```

Create a `VM`
```
Name:	webserver
Region:	us-central1
Zone:	us-central1-c
Boot disk: Debian GNU/Linux 10 (buster)
Boot disk (Deletion rule): Keep boot disk
Network tags: allow-health-checks
Network interfaces: default
External IPv4 IP: None
```

Customize the `VM`
```
sudo apt-get update
sudo apt-get install -y apache2
sudo service apache2 start
curl localhost
sudo update-rc.d apache2 enable
```

Delete VM and Create `Image`
```
Name:	mywebserver
Source:	Disk
Source disk:	webserver
```

Create `Instance template`
```
Name: mywebserver-template
Series: E2
Machine type: e2-micro (2 vCPU)
Boot disk: Custom images (mywebserver)
Network tags: allow-health-checks
Network interfaces: default
External IPv4 IP: None
```

Create the `Health checks` for managed instance groups
```
Name:	http-health-check
Protocol:	TCP
Port:	80
```

Create the managed `Instance groups` at us
```
Name:	us-1-mig
Instance template:	mywebserver-template
Location:	Multiple zones
Region:	us-central1
Autoscaling: 1(min), 2(max)
Signal type: HTTP load balancing utilization
Target HTTP load balancing utilization: 80
Initialization period: 60
Autohealing: http-health-check (TCP)
Initial delay: 60
```

Create the managed `Instance groups` at europe
```
Name:	europe-1-mig
Instance template:	mywebserver-template
Location:	Multiple zones
Region:	europe-central2
Autoscaling: 1(min), 2(max)
Signal type: HTTP load balancing utilization
Target HTTP load balancing utilization: 80
Initialization period: 60
Autohealing: http-health-check (TCP)
Initial delay: 60
```

Create `Load Balancer` with Application Load Balancer (HTTP/S)
```
From Internet to my VMs or serverless services
Global external Application Load Balancer

Name: http-lb

Frontend configuration
----------------------
[IPv4 Setting]
Protocol:	HTTP
IP version:	IPv4
IP address:	Ephemeral
Port:	80

Add Frontend IP and Port
[IPv6 Setting]Protocol:	HTTP
IP version:	IPv6
IP address:	Auto-allocate
Port:	80

Backend Configuration
---------------------
Backend services & backend buckets > Create a Backend Service

Name:	http-backend
Backend type:	Instance group

Instance group:	us-1-mig
Port numbers:	80
Balancing mode:	Rate
Maximum RPS:	50
Capacity:	100

Instance group:	europe-1-mig
Port numbers:	80
Balancing mode:	Utilization
Maximum backend utilization:	80
Capacity:	100

Health Check: http-health-check
Enable logging: On
Sample rate: 1
```
