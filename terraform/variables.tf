

variable "sg_description" {
    default = ""
  
}


variable "sg_ingress_rules" {
    default = []
  
}

variable "project_name" {
    default = "ROBOSHOP"

}

variable "env" {
    default = "dev"

}

variable "common_tags" {
    default = {  
      Project = "ROBOSHOP"
      Env = "DEV"
      Component = "catalogue"
      Terraform = "true"
  
   }
}

variable "sg_tags" {
  default = {}
}

variable "app_version" {
    default = "100.100.100"
  
}

variable "domain_name" {
    default = "nishalkdevops.online"
  
}