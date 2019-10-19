variable "count" {
  description = "number of instances to bring"
  default     = 1
}
variable "ami" {
  description = "ami for the instance"
  default     = "ami-00eb20669e0990cb4"
}
variable "instance_type" {
  description = "type of the instance"
  default     = "t2.micro"
}
# map type variable definition
variable "instance" {
  description = "instance parameters"
  type        = "map"
 
  default = {
    type = "t2.micro"
    name = "tf-frontend-01"
  }
}
variable "key_name" {
  description = "name of the key"
  default     = "cfn-key-1"
}
 
