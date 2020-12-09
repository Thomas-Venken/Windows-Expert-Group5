provider "vsphere" {
  user                  = "administrator@vsphere.group5.local"
  password              = "JensThomas05!"
  vsphere_server        = "172.16.62.62"
  allow_unverified_ssl  = true
}

data "vsphere_datacenter" "dc" {
  name = "Group 5"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "Group 5 Cluster"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_distributed_virtual_switch" "dvs" {
  name              = "terraform-switch"
  datacenter_id     = "${data.vsphere_datacenter.dc.id}"
  uplinks           = ["vmnic1"]
  active_uplinks    = ["vmnic1"]
  standby_uplinks = []
}

