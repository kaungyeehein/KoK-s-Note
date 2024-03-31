# Root Config

module "dev_network" {
  source             = "./network"
  network_name_input = "dev-net"
}

module "pro_network" {
  source             = "./network"
  network_name_input = "pro-net"
}

module "dev_vm" {
  source           = "./server"
  instance_name    = "dev-vm"
  instance_zone    = "us-west1-c"
  instance_network = module.dev_network.network_name_output
}

module "pro_vm" {
  count = 3
  source           = "./server"
  instance_name    = "pro-vm${count.index+1}"
  instance_zone    = "europe-west4-c"
  #instance_type    = "e2-medium"
  instance_network = module.pro_network.network_name_output
}