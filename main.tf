resource "ibm_is_public_gateway" "publicgateway1" {
  name = "gateway1"
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone1
}

resource "ibm_is_subnet" "subnet1" {
  name            = "got-relationships-subnet"
  vpc             = var.vpc
  zone            = var.zone1
  ipv4_cidr_block = "10.240.0.0/28"
  public_gateway  = ibm_is_public_gateway.publicgateway1.id
}


resource "ibm_is_instance" "instance1" {
  name    = "got-relationships-1"
  image   = var.image
  profile = var.profile

  primary_network_interface {
    subnet = ibm_is_subnet.subnet1.id
  }

  vpc       = var.vpc
  zone      = var.zone1
  keys      = ["r014-13838d07-5ae1-42c5-bc70-d284dbfcdfbb"]
  user_data = file("./cloud-init.txt")
}
