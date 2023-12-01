

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = ["subnet-fb7f12a0", "subnet-f0311bb9"] # Vervang door je eigen subnet-IDs

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_security_group" "allow_postgresql" {
  name        = "allow_postgresql"
  description = "Allow PostgreSQL inbound traffic"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Pas dit aan om veiligheidsredenen
  }
}

module "db_instance" {
  source = "../../modules/db_instance"
    identifier           = local.name
    allocated_storage    = var.allocated_storage
    storage_type         = var.storage_type
    engine               = var.engine
    engine_version       = var.engine_version
    instance_class       = var.instance_class
    username             = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["username"]
    password             = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["password"]
    parameter_group_name = module.db_parameter_group.db_parameter_group
    vpc_security_group_ids = aws_security_group.allow_postgresql.id
    db_subnet_group_name = aws_db_subnet_group.default.id
    tags                 = local.tags
}


################################################################################
# DB Database
################################################################################
module "db_database" {
  source = "../../modules/db_database"
    db_name                 = var.db_name
    owner                   = var.owner
    tablespace_name         = var.tablespace_name
    connection_limit        = var.connection_limit 
    allow_connections       = var.allow_connections
    is_template             = var.is_template
    template                = var.template
    encoding                = var.encoding
    lc_collate              = var.lc_collate
    lc_ctype                = var.lc_ctype
    host                    = split(":", module.db_instance.rds_endpoint)[0]

    # depends_on = [ module.db_instance ]
}

################################################################################
# DB Database Parameter Group
################################################################################
module "db_parameter_group" {
  source = "../../modules/db_parameter_group"
    name = local.name
    family = var.family

    parameters = [ {
      name = var.encoding
    } ]
  tags                 = local.tags
}

################################################################################
# DB Database credentials
################################################################################
data "aws_secretsmanager_secret" "db_credentials" {
  name = "postgres/credentials"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.db_credentials.id
}
