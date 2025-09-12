# Módulo AKS Simplificado

Este módulo cria um cluster Azure Kubernetes Service (AKS) com configuração **mínima e econômica** para desenvolvimento e aprendizado.

## 🎯 **Objetivo**

Provisionar um cluster AKS com o **menor custo possível** mantendo funcionalidade básica para:
- Desenvolvimento de aplicações
- Aprendizado de Kubernetes
- Testes e POCs
- Ambiente acadêmico

## 💰 **Configuração Econômica**

### **Características de Economia:**
- ✅ **1 nó apenas** (mínimo para AKS)
- ✅ **VM Standard_B2s** (série B = baixo custo)
- ✅ **Network plugin kubenet** (sem custo adicional)
- ✅ **Sem auto-scaling** (evita custos inesperados)
- ✅ **Sem add-ons** (Log Analytics, Application Gateway, etc.)
- ✅ **Sem alta disponibilidade** (reduz custos)

### **VM Standard_B2s Specs:**
- 2 vCPUs
- 4 GB RAM
- ~$35-50/mês (pode variar por região)

## 📋 **Variáveis do Módulo**

### Obrigatórias:
```hcl
cluster_name        = "meu-aks"
resource_group_name = "meu-rg"
location           = "Central US"
dns_prefix         = "meu-aks"
subnet_id          = "/subscriptions/.../subnets/aks-subnet"
```

### Opcionais (com defaults econômicos):
```hcl
node_count = 1                 # 1 nó (mínimo)
vm_size    = "Standard_B2s"   # VM econômica
tags       = {}               # Tags opcionais
```

## 🚀 **Exemplo de Uso**

```hcl
module "aks_economico" {
  source = "./modules/kubernetes"

  cluster_name        = "aks-dev"
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  dns_prefix         = "aks-dev"
  subnet_id          = azurerm_subnet.aks.id

  # Configuração econômica
  node_count = 1
  vm_size    = "Standard_B2s"

  tags = {
    Environment = "dev"
    Cost        = "minimal"
  }
}
```

## 📤 **Outputs**

```hcl
cluster_id          # ID do cluster
cluster_name        # Nome do cluster
cluster_fqdn        # FQDN do cluster
kube_config         # Config do kubectl (sensitive)
cluster_identity    # Identidade gerenciada
node_resource_group # RG dos nós
```

## 🔧 **Após o Deploy**

### 1. Configurar kubectl:
```bash
az aks get-credentials --resource-group <rg-name> --name <cluster-name>
```

### 2. Verificar cluster:
```bash
kubectl get nodes
kubectl cluster-info
```

### 3. Deploy de teste:
```bash
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=LoadBalancer
```

## ⚠️ **Limitações da Configuração Econômica**

- **1 nó apenas**: Sem alta disponibilidade
- **Sem auto-scaling**: Capacidade fixa
- **VM pequena**: Limitada a cargas leves
- **Sem monitoramento**: Logs básicos apenas
- **Kubenet**: Networking básico (não Azure CNI)

## 💡 **Evoluindo para Produção**

Quando precisar de mais recursos, considere:

1. **Mais nós**: `node_count = 3`
2. **VMs maiores**: `Standard_DS2_v2` ou superior
3. **Auto-scaling**: Implementar node pools com scaling
4. **Azure CNI**: Network plugin avançado
5. **Monitoramento**: Log Analytics + Azure Monitor
6. **Segurança**: Azure AD integration, RBAC

## 🔍 **Monitoramento de Custos**

- Use Azure Cost Management
- Configure alertas de billing
- Monitore uso de CPU/Memória
- Desligue ambiente quando não usar

## 📚 **Referências**

- [AKS Pricing](https://azure.microsoft.com/pricing/details/kubernetes-service/)
- [VM B-Series](https://docs.microsoft.com/azure/virtual-machines/sizes-b-series-burstable)
- [AKS Best Practices](https://docs.microsoft.com/azure/aks/best-practices)