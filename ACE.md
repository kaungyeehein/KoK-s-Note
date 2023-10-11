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

Access the HTTP load balancer from Cloud Shell
```
LB_IP=[LB_IP_v4]
while [ -z "$RESULT" ] ;
do
  echo "Waiting for Load Balancer";
  sleep 5;
  RESULT=$(curl -m1 -s $LB_IP | grep Apache);
done
```

Stress test the HTTP load balancer with VM
```
Name:	stress-test
Region:	A region different but closer to us-central1
Zone:	A zone from the region
Series:	E2
Machine type:	e2-micro (2 vCPU)
Boot Disk: Custom images(mywebserver)
```

Login to VM for Stress test
```
export LB_IP=<Enter your [LB_IP_v4] here>
echo $LB_IP
ab -n 500000 -c 1000 http://$LB_IP/
```
---

### Set Up Network Load Balancer

Set the default region and zone for all resources in Cloud Shell
```
gcloud config set compute/region us-east1
gcloud config set compute/zone us-east1-d
```

Create multiple web server instances
```
  gcloud compute instances create www1 \
    --zone=us-east1-d \
    --tags=network-lb-tag \
    --machine-type=e2-small \
    --image-family=debian-11 \
    --image-project=debian-cloud \
    --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "
<h3>Web Server: www1</h3>" | tee /var/www/html/index.html'
```
```
  gcloud compute instances create www2 \
    --zone=us-east1-d \
    --tags=network-lb-tag \
    --machine-type=e2-small \
    --image-family=debian-11 \
    --image-project=debian-cloud \
    --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "
<h3>Web Server: www2</h3>" | tee /var/www/html/index.html'
```
```
  gcloud compute instances create www3 \
    --zone=us-east1-d  \
    --tags=network-lb-tag \
    --machine-type=e2-small \
    --image-family=debian-11 \
    --image-project=debian-cloud \
    --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "
<h3>Web Server: www3</h3>" | tee /var/www/html/index.html'
```

Create a firewall rule to allow external traffic to the VM instances:
```
gcloud compute firewall-rules create www-firewall-network-lb \
    --target-tags network-lb-tag --allow tcp:80
```

Check running web server
```
gcloud compute instances list
curl http://[IP_ADDRESS]
```

Create `Load Balancer`
```
gcloud compute addresses create network-lb-ip-1 \
  --region us-east1
gcloud compute http-health-checks create basic-check
gcloud compute target-pools create www-pool \
  --region us-east1 --http-health-check basic-check
gcloud compute target-pools add-instances www-pool \
    --instances www1,www2,www3
gcloud compute forwarding-rules create www-rule \
    --region  us-east1 \
    --ports 80 \
    --address network-lb-ip-1 \
    --target-pool www-pool
```

Sending traffic to instances
```
gcloud compute forwarding-rules describe www-rule --region us-east1
IPADDRESS=$(gcloud compute forwarding-rules describe www-rule --region us-east1 --format="json" | jq -r .IPAddress)
echo $IPADDRESS
while true; do curl -m1 $IPADDRESS; done
```

### Setup HTTP Load Balancer
```
gcloud compute instance-templates create lb-backend-template \
   --region=us-east1 \
   --network=default \
   --subnet=default \
   --tags=allow-health-check \
   --machine-type=e2-medium \
   --image-family=debian-11 \
   --image-project=debian-cloud \
   --metadata=startup-script='#!/bin/bash
     apt-get update
     apt-get install apache2 -y
     a2ensite default-ssl
     a2enmod ssl
     vm_hostname="$(curl -H "Metadata-Flavor:Google" \
     http://169.254.169.254/computeMetadata/v1/instance/name)"
     echo "Page served from: $vm_hostname" | \
     tee /var/www/html/index.html
     systemctl restart apache2'
gcloud compute instance-groups managed create lb-backend-group \
   --template=lb-backend-template --size=2 --zone=us-east1-d
gcloud compute firewall-rules create fw-allow-health-check \
  --network=default \
  --action=allow \
  --direction=ingress \
  --source-ranges=130.211.0.0/22,35.191.0.0/16 \
  --target-tags=allow-health-check \
  --rules=tcp:80
gcloud compute addresses create lb-ipv4-1 \
  --ip-version=IPV4 \
  --global
gcloud compute addresses describe lb-ipv4-1 \
  --format="get(address)" \
  --global
gcloud compute health-checks create http http-basic-check \
  --port 80
gcloud compute backend-services create web-backend-service \
  --protocol=HTTP \
  --port-name=http \
  --health-checks=http-basic-check \
  --global
gcloud compute backend-services add-backend web-backend-service \
  --instance-group=lb-backend-group \
  --instance-group-zone=us-east1-d \
  --global
gcloud compute url-maps create web-map-http \
    --default-service web-backend-service
gcloud compute target-http-proxies create http-lb-proxy \
    --url-map web-map-http
gcloud compute forwarding-rules create http-content-rule \
   --address=lb-ipv4-1\
   --global \
   --target-http-proxy=http-lb-proxy \
   --ports=80
```
