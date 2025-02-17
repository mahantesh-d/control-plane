variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "bot_name" {
  type = string
}

variable "app_service_plan_name" {
  type = string
}

variable "web_app_name" {
  type = string
}

variable "open_ai_name" {
  type = string
}

variable "vnet_integration_subnet_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_resource_group" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "microsoftappid" {
  type    = string
  default = "78ea090b-f1a2-4036-a711-948d5573687c"
}