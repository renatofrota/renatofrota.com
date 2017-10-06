---
date: "2017-10-06 05:07:18"
title: "Modificando o arquivo Hosts do seu computador"
slug: "modificando-o-arquivo-hosts-do-seu-computador"
description: "Este tutorial ensina como você pode forçar que o seu computador carregue um domínio ou subdomínio a partir de um IP específico, ignorando as regras da sua zona de DNS."
tags: [DNS]
series: [acessando-um-dominio-a-partir-de-um-servidor-especifico]
---
Este post faz parte de uma série: [acessando um domínio a partir de um servidor específico](/series/acessando-um-dominio-a-partir-de-um-servidor-especifico). Veja os outros posts da série (talvez algum dos outros métodos seja mais eficiente para o seu caso do que o método apresentado aqui).

Se em alguma situação você precisar forçar o seu computador a carregar um domínio ou subdomínio a partir de um IP específico, você pode editar o **arquivo Hosts** do seu computador, onde ficam **"mapeamentos" IP<->domínio(s)**, que o computador verifica antes de fazer uma pesquisa nos servidores DNS.

## Localização do arquivo

### Linux

No Linux o arquivo fica em `/etc/hosts` e, para editá-lo, você precisa abri-lo com privilégios elevados, ou seja, como um super-usuário (normalmente, como usuário **root**).

No Ubuntu, por exemplo, você pode abrir o terminal e digitar:

```
gksudo gedit /etc/hosts
```

No Linux Mint:

```
gksudo xed /etc/hosts
```

Em qualquer Linux que tenha o editor **nano**:

```
sudo nano /etc/hosts
```

No caso do nano, use **Ctrl+X** para salvar as alterações.

### Windows

No Windows, o arquivo fica em `C:\Windows\system32\drivers\etc\hosts` e, assim como no Linux, você vai precisar de privilégios elevados para modificar o arquivo.

Você pode abrir o menu iniciar e digitar **notepad** (ou **bloco de notas**), clicar com o botão direito do mouse sobre o resultado, e escolher **Executar como Administrador**.

Uma vez dentro do bloco de notas, vá ao menu **Arquivo > Abrir** e cole o caminho do arquivo no campo de pesquisa:

```
C:\Windows\system32\drivers\etc\hosts
```

### Mac OS X

O arquivo é `/private/etc/hosts` e você pode editá-lo com o **nano**, como no Linux:

```
sudo nano /private/etc/hosts
```

Para salvar, o comando é basicamente mesmo: **Command+X**

## Sintaxe

A linha que você deve adicionar no arquivo deve seguir o formato:

```
ENDEREÇO.IP dominio.com www.dominio.com qualquer.sub.dominio.com
```

Exemplo:

```
192.168.0.1 seudominio.com www.seudominio.com
```

Uma vez salvo o arquivo, você pode fechar o navegador e reabri-lo para que a alteração faça efeito (ou abra o site desejado e use a combinação **Ctrl+F5** duas vezes).

E aí, gostou do tutorial? Deixe o seu comentário abaixo!
