data "vsphere_distributed_virtual_switch" "dvs" {
  name          = "terraform-switch"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_host" "host1" {
  name          = "172.16.62.205"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_host" "host2" {
  name          = "172.16.62.59"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_distributed_port_group" "pg-rubrik-data" {
  name                            = "Management network"
  distributed_virtual_switch_uuid = "${data.vsphere_distributed_virtual_switch.dvs.id}"
  active_uplinks                  = ["vmnic1"]
  standby_uplinks                 = []

  host {
    host_system_id = "${data.vsphere_host.host1.id}"
    devices        = ["vmk0"]
  }

  host {
    host_system_id = "${data.vsphere_host.host2.id}"
    devices        = ["vmk0"]
  }
}