terraform {
  required_version = "> 1.0"
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
#      version = "~> 1.26"
    }
  }
}

provider "kubernetes" {
  config_path = data.ibm_container_cluster_config.cluster_config.config_file_path
}

provider "ibm" {
  region           = "eu-de"
}


data "ibm_resource_group" "resource_group" {
  name       = "job-runner"
}


data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id   = "agent-5-cluster"
  resource_group_id = data.ibm_resource_group.resource_group.id
}

data "kubernetes_all_namespaces" "allns" {}

output allns {
  value       = data.kubernetes_all_namespaces.allns
}