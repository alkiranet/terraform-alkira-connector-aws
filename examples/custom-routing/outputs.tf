output "vpc_id" {
    value = module.create_vpc.vpc_id
}

output "connector_id" {
    value = module.connect_vpc.connector_id
}

output "implicit_group_id" {
    value = module.connect_vpc.implicit_group_id
}