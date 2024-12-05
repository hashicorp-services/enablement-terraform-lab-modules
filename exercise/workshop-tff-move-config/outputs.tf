output "public_ip" {
  description = "The Public IP address used to access the instance"
  value       = module.compute.public_ip
}