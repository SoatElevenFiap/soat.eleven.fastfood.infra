# MongoDB no AKS - Deploy Manual

Este diretório contém os manifestos Kubernetes para deploy do MongoDB como container no AKS, uma solução **muito mais econômica** que o Azure Cosmos DB.

## 📋 Pré-requisitos

1. AKS cluster criado e configurado
2. `kubectl` configurado para acessar o cluster:
   ```bash
   az aks get-credentials --resource-group rg-fastfood-postech --name aks-fastfood-postech
   ```

## 🚀 Como Deployar

### 1. Aplicar os manifestos na ordem:

```bash
# 1. Criar namespace
kubectl apply -f mongodb-namespace.yaml

# 2. Criar ConfigMap
kubectl apply -f mongodb-configmap.yaml

# 3. Criar Secret (ALTERE AS CREDENCIAIS!)
kubectl apply -f mongodb-secret.yaml

# 4. Criar StatefulSet e Service
kubectl apply -f mongodb-statefulset.yaml
kubectl apply -f mongodb-service.yaml
```

### 2. Verificar o status:

```bash
# Verificar pods
kubectl get pods -n mongodb

# Verificar service
kubectl get svc -n mongodb

# Ver logs
kubectl logs -n mongodb -l app=mongodb
```

### 3. Conectar ao MongoDB:

**De dentro de um pod no mesmo cluster:**
```bash
# Connection string
mongodb://admin:FastFood2024!@mongodb.mongodb.svc.cluster.local:27017/fastfood?authSource=admin
```

**De fora do cluster (port-forward):**
```bash
# Criar port-forward
kubectl port-forward -n mongodb svc/mongodb 27017:27017

# Conectar localmente
mongosh mongodb://admin:FastFood2024!@localhost:27017/fastfood?authSource=admin
```

## 🔐 Segurança

⚠️ **IMPORTANTE**: As credenciais padrão no `mongodb-secret.yaml` são para desenvolvimento. 

**Para produção:**
1. Gere credenciais seguras
2. Use Azure Key Vault para armazenar secrets
3. Considere usar External Secrets Operator

## 💰 Economia

Comparado ao Azure Cosmos DB:
- **Cosmos DB**: ~$25-50/mês (mínimo 400 RU/s)
- **MongoDB no AKS**: ~$0 adicional (usa recursos do AKS já provisionado)

## 📊 Recursos Utilizados

- **CPU**: 250m request, 500m limit
- **Memória**: 512Mi request, 1Gi limit
- **Storage**: 10Gi (ajustável conforme necessidade)

## 🔧 Manutenção

### Backup
```bash
# Fazer backup manual
kubectl exec -n mongodb mongodb-0 -- mongodump --out=/tmp/backup

# Copiar backup para local
kubectl cp mongodb/mongodb-0:/tmp/backup ./backup
```

### Restart
```bash
kubectl rollout restart statefulset/mongodb -n mongodb
```

### Escalar (se necessário)
```bash
# Aumentar réplicas (requer MongoDB ReplicaSet configurado)
kubectl scale statefulset mongodb --replicas=3 -n mongodb
```

## 📝 Notas

- O MongoDB está configurado como **single instance** (1 réplica) para economia
- Para produção, considere configurar ReplicaSet para alta disponibilidade
- O storage usa o StorageClass padrão do AKS
- Acesso é apenas interno ao cluster (ClusterIP)

