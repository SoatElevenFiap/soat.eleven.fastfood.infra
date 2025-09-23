# FastFood Database Infrastructure - PostgreSQL Gerenciado

Este repositório contém os arquivos de Infrastructure as Code (IaC) utilizados para provisionar **apenas o banco de dados PostgreSQL** do projeto FastFood, desenvolvido como parte da pós-graduação em Arquitetura de Software.

## 📋 Sobre o Projeto

O projeto FastFood é uma aplicação desenvolvida para demonstrar conceitos de arquitetura de software. Este repositório específico é responsável **exclusivamente pela criação e gerenciamento do banco de dados PostgreSQL gerenciado**.

### Características deste repositório:
- 🗄️ **PostgreSQL Flexible Server** no Azure
- 🏗️ **Infrastructure as Code** com Terraform
- 💰 **Configuração econômica** para ambiente de estudos
- 🔒 **Configuração de segurança** adequada para desenvolvimento

## 🏗️ O que é Terraform?

O **Terraform** é uma ferramenta de Infrastructure as Code (IaC) desenvolvida pela HashiCorp que permite definir, provisionar e gerenciar infraestrutura de nuvem usando código declarativo.

### Principais características:
- **Declarativo**: Você descreve o estado desejado da infraestrutura
- **Multi-cloud**: Suporta diversos provedores (AWS, Azure, GCP, etc.)
- **Idempotente**: Execuções múltiplas produzem o mesmo resultado
- **Planejamento**: Mostra as mudanças antes de aplicá-las
- **Versionamento**: Infraestrutura versionada junto com o código

### Vantagens do Terraform:
- ✅ Infraestrutura reproduzível
- ✅ Controle de versão da infraestrutura
- ✅ Colaboração em equipe
- ✅ Redução de erros manuais
- ✅ Documentação automática da infraestrutura

## 🚀 Como usar este repositório

### Pré-requisitos
- [Terraform](https://www.terraform.io/downloads.html) instalado
- Credenciais do Azure configuradas (`az login`)
- **Resource Group** e **VNet** já existentes no Azure
- Git para controle de versão

### Configuração
1. Clone este repositório:
```bash
git clone <url-do-repositorio>
cd infra.db
```

2. Configure as variáveis no arquivo `terraform.tfvars`:
```hcl
resource_group_name = "seu-resource-group-existente"
vnet_name          = "sua-vnet-existente"
postgresql_server_name = "psql-fastfood-postech-001"
```

### Comandos básicos
```bash
# Inicializar o Terraform
terraform init

# Planejar as mudanças (verificar o que será criado)
terraform plan

# Aplicar as mudanças (criar o PostgreSQL)
terraform apply

# Destruir a infraestrutura (remover o PostgreSQL)
terraform destroy
```

## 📁 Estrutura do Projeto

```
├── modules/
│   └── database/      # Módulo do PostgreSQL Flexible Server
│       ├── main.tf    # Recursos do PostgreSQL
│       ├── variables.tf # Variáveis do módulo
│       └── outputs.tf # Outputs do módulo
├── main.tf           # Configuração principal (apenas PostgreSQL)
├── variables.tf      # Declaração de variáveis
├── outputs.tf        # Outputs da infraestrutura
├── terraform.tfvars  # Valores das variáveis
└── provider.tf       # Configuração do provider Azure
```

## 🗄️ Infraestrutura Provisionada

Este repositório provisiona **APENAS**:

### ✅ PostgreSQL Flexible Server
- **Versão**: PostgreSQL 14
- **SKU**: B_Standard_B1ms (configuração econômica)
- **Storage**: 32GB
- **Backup**: 7 dias de retenção
- **Database**: `fastfood`
- **Admin User**: `adm`

### 📋 Pré-requisitos Externos (devem existir)
- **Resource Group**: Deve estar criado previamente
- **Virtual Network**: Deve estar criada previamente

### 🔗 Outputs Disponíveis
- `postgresql_server_fqdn` - FQDN do servidor PostgreSQL
- `postgresql_database_name` - Nome do banco de dados
- `postgresql_connection_string` - String de conexão (sensível)
- `database_summary` - Resumo completo da configuração

## 📚 Referências e Documentação

### Terraform
- [Documentação Oficial do Terraform](https://www.terraform.io/docs)
- [Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [PostgreSQL Flexible Server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server)

### Azure Database for PostgreSQL
- [Azure PostgreSQL Documentation](https://docs.microsoft.com/azure/postgresql/)
- [PostgreSQL Flexible Server](https://docs.microsoft.com/azure/postgresql/flexible-server/)
- [Connection Security](https://docs.microsoft.com/azure/postgresql/flexible-server/concepts-networking)

### PostgreSQL
- [PostgreSQL Official Documentation](https://www.postgresql.org/docs/)
- [PostgreSQL Tutorial](https://www.postgresqltutorial.com/)

## 🔐 Configuração de Segurança

### Credenciais Padrão
- **Usuário**: `adm`
- **Senha**: `adm123`

> ⚠️ **Atenção**: Esta é uma configuração para ambiente de desenvolvimento/estudos. Em produção, use credenciais seguras e gerencie-as adequadamente.

### Conectividade
- O PostgreSQL será criado sem restrições de firewall para facilitar o desenvolvimento
- Em produção, configure adequadamente as regras de firewall

## 💰 Custos

Esta configuração foi otimizada para **menor custo possível**:
- SKU Básico (B_Standard_B1ms)
- Armazenamento mínimo (32GB)
- Backup mínimo (7 dias)
- Sem redundância geográfica

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto é parte de um trabalho acadêmico da pós-graduação em Arquitetura de Software.

## 👥 Equipe

Desenvolvido pelos alunos da pós-graduação em Arquitetura de Software - FIAP.

---

**Nota**: Este repositório é focado **exclusivamente na criação do banco de dados PostgreSQL** para o projeto acadêmico FastFood. Para outros componentes da infraestrutura (AKS, Application Gateway, VNet), consulte os repositórios específicos do projeto.
