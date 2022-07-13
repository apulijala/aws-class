output "public_dns" {
  value = module.vm_instance.public_dns
}

output "public_ip" {
  value = module.vm_instance.public_ip
}

output "lamp_sec_group_id" {
  value = module.vm_instance.lamp_sec_group_id
}

output "lamp_sec_group_name" {
  value = module.vm_instance.lamp_sec_group_name
}