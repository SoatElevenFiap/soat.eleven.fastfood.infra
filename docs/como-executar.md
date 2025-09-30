# Projeto de Infraestrutura com Terraform na Azure

Este guia descreve os passos para provisionar a infraestrutura deste projeto utilizando Terraform e Azure CLI.

## Pré-requisitos

Antes de começar, garanta que você tenha as seguintes ferramentas instaladas:

- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli)
- [Terraform](https://www.terraform.io/downloads.html)

## Passos para o Deploy

1.  **Autenticação na Azure**
    Faça login na sua conta da Azure (ex: FIAP) através do terminal:
    ```bash
    az login
    ```
    Siga as instruções no navegador para completar a autenticação.

2.  **Provisionamento da Infraestrutura (State Local)**
    Navegue até o diretório com os arquivos Terraform e inicialize o projeto.
    ```bash
    cd tf
    terraform init
    ```
    Revise o plano de execução para entender quais recursos serão criados.
    ```bash
    terraform plan
    ```
    Aplique o plano para criar os recursos na Azure.
    ```bash
    terraform apply
    ```
    Após a conclusão, você pode verificar os recursos criados diretamente no [Portal da Azure](https://portal.azure.com).

3.  **Configuração do Backend Remoto (State no Blob Storage)**
    Para persistir o estado do Terraform de forma segura e compartilhada, vamos configurá-lo para usar um Azure Blob Storage.
    
    Primeiro, renomeie o arquivo de configuração do backend:
    ```bash
    mv backend.tf.disabled backend.tf
    ```
    Agora, inicialize o Terraform novamente. Ele detectará a mudança e solicitará a migração do seu arquivo de estado (`terraform.tfstate`) para o Blob Storage.
    ```bash
    terraform init
    ```
    Confirme a migração quando solicitado.

## Destruindo a Infraestrutura

Para remover **todos** os recursos criados por este projeto na Azure, execute o comando abaixo.

**Atenção:** Esta ação é irreversível.

```bash
terraform destroy
```