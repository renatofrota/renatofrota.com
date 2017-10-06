---
date: "2017-10-06 06:16:30"
title: "SkipDNS - acessando domínios a partir de um servidor específico"
slug: "skipdns-acessando-dominios-a-partir-de-um-servidor-especifico"
description: "Esta ferramenta é muito útil durante a migração de websites entre servidores diferentes, para o desenvolvimento em ambientes de testes hospedados online, etc."
tags: [DNS,Ferramentas]
series: [acessando-um-dominio-a-partir-de-um-servidor-especifico]
---
Este post faz parte de uma série: [acessando um domínio a partir de um servidor específico](/series/acessando-um-dominio-a-partir-de-um-servidor-especifico). Veja os outros posts da série (talvez algum dos outros métodos seja mais eficiente para o seu caso do que o método apresentado aqui).

Você já passou por aquela situação em que você está migrando um site entre dois servidores diferentes e queria se certificar de que o site iria funcionar conforme o esperado no servidor de destino antes de apontar o DNS do domínio?

Ou ainda, já precisou desenvolver um site para um cliente, em um servidor diferente daquele onde ele está de fato hospedado (situação muito comum em agências de desenvolvimento web)?

## Possíveis soluções

### Solução 1 - URLs temporárias

Normalmente recorremos às ~~muitas vezes~~ complicadas **URLs temporárias**. Os problemas em depender dessas URLs são:

1. dificuldade de configurar.

2. ter que desfazer tudo na hora de publicar o site.

3. ter que **refazer** tudo se for preciso rever/ajustar alguma informação (e desfazer novamente).

4. a URL temporária é salva em inúmeros pontos do banco de dados e, em algum momento, você vai acabar tendo que recorrer a um plugin de "search and replace" para corrigir todas elas.

Os 3 primeiros pontos, até dá pra contornar seguindo [esta dica](/blog/acessando-o-wordpress-com-um-endereco-temporario/), mas não dá pra fugir do último.

### Solução 2 - modificar o arquivo Hosts do seu computador

Outra solução possível é [modificar o arquivo hosts do seu computador](/blog/modificando-o-arquivo-hosts-do-seu-computador) para forçá-lo a carregar um domínio ou subdomínio a partir de um IP específico. Os problemas dessa solução incluem:

1. você precisa fazer isso em todos os computadores que precisem acessar esse site a partir de um servidor de desenvolvimento específico (leia-se: nos micros de vários funcionários da agência e **no computador do seu cliente**)

2. uma vez feita a alteração, você **não consegue mais** abrir o site a partir do servidor para onde o domínio realmente aponta, a menos que desfaça a alteração (ou seja, é tudo ou nada, 8 ou 80).

### Solução definitiva: SkipDNS

Apresento a solução definitiva para este problema: **[SkipDNS](https://skipdns.link)**

É só acessar o [https://skipdns.link](https://skipdns.link) e informar no primeiro campo o domínio do site e no segundo campo o IP da conta ou o nameserver indicado pelo provedor (que o domínio _"deveria"_ utilizar para carregar a partir daquele provedor em questão).

Essa ferramenta te fornece um link especial que "salta" a resolução de DNS atual do domínio, apontando diretamente para o servidor que você indicou.

A resolução de DNS é "forçada" para este IP específico nas requisições do domínio "base" e do subdomínio www. Outros subdomínios do domínio em questão não serão "filtrados" e carregarão diretamente dos servidores para onde eles apontam via DNS então, em setups muito personalizados, pode não funcionar. Comente abaixo, se for o caso, ou se você tiver qualquer dúvida.
