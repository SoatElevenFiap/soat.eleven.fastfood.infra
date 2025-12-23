# FastFood Infrastructure - Pós-Graduação em Arquitetura de Software

Este repositório contém os arquivos de Infrastructure as Code (IaC) utilizados para provisionar e gerenciar a infraestrutura do projeto FastFood, desenvolvido como parte da pós-graduação em Arquitetura de Software.

## 📋 Sobre o Projeto

O projeto FastFood é uma aplicação desenvolvida para demonstrar conceitos de arquitetura de software, incluindo:
- Microserviços
- Clean Architecture
- Domain Driven Design (DDD)
- Infraestrutura como Código (IaC)
- DevOps e CI/CD

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
- Credenciais configuradas para o provedor de nuvem escolhido
  - **Exemplo para Azure:** veja o guia de configuração OIDC para GitHub Actions em [`docs/github-actions-azure-oidc.md`](docs/github-actions-azure-oidc.md)
- Git para controle de versão
- Terraform Cloud para o Backend (opcional)
  - Veja veja o guia de configuração do Terraform Cloud com Azure em [`docs/terraform-cloud-backend.md`](docs/terraform-cloud-backend.md)

### Comandos básicos
```bash
# Inicializar o Terraform
terraform init

# Planejar as mudanças
terraform plan

# Aplicar as mudanças
terraform apply

# Destruir a infraestrutura
terraform destroy
```
**Mais detalhes para execução em** [`docs/como-executar.md`](docs/como-executar.md)

## 📁 Estrutura do Projeto

```
├── modules/           # Módulos reutilizáveis do Terraform
├── environments/      # Configurações por ambiente (dev, staging, prod)
├── variables.tf       # Declaração de variáveis
├── outputs.tf         # Outputs da infraestrutura
├── main.tf           # Configuração principal
└── terraform.tfvars.example  # Exemplo de variáveis
```

## 🌐 Infraestrutura Provisionada

Este repositório provisiona os seguintes recursos na Azure:

### Módulos Principais
- ✅ **Virtual Network (VNet)** - Rede virtual com subnets para aplicações, banco de dados e Application Gateway
- ✅ **Azure Kubernetes Service (AKS)** - Cluster Kubernetes para orquestração de containers
- ✅ **Application Gateway** - Load balancer layer 7 com roteamento baseado em path
- ✅ **Azure Function** - Função serverless para autenticação
- ✅ **Azure Container Registry (ACR)** - Registry privado para imagens Docker
- ✅ **Azure Key Vault** - Gerenciamento seguro de secrets e chaves

### Arquitetura de Rede
- **App Subnet**: `10.0.1.0/24` - Para aplicações e AKS
- **Database Subnet**: `10.0.2.0/24` - Para recursos de banco de dados
- **Application Gateway Subnet**: `10.0.3.0/24` - Para o Application Gateway

### Configuração Econômica
Todos os recursos estão configurados com SKUs básicos para otimização de custos, ideal para contas Azure for Students:
- **AKS**: 1 nó `Standard_E2s_v3`
- **Application Gateway**: `Standard_v2` com 1 instância
- **ACR**: SKU `Basic`
- **Key Vault**: SKU `standard`
- **Function App**: Plano de consumo `Y1`

### Integração entre Serviços
- **ACR ↔ AKS**: Integração para pull automático de imagens (configurado após deployment)
- **Key Vault ↔ Function App**: Acesso a secrets para configurações (opcional)
- **Application Gateway ↔ Function App**: Roteamento para `/api/auth*`

### Próximos Passos
Após o deployment da infraestrutura:

1. **Configurar integração ACR-AKS**:
   ```bash
   # Habilitar o AKS para fazer pull do ACR
   az aks update -n aks-fastfood-postech -g rg-fastfood-postech --attach-acr acrfastfoodpostech
   ```

2. **Configurar secrets no Key Vault**:
   ```bash
   # Adicionar connection string do banco de dados
   az keyvault secret set --vault-name kv-fastfood-postech-19 --name "database-connection-string" --value "sua-connection-string"
   ```

3. **Configurar kubectl para AKS**:
   ```bash
   az aks get-credentials --resource-group rg-fastfood-postech --name aks-fastfood-postech
   ```

## 📚 Referências e Documentação

### Terraform
- [Documentação Oficial do Terraform](https://www.terraform.io/docs)
- [Terraform Registry](https://registry.terraform.io/) - Módulos e providers
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [Terraform CLI Commands](https://www.terraform.io/docs/cli/commands/index.html)

### Infrastructure as Code
- [Infrastructure as Code: Dynamic Systems for the Cloud Age](https://www.oreilly.com/library/view/infrastructure-as-code/9781491924334/)
- [Terraform: Up & Running](https://www.terraformupandrunning.com/)

### Arquitetura de Software
- [Clean Architecture - Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Domain Driven Design - Eric Evans](https://domainlanguage.com/ddd/)
- [Microservices Patterns - Chris Richardson](https://microservices.io/)

### Provedores de Nuvem
- [AWS Documentation](https://docs.aws.amazon.com/)
- [Azure Documentation](https://docs.microsoft.com/azure/)
- [Google Cloud Documentation](https://cloud.google.com/docs)

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

**Nota**: Este repositório faz parte do projeto acadêmico FastFood para demonstração de conceitos de arquitetura de software e infraestrutura como código.
