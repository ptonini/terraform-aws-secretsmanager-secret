variable "name" {}

variable "policies" {
  type = map(object({
    api_version = optional(string, "2012-10-17")
    statement   = any
  }))
  default = {}
}

variable "value" {
  type    = string
  default = null
}

variable "object_file_extension" {
  default = ".json"
}