# linuxtips-curso-containers-aws-eks-vanilla

Este projeto demonstra como criar um cluster EKS básico na AWS utilizando Terraform.

## Referências

- [Amazon EKS Documentation](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## Pré-requisitos

- Conta AWS
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- kubectl

## Instalação e Configuração do AWS CLI

```bash
# Instale o AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure suas credenciais AWS
aws configure
```

## Criando o Cluster com Terraform

1. Clone este repositório e acesse o diretório:

    ```bash
    git clone https://github.com/seu-usuario/linuxtips-curso-containers-aws-eks-vanilla.git
    cd linuxtips-curso-containers-aws-eks-vanilla
    ```

2. Inicialize o Terraform:

    ```bash
    terraform init
    ```

3. Aplique o plano para criar o cluster:

    ```bash
    terraform apply --auto-approve -var-file=enviroment/prod/terraform.tfvars
    ```

## Atualizando o contexto do kubectl

Após a criação do cluster, execute o comando abaixo para atualizar o contexto local do `kubectl`:

```bash
aws eks --region us-east-1 update-kubeconfig --name linuxtips-cluster
```

Agora você pode gerenciar seu cluster EKS usando o `kubectl`.