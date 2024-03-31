# Terraform On GCP

<div style="text-align: right;">KaungYeeHein's Note<br/>2024-Jan-31</div>

## Table of Contents
- [Chapter 1: IaC Configuration Workflow](#chapter-1-iac-configuration-workflow)
- [Chapter 2: Terraform Workflow](#chapter-2-terraform-workflow)
- [Chapter 3: Terraform Command](#chapter-3-terraform-command)
- [Chapter 4: Meta Arguments](#chapter-4-meta-arguments)
- [Chapter 5: Variables](#chapter-5-variables)
- [Chapter 6: Module](#chapter-6-module)
- [Chapter 7: Terraform State](#chapter-7-terraform-state)

---

## Chapter 1: IaC Configuration Workflow

1. Scope: Confirm resource required
2. Author: Configuration files based on Scope
3. Initialize: Download the provider plugin & initialize directory
4. Plan: View execution plan for resource
	- Created
	- Modified
	- Destroyed
	
- Validate: Check organization policy (CI/CD)

5. Apply: Create actual infractructure resource

---

## Chapter 2: Terraform Workflow

1. Create Configuration File: `*.tf`
2. Define Provider: `terraform init` (Download provider plugin)
3. Verify Plan: `terraform plan`
4. Apply: `terraform apply` (added, changed, destroyed)

#### Author

`*.tf`: HashiCorp Configuration Language (HCL)

```
- Root Dir
	- main.tf 					# Root module
	- servers/					# Child module
		- main.tf
		- providers.tf
		- variables.tf
		- outputs.tf
		- terraform.tfstate		# Don't modify this
```

Block Format
```
<Block Type> "<Block Label>" "<Block Label>" {
	# Block Body
	<Identifier> = <Value or Expression> # Argument
}
```

Google Sample Network
```
resource "google_compute_network" "default" {
	# Custom mode network definition
	name = mynetwork				# Identifier Expressions
	auto_create_subnetworks = false	# Argument
}
```

#### Creating Google Storage

main.tf
```
resource "google_storage_bucket" "example_bucket" {
	name = "<unique-bucket-name>"
	location = "US"
}
```

providers.tf
```
terraform {
	required_providers {
		google = {
			source = "hashicorp/google"
			version = "4.23.0"
		}
	}
}
provider "google" {
	# Configuration options
	project = <project_id>
	region = "us-central1"
}
```

output.tf
```
output "bucket_URL" {
	value = google_storage_bucket.example_bucket.URL
}
```

---

## Chapter 3: Terraform Command

- `terraform init`: Initialize the provider with plugin
- `terraform plan`: Preview of resource
- `terraform apply`: Create Infrastructure
- `terraform destroy`: Destroy Infrastructure
- `terraform fmt`: Auto Format to match canonical conventions
- `gcloud beta terraform vet`: Validate Organization & Security Policy

---

## Chapter 4: Meta Arguments

1. count
2. for_each
3. depends_on
4. lifecycle
5. provider

(1) `count` arguments
```
resource "google_compute_instance" "dev_vm" {
	count = 3
	name = "dev_vm${count.index + 1}"
	...
}
```

(2) `for_each` arguments
```
resource "google_compute_instance" "dev_vm" {
	for_each = toset(["us-central-1", "asia-east1-b", "europe-west4-a"])
	name = "dev_${each.value}"
	zone = each.value
	...
}
```

(3) `depends_on` arguments

- Implicity dependency
```
resource "google_compute_instance" "my_instance" {
	...
	network_interface {
		# Implicity dependency
		network = google_compute_network.my_network.name
		access_config {

		}
	}
}
resource "google_compute_network" "my_network" {
	name = "my_network"
	...
}
```

- Explicity dependency
```
resource "google_compute_instance" "client" {
	...
	# Explicit dependency
	depends_on = [google_compute_instance.server]
}
resource "google_compute_instance" "server" {
	...
}
```

---

## Chapter 5: Variables

Block Format
```
variable "variable_name" {
	type = <variable_type>
	default = "<default_value>"
	description = "<variable_description>"
	sensitive = true
}
validation {
	condition = contains(["A", "B", "C"], var.mytype)
	error_message = "Choose only A, B, C"
}
```

variables.tf
```
variable "bucket_storage_class" {
	type = string
	description = "Set the storage class to the bucket."
}
```

main.tf
```
resource "google_storage_bucket" "mybucket_1" {
	name = "<unique_bucket_name>"
	location = "US"
	storage_class = var.bucket_storage_class
	...
}
```

Create Plan
```
terraform plan
var.bucket_storage_class
	Set the storage class to the bucket.
Enter a value:
```

#### Assign Variable

- `.tfvars` file option (Recommanded method)

	```
	tf apply -var-file my-vars.tfvars
	```

- CLI option

	```
	tf apply -var project_id="my_project_id"
	```

- Environment Variables option

	```
	project_id = "my_project_id" \
	tf apply
	```

- If using `terraform.tfvars` option

	```
	tf apply
	```

#### Usage of Variable

variables.tf
```
variable "bucket_region" {
	type = string
}
```

terraform.tfvars
```
bucket_region = "US"
```

---

## Chapter 6: Module

```
- Root Dir
	- main.tf
	- server/
		- main.tf
		- outputs.tf
		- variables.tf
		- terraform.tfvars
```

main.tf
```
module "server" {
	source = "./server"
}
```

#### Remote Source: Terraform Registory

main.tf
```
module "web_server" {
	source = "terraform-google-modules/vm/google//modules/compute_instance"
	version = "0.0.5"
}
```

#### Remote Source: GitHub

main.tf
```
module "vmserver" {
	source = "github.com/terraform-gooogle-modules/terraform-google-vm//modules/compute_instance"
}
```

#### Parameterize with input variables & pass to outside

```
- Root Dir
	- main.tf
	- network/
		- main.tf
		- outputs.tf
		- variables.tf
	- server/
		- main.tf
		- outputs.tf
		- variables.tf
```

main.tf	# Root Config
```
module "dev_network" {
	source = "./network"
	network_name = "my_network1"
}
module "prod_network" {
	source = "./network"
	network_name = "my_network2"
}
module "dev_vm1" {
	source = "./server"
	network_name = module.dev_network.network_name
}
```

network/main.tf
```
resource "google_compute_network" "vpc_network" {
	name = var.network_name
}
```

network/outputs.tf
```
output "network_name" {
	value = google_compute_network.vpc_network.name
}
```

network/variables.tf
```
variable "network_name" {
	type = string
	description = "name of the network"
}
```

server/main.tf
```
resource "google_compute_instance" "server_vm" {
	network = var.network_name
}
```

server/varialbes.tf
```
variable "network_name" {

}
```

---

## Chapter 7: Terraform State

Terraform state is store in `terraform.tfstate` file.
```
  Start
    |
  Read Configuration
    |
  Read State
    |
  Resource in State? -Yes-> Read()
    |						 |
    |						Has Changes? -Yes-> Is Destroy Plan? ----->-+
    |						 |						|				    |
    No 						No 						No 				   Yes
    |						 |						|					|
  Create()					No-Op				Update()			 Delete()
    |						 |						|					|
    +----------------------<-+--------------------<-+-----------------<-+
    |
  Output Plan
    |
   End
```

#### Store Terraform state remotely in a Cloud Storage bucket

- main.tf
- backend.tf

main.tf
```
resource "google_storage_bucket" "default" {
	name = "bucket-tfstate"		# unique name
	force_destroy = false
	location = "US"
	storage_class = "STANDARD"
	versioning {
		enabled = true
	}
}
```

backend.tf
```
terraform {
	# Google Cloud Storage
	backend "gcs" {
		bucket = "bucket-tfstate"
		prefix = "terraform/state"
	}

	# Local Storage
	backend "local" {
		path = "terraform/state/terraform.tfstate"
	}
}

```

If state location change from "local" to "gcs"

- `terraform init -migrate-state`

If cloud information is changed.

- `terraform refresh`

You can check state with

- `terraform show`
