#####################################################################
# VARIABLES
#####################################################################

variable "esxi_hosts" {
  default = [
    "172.16.62.205",
    "172.16.62.59"
  ]
}

#####################################################################
# PROVIDERS
#####################################################################

provider "vsphere" {
  user                 = "administrator@vsphere.group5.local"
  password             = "JensThomas05!"
  vsphere_server       = "172.16.62.62"
  allow_unverified_ssl = true
}

#####################################################################
# DATA
#####################################################################

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

data "vsphere_host" "host" {
  count         = "${length(var.esxi_hosts)}"
  name          = "${var.esxi_hosts[count.index]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

#####################################################################
# RESOURCES
#####################################################################

resource "vsphere_distributed_virtual_switch" "dvs1" {
  name          = "DCcompany1_1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"

  uplinks         = ["uplink1"]
  active_uplinks  = ["uplink1"]
  standby_uplinks = []

  host {
    host_system_id = "${data.vsphere_host.host.0.id}"
    devices        = ["vmnic1"]
  }

  host {
    host_system_id = "${data.vsphere_host.host.1.id}"
    devices        = ["vmnic0"]
  }
}

resource "vsphere_distributed_port_group" "pg-group5-data" {
  name                            = "Group5_Data"
  vlan_id                         = "0"
  distributed_virtual_switch_uuid = "${vsphere_distributed_virtual_switch.dvs1.id}"
  active_uplinks                  = ["uplink1"]
  standby_uplinks                 = []
}

resource "vsphere_vnic" "v1" {
  count                   = "${length(var.esxi_hosts)}"
  host                    = "${element(data.vsphere_host.host.*.id, count.index)}"
  distributed_switch_port = vsphere_distributed_virtual_switch.dvs1.id
  distributed_port_group  = vsphere_distributed_port_group.pg-group5-data.id
  ipv4 {
    dhcp = true
  }
  netstack = "vmotion"
}

#####################################################################
# PACKER
#####################################################################

resource "null_resource" "run_packer" {
  provisioner "local-exec" {
    command = "packer build packer.json"
  }
  depends_on = [
    vsphere_vnic.v1,
  ]
}
