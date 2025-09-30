# Aplicação .NET Hello World - Kubernetes

Este diretório contém os manifestos Kubernetes para executar uma aplicação .NET de exemplo com Application Gateway.

## ⚠️ IMPORTANTE: Execute o Terraform primeiro!

Antes de seguir este passo a passo, execute o Terraform para criar a infraestrutura:
```powershell
terraform init
terraform plan
terraform apply
```

## Arquivos

- `namespace.yaml`: Cria o namespace 'postech'
- `deployment.yaml`: Define o deployment da aplicação .NET com 3 réplicas
- `service.yaml`: Expõe a aplicação internamente (ClusterIP)
- `ingress.yaml`: Configura o ingress para Application Gateway

## 🚀 Passo a passo para subir a aplicação

### 1. Conectar kubectl ao cluster AKS
```powershell
az aks get-credentials --resource-group rg-fastfood-postech --name aks-fastfood-postech
```

### 2. Habilitar o AGIC (Application Gateway Ingress Controller)
```powershell
# Verificar o ID do Gateway
az network application-gateway show --resource-group rg-fastfood-postech --name agw-fastfood-postech --query id --output tsv

# Habilitar AGIC (substitua o ID pelo resultado do comando acima)
az aks enable-addons --resource-group rg-fastfood-postech --name aks-fastfood-postech --addons ingress-appgw --appgw-id "/subscriptions/e07abf4e-039e-4f2b-e9af2e1d143e/resourceGroups/rg-fastfood-postech/providers/Microsoft.Network/applicationGateways/agw-fastfood-postech"
```
# esse "--appgw-id" é de exemplo, subistitua pelo seu! 

### 3. Aplicar os manifestos Kubernetes (nesta ordem)
```powershell
# Criar namespace
kubectl apply -f namespace.yaml

# Criar deployment
kubectl apply -f deployment.yaml

# Criar service
kubectl apply -f service.yaml

# Criar ingress (vincula ao Application Gateway)
kubectl apply -f ingress.yaml
```

### 4. Verificar se tudo está funcionando
```powershell
# Verificar pods
kubectl get pods -n postech

# Verificar ingress (deve mostrar um ADDRESS após alguns minutos)
kubectl get ingress -n postech

# Obter IP público do Application Gateway
az network public-ip show --resource-group rg-fastfood-postech --name agw-fastfood-postech-pip --query ipAddress --output tsv
```

### 5. Acessar a aplicação
Acesse no navegador: `http://<IP-PUBLICO-DO-APPLICATION-GATEWAY>`

## 🔍 Troubleshooting

```powershell
# Ver logs do AGIC
kubectl logs -n kube-system deployment/ingress-appgw-deployment

# Ver eventos do namespace
kubectl get events -n postech

# Ver detalhes do ingress
kubectl describe ingress dotnet-helloworld-ingress -n postech
```

## 🧹 Limpeza

Para remover os recursos:
```powershell
kubectl delete -f ingress.yaml
kubectl delete -f service.yaml
kubectl delete -f deployment.yaml
kubectl delete -f namespace.yaml
```

## 🔍 Como funciona o AGIC (Application Gateway Ingress Controller)

### O que é o AGIC?
O AGIC é um **controller** do Kubernetes que roda como um pod no namespace `kube-system` e monitora recursos do cluster para configurar automaticamente o Azure Application Gateway.

### Como o AGIC detecta o Ingress?

#### 1. **Watch API do Kubernetes**
O AGIC usa a **Kubernetes Watch API** para monitorar recursos em tempo real:
- 👀 **Ingresses**: Detecta quando você cria/atualiza/deleta um ingress
- 🔗 **Services**: Monitora endpoints dos serviços
- 🎯 **Pods**: Observa mudanças nos pods (IP, health status)
- 🔐 **Secrets**: Para certificados TLS

#### 2. **Filtragem por Annotation**
O AGIC só processa ingresses que têm a annotation específica:
```yaml
kubernetes.io/ingress.class: "azure/application-gateway"
```

#### 3. **Fluxo de Funcionamento**
```
kubectl apply ingress.yaml → Kubernetes API → AGIC Watch → Azure ARM API → Application Gateway
```

1. **Você aplica o ingress**: `kubectl apply -f ingress.yaml`
2. **Kubernetes armazena**: O recurso é salvo no etcd
3. **AGIC detecta**: Recebe notificação automática via Watch API
4. **AGIC processa**: Verifica se tem a annotation correta
5. **AGIC configura**: Chama APIs do Azure para configurar o Application Gateway

### O que o AGIC faz automaticamente no Application Gateway?

#### ✅ **Backend Pools**
- Cria pools com os IPs dos pods da aplicação
- Atualiza automaticamente quando pods são criados/removidos

#### ✅ **Health Probes**
- Configura baseado nos `readinessProbe` dos pods
- Garante que tráfego só vai para pods saudáveis

#### ✅ **Routing Rules**
- Cria regras baseadas nos paths do ingress
- Configura listeners HTTP/HTTPS

#### ✅ **Backend Settings**
- Define timeouts, protocolos e configurações de conexão

### Verificar o AGIC em funcionamento

```powershell
# Ver o pod do AGIC
kubectl get pods -n kube-system | findstr ingress-appgw

# Logs em tempo real (você verá as chamadas para Azure)
kubectl logs -n kube-system deployment/ingress-appgw-deployment -f

# Ver o que o AGIC criou no Application Gateway
az network application-gateway rule list --resource-group rg-fastfood-postech --gateway-name agw-fastfood-postech
```

### 🎯 Resumo
O AGIC é um "tradutor" que pega a configuração do Kubernetes (Ingress) e aplica no Azure Application Gateway automaticamente. É **reativo** - sempre que você muda o ingress, ele detecta e reconfigura o gateway instantaneamente!
