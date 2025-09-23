# =================
# Configuração Principal - SOAT Eleven Fast Food
# Infraestrutura Simplificada - Apenas PostgreSQL
# =================

# Configurações do Resource Group Existente
resource_group_name = "rg-fastfood-postech"

# Configurações da VNet Existente  
vnet_name = "vnet-fastfood-postech"

# Environment
environment = "dev"

# Tags para identificação de recursos
tags = {
  Environment = "Development"
  Project     = "SOAT-FastFood"
  Course      = "PosGraduacao-ArquiteturaSoftware"
  Purpose     = "Learning"
}

# =================
# Configuração PostgreSQL - Configuração Econômica
# =================
postgresql_server_name           = "psql-fastfood-postech-001"
postgresql_version               = "14"
postgresql_sku_name              = "B_Standard_B1ms"        # SKU mais econômico
postgresql_storage_mb            = 32768                    # 32GB - mínimo
postgresql_backup_retention_days = 7                       # Mínimo para economia
postgresql_database_name         = "fastfood"