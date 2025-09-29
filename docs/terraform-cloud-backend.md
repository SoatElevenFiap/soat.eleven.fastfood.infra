# Utilizando o Terraform Cloud como Backend com Azure

Este guia explica como configurar o Terraform Cloud como backend remoto para seus estados Terraform, utilizando credenciais do Azure obtidas via Service Principal.

---

## 1. Criar Service Principal no Azure

Você precisa de um Service Principal para que o Terraform Cloud possa autenticar e gerenciar recursos no Azure.

### Passos

1. **Faça login no Azure CLI:**
   ```sh
   az login
   ```

2. **Obtenha o ID da sua assinatura:**
   ```sh
   az account show --query id -o tsv
   ```

3. **Crie o Service Principal:**
   Substitua `<SEU_SUBSCRIPTION_ID>` pelo valor obtido acima.
   ```sh
   az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SEU_SUBSCRIPTION_ID>"
   ```

4. **O comando retorna um JSON semelhante a:**
   ```json
   {
     "appId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
     "displayName": "azure-cli-2024-xx-xx-xx-xx-xx",
     "password": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
     "tenant": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
   }
   ```

5. **Mapeie os valores retornados:**
   - `ARM_CLIENT_ID` = `appId`
   - `ARM_CLIENT_SECRET` = `password`
   - `ARM_TENANT_ID` = `tenant`
   - `ARM_SUBSCRIPTION_ID` = `<SEU_SUBSCRIPTION_ID>`

---

## 2. Configurar Variáveis no Terraform Cloud

No Terraform Cloud, acesse o workspace desejado e configure as seguintes variáveis de ambiente:

- `ARM_CLIENT_ID`
- `ARM_CLIENT_SECRET`
- `ARM_TENANT_ID`
- `ARM_SUBSCRIPTION_ID`

Essas variáveis permitem que o Terraform Cloud autentique no Azure para criar e gerenciar recursos.

---

## 3. Configurar o Backend no Terraform

No seu código Terraform, configure o backend remoto apontando para o Terraform Cloud:

```hcl
terraform { 
  cloud {     
    organization = "<SUA_ORGANIZACAO_TFC>" 

    workspaces { 
      name = "<SEU_WORKSPACE>" 
    } 
  } 
}
```

Substitua `<SUA_ORGANIZACAO_TFC>` e `<SEU_WORKSPACE>` conforme sua configuração no Terraform Cloud.

---

## 4. Referências

- [Documentação oficial Terraform Cloud](https://developer.hashicorp.com/terraform/cloud-docs)
- [Provider AzureRM](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)

---
