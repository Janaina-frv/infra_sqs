# 📦 Infraestrutura – Fila SQS de Feedbacks Urgentes

Este repositório é responsável **exclusivamente pela infraestrutura e deploy** de uma **fila Amazon SQS**, utilizada como ponto de integração entre dois projetos distintos:

1. **Projeto de Recebimento de Feedbacks**
   Responsável por receber feedbacks, avaliar o nível de urgência e **enviar mensagens para a fila SQS** quando a urgência for **ALTA**.

2. **Projeto de Notificação por E-mail**
   Responsável por **consumir as mensagens da fila SQS** e disparar notificações por e-mail para os casos urgentes.

Este repositório **não contém lógica de aplicação**, apenas definição de infraestrutura como código.

---

## 🏗️ Arquitetura da Infraestrutura

A fila SQS atua como um **componente central de desacoplamento**, permitindo que os projetos produtores e consumidores evoluam de forma independente.

### Visão Geral

* **Amazon SQS**

    * Recebe mensagens de feedbacks urgentes
    * Garante entrega confiável e processamento assíncrono
    * Permite escalabilidade e tolerância a falhas

### Integração entre Projetos

```
Projeto Feedbacks (Producer)
        |
        v
     SQS Queue
        |
        v
Projeto Notificação (Consumer)
```

---

## 🎯 Responsabilidade do Repositório

* Provisionar a **fila SQS**
* Definir configurações como:

    * Nome da fila
    * Retention period
    * Visibility timeout
    * Dead Letter Queue (se aplicável)
* Expor **outputs** para consumo por outros projetos
* Manter a infraestrutura versionada e isolada

---

## 🧱 Infraestrutura como Código (Terraform)

Toda a infraestrutura é definida utilizando **Terraform**, organizada de forma simples e objetiva.

### 📂 Arquivos Terraform

* **`sqs.tf`**
  Cria e configura a fila Amazon SQS utilizada pelos projetos consumidores e produtores.

* **`variables.tf`**
  Define as variáveis utilizadas para parametrizar a criação da fila.

* **`outputs.tf`**
  Exporta informações da fila (ex: URL e ARN) para integração com outros projetos.

---

## 🚀 Pipeline de Deploy (GitHub Actions)

O deploy da infraestrutura é feito automaticamente através de uma GitHub Action, utilizando Terraform.

**Arquivo da Pipeline**

- .github/workflows/deploy-or-destroy.yml

Esse workflow é responsável por executar:

- terraform init

- terraform plan

- terraform apply ou terraform destroy, dependendo da variável configurada.

**Variável**: TF_ACTION

Para subir (provisionar) o projeto na AWS, é necessário:

1. Editar o arquivo:

`.github/workflows/deploy-or-destroy.yml`


2. Alterar a variável:

`TF_ACTION: apply`


3. Fazer commit da alteração.

Subir o commit na branch **develop**.

🔁 O pipeline será acionado automaticamente e realizará o deploy da infraestrutura.

Caso seja necessário destruir os recursos, basta alterar o valor para:

`TF_ACTION: destroy`

---
## 🔐 Autenticação com AWS via OIDC (GitHub Actions)

Este projeto utiliza OIDC (OpenID Connect) para autenticação segura entre o GitHub Actions e a AWS, eliminando a necessidade de armazenar credenciais estáticas (Access Key e Secret Key).

Como funciona

* O GitHub Actions assume uma IAM Role na AWS usando OIDC.
* Essa role possui permissões específicas para executar o Terraform.
* A autenticação ocorre de forma temporária e segura durante a execução da pipeline.

Benefícios do OIDC

* 🔒 Maior segurança (sem secrets sensíveis no repositório)
* ♻️ Credenciais temporárias
* 📋 Controle granular de permissões via IAM
* ✅ Padrão recomendado pela AWS

A configuração do OIDC envolve:

* Provider OIDC do GitHub na AWS
* IAM Role com trust policy para o repositório/branch
* Permissões necessárias para criação dos recursos via Terraform
