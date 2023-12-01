variable "aws_region" {
  type        = string
  description = "AWS region for deployment"
  default     = "eu-west-1"
}

variable "app_name" {
  description = "App Name"
  type = string
}


variable "app_id" {
  description = "App Id"
  type = string
}

variable "allocated_storage" {
  description = "allocated_storage"
  type = number
}

variable "storage_type" {
  description = "storage_type"
  type = string
}

variable "engine" {
  description = "engine"
  type = string
  default = "postgres"
}

variable "family" {
  description = "Postgess family"
  type = string
}

variable "engine_version" {
  description = "engine_version"
  type = string
  }

variable "instance_class" {
  description = "instance_class"
  type = string
}

# variable "username" {
#   description = "username"
#   type = string
#   # default = "ferry"
# }

# variable "password" {
#   description = "password"
#   type = string
#   # default = "kjsdgkjfdskj^^%$$"
# }

variable "db_name" {
    description = "Name of the database"
    type = string
}

variable "owner" {
    description = "The role name of the user who will own the database"
    type = string
    default = "DEFAULT"
}

variable "tablespace_name" {
    description = "The name of the tablespace that will be associated with the database"
    type = string
    default = "DEFAULT"
}

variable "connection_limit" {
    description = "How many concurrent connections can be established to this database"
    type = number
    default = -1
}

variable "allow_connections" {
  description = "(Optional) If false then no one can connect to this database"
  type = bool
  default = true
}

variable "is_template" {
  description = "If true, then this database can be cloned by any user with CREATEDB privileges"
  type        = bool
  default     = false
}

variable "template" {
  description = "The name of the template database"
  type        = string
  default     = null
}

variable "encoding" {
  description = "Character set encoding to use in the database"
  type        = string
  default     = null
}

variable "lc_collate" {
  description = " Collation order (LC_COLLATE) to use in the database"
  type        = string
  default     = null
}

variable "lc_ctype" {
  description = "Character classification (LC_CTYPE) to use in the database"
  type        = string
  default     = null
}

variable "environment" {
  description = "Possible values are, dev, int, prd"
  type = string
}
