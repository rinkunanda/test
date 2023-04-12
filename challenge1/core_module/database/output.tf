output "db_vm" {
  description = "machine_name_details"
  value       = google_sql_database_instance.instance.name
}