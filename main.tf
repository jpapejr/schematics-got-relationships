data "template_file" "cloudinit" {
  template = file("./cloud-init.txt")
  vars = {
    BEARER = var.bearer
  }
}

resource "ibm_is_instance" "instance1" {
  name    = "got-relationships-1"
  image   = var.image
  profile = var.profile

  primary_network_interface {
    subnet = var.subnet
  }

  vpc       = var.vpc
  zone      = var.zone1
  keys      = ["r014-13838d07-5ae1-42c5-bc70-d284dbfcdfbb"]
  user_data = data.template_file.cloudinit.rendered
}
