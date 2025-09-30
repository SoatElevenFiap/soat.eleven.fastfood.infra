# Integração GitHub Actions OIDC com Azure para Terraform

Este guia descreve como configurar a autenticação federada (OIDC) entre o GitHub Actions e o Azure AD, permitindo que pipelines do GitHub executem comandos Terraform de forma segura, sem necessidade de secrets manuais.

## Visão Geral

O OIDC permite que o GitHub Actions obtenha tokens de acesso temporários diretamente do Azure AD, aumentando a segurança e facilitando o gerenciamento de credenciais.

---

## 1. Criar uma Aplicação no Azure AD

Crie um novo registro de aplicação para representar o GitHub Actions no Azure AD.

```sh
az ad app create --display-name "github-terraform-oidc"
```

- **Resultado:** Guarde o valor de `appId` retornado (exemplo: `d241daaf-xxxx-xxxx-xxxx-xxxxxxxxxxxx`).

O valor também pode ser recuperado após criado pelo comando

```sh
az ad app list --display-name "github-terraform-oidc" --query "[].{displayName:displayName, appId:appId}" -o table
```

---

## 2. Obter IDs Necessários

- **Tenant ID:**  
  ```sh
  az account show --query tenantId -o tsv
  ```
- **Subscription ID:**  
  ```sh
  az account show --query id -o tsv
  ```
- **Client ID:**  
  Use o `appId` da aplicação criada no passo 1.

Esses valores serão usados nos passos seguintes e armazenados como secrets no GitHub Actions, exemplo:
- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

---

## 3. Criar o Service Principal

Crie o service principal para a aplicação:

```sh
az ad sp create --id <appId>
```

- **Resultado:** Guarde o valor de `appId` e `id` retornados.

---

## 4. Atribuir Permissões (Role Assignment)

Conceda a permissão necessária (exemplo: "User Access Administrator") ao service principal no escopo da subscription:

```sh
az role assignment create --assignee <appId> --role "User Access Administrator" --scope /subscriptions/<subscription-id>
```

---

## 5. Criar as Credenciais Federadas

Crie um arquivo `federated-credential.json` com o seguinte conteúdo (ajuste os campos conforme seu repositório):

**Json para liberação de uma branch**
```json
{
    "name": "github-actions-main",
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": "repo:SeuOrg/SeuRepo:ref:refs/heads/main",
    "description": "GitHub Actions OIDC para branch main",
    "audiences": ["api://AzureADTokenExchange"]
}
```

**Json para liberação em ambiente de produção** 
(Necessário para apply do terraform)
```json
{
    "name": "github-actions-production",
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": "repo:SeuOrg/SeuRepo:environment:production",
    "description": "GitHub Actions OIDC para ambiente production",
    "audiences": ["api://AzureADTokenExchange"]
}
```

Adicione as credenciais federadas à aplicação criada:

```sh
az ad app federated-credential create --id <appId> --parameters @federated-credential.json
```

---

## 6. Extras (Gerenciamento)

- **Listar credenciais federadas:**
  ```sh
  az ad app federated-credential list --id <appId>
  ```
- **Deletar credencial federada:**
  ```sh
  az ad app federated-credential delete --id <appId> --federated-credential-id <credential-name>
  ```

---

## Resumo

Após seguir esses passos, o GitHub Actions poderá autenticar no Azure via OIDC, permitindo executar comandos Terraform de forma segura e automatizada.
