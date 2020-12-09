data "vsphere_distributed_virtual_switch" "dvs" {
  name          = "terraform-switch"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_distributed_port_group" "pg-rubrik-data" {
  name                            = "Management network"
  distributed_virtual_switch_uuid = "${data.vsphere_distributed_virtual_switch.dvs.id}"
  active_uplinks                  = ["vmnic1"]
  standby_uplinks                 = []
  
}
