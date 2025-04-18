variable "credentials" {
  description = "My Credentials"
  default     = "./keys/capstone-gcp-creds.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}


variable "project" {
  description = "Project"
  default     = "capstone-455515"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  default     = "us"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "capstone_dataset_2025"
}

variable "bq_dataset2_name" {
  description = "My BigQuery Dataset Name"
  default     = "dbt_premierleague_analytics"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "capstone_bucket_2025"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}