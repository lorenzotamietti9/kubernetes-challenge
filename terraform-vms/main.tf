terraform {
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}


resource "virtualbox_vm" "master" {
  count     = 1
  name      = format("master-%02d", count.index + 1)
  image     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
  cpus      = 2
  memory    = "2048 mib"
  user_data = file("${path.module}/user_data")

   network_adapter {
    type           = "hostonly"
    device         = "IntelPro1000MTDesktop"
    host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }
}

resource "virtualbox_vm" "node" {
  count     = 2
  name      = format("worker-%02d", count.index + 1)
  image     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
  cpus      = 2
  memory    = "512 mib"
  user_data = file("${path.module}/user_data")

  network_adapter {
    type           = "hostonly"
    device         = "IntelPro1000MTDesktop"
    host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }
}

output "IPAddrmaster" {
  value = element(virtualbox_vm.master.*.network_adapter.0.ipv4_address, 1)
}
output "IPAddr1" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
}

output "IPAddr2" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 2)
}