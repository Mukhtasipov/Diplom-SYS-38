output "external_ip_address_bastion" {
  value = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
}

output "internal_ip_address_bastion" {
  value = yandex_compute_instance.bastion.network_interface.0.ip_address
}

output "FQDN_bastion" {
  value = yandex_compute_instance.bastion.fqdn
}

output "external_ip_address_zabbix" {
  value = yandex_compute_instance.zabbix.network_interface.0.nat_ip_address
}

output "internal_ip_address_zabbix" {
  value = yandex_compute_instance.zabbix.network_interface.0.ip_address
}

output "FQDN_zabbix" {
  value = yandex_compute_instance.zabbix.fqdn
}

output "external_ip_address_kibana" {
  value = yandex_compute_instance.kibana.network_interface.0.nat_ip_address
}

output "internal_ip_address_kibana" {
  value = yandex_compute_instance.kibana.network_interface.0.ip_address
}

output "FQDN_kibana" {
  value = yandex_compute_instance.kibana.fqdn
}

output "internal_ip_address_elastic" {
  value = yandex_compute_instance.elastic.network_interface.0.ip_address
}

output "FQDN_elastic" {
  value = yandex_compute_instance.elastic.fqdn
}

output "internal_ip_address_web-1" {
  value = yandex_compute_instance.web-1.network_interface.0.ip_address
}

output "FQDN_web-1" {
  value = yandex_compute_instance.web-1.fqdn
}

output "internal_ip_address_web-2" {
  value = yandex_compute_instance.web-2.network_interface.0.ip_address
}

output "FQDN_web-2" {
  value = yandex_compute_instance.web-2.fqdn
}

output "external_ip_address_L7balancer" {
  value = yandex_alb_load_balancer.l7b.listener.0.endpoint.0.address.0.external_ipv4_address
}

resource "local_file" "inventory" {
  content  = <<-XYZ
  [all:vars]
  ansible_user=alex
  ansible_ssh_private_key_file=/home/alex/.ssh/id_ed25519
  ansible_ssh_common_args='-o ProxyCommand="ssh -p 22 -W %h:%p -q alex@${yandex_compute_instance.bastion.network_interface.0.nat_ip_address}"'
  
  [log]
  elastic_srv ansible_host=elastic.ru-central1.internal
  kibana_srv  ansible_host=kibana.ru-central1.internal

  [web]
  web-1 ansible_host=web1.ru-central1.internal
  web-2 ansible_host=web2.ru-central1.internal

  [mon]
  zabbix_srv ansible_host=zabbix.ru-central1.internal
  XYZ
  filename = "/home/alex/Diplom/ansible/hosts.ini"
}
