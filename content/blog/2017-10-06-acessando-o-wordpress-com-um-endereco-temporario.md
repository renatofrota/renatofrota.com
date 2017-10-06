---
date: "2017-10-06 05:07:53"
title: "Acessando o WordPress com um endereço temporário em servidores cPanel"
slug: "acessando-o-wordpress-com-um-endereco-temporario"
description: "Guia prático para quem vai hospedar um site num servidor com cPanel e precisa que seja acessível através de um endereço temporário, antes de apontar o DNS do domínio em definitivo."
tags: [DNS,WordPress]
series: [acessando-um-dominio-a-partir-de-um-servidor-especifico]
---
Este post faz parte de uma série: [acessando um domínio a partir de um servidor específico](/series/acessando-um-dominio-a-partir-de-um-servidor-especifico). Veja os outros posts da série (talvez algum dos outros métodos seja mais eficiente para o seu caso do que o método apresentado aqui).

Essa dica é muito útil para desenvolvedores e agências e vale para as ~~poucas~~ situações em que o [SkipDNS](/blog/skipdns-uma-ferramenta-pratica-para-acessar-dominios-a-partir-de-um-servidor-especifico) não pode te ajudar.

Se você vai criar um novo site para um determinado domínio mas, por enquanto, não pode apontar ele para a conta onde ele será hospedado nem quer se preocupar com os 3 problemas citados [aqui](/blog/skipdns-acessando-dominios-a-partir-de-um-servidor-especifico/#possíveis-soluções), não precisa fritar os miolos com migração de dados. É só seguir o passo a passo abaixo.

### Passo 1 - criação da conta

Crie a conta de hospedagem ou crie um o "Addon Domain" na conta de hospedagem cPanel que você já tem, se for o caso. Se o seu cPanel está em português, é só buscar "addon" no campo de busca do cPanel que você acha essa opção, seja lá como estiver traduzido.

Se for criar um domínio adicional note que o diretório padrão é **public_html/dominio.com**. Você pode alterar esse caminho (caso queira centralizar os addons numa pasta única, em vez de deixar eles espalhados na public_html junto ao site principal da conta, pode colocá-lo em **public_html/_addons_/dominio.com**, por exemplo.

### Passo 2 - instalação do WordPress

Instale o WordPress neste domínio como faria normalmente, usando o Softaculous no painel de controle do cPanel, por exemplo. O domínio ainda não está apontando para esta conta, certo? Tudo bem, relaxa, a instalação é realizada normalmente pelos _auto-instaladores_.

Se você não tem um auto-installer como o Softaculous no cPanel, pode usar o [SkipDNS](/blog/skipdns-acessando-dominios-a-partir-de-um-servidor-especifico) ou [modificar o arquivo hosts do seu computador](/blog/modificando-o-arquivo-hosts-do-seu-computador).

Você não vai conseguir acessar o site de imediato (a menos que esteja usando o [SkipDNS](/blog/skipdns-acessando-dominios-a-partir-de-um-servidor-especifico) ou tenha [modificado o arquivo hosts do seu computador](/blog/modificando-o-arquivo-hosts-do-seu-computador)) mas, calma, não se desespere.

### Passo 3 - configurando o WordPress para acesso via URL temporária

Abra o **File Manager** (gerenciador de arquivos), navegue até o diretório onde o WP foi instalado, clique no arquivo **wp-config.php** e no botão **Edit** da toolbar do gerenciador.

Quando o arquivo abrir, role até o final. Umas 10 linahs antes do final do arquivo você vai encontrar uma que diz:

```
Isto é tudo, pode parar de editar!
```

ou

```
That's all, stop editing!
```

Logo **acima** dela, inclua o seguinte código:

```php
//<?php code

if (preg_match("/(siteground|sgvps.net|sgcpanel.com)/",$_SERVER["HTTP_HOST"])) {
    $username=explode("/",__DIR__);
    $corepath=preg_replace("/^\/home.?.?\/$username[2]\/public_html/","",__DIR__);
    define('WP_HOME', "http://".$_SERVER["HTTP_HOST"]."/~$username[2]$corepath");
    define('WP_SITEURL', "http://".$_SERVER["HTTP_HOST"]."/~$username[2]$corepath");
}
```

Troque o trecho `siteground|sgvps.net|sgcpanel.com` na primeira linha pelo hostname ou pelo IP do seu servidor. Se você está hospedado na [SiteGround](https://www.siteground.com/go/compare-shared-plans), pode deixar como está.

### Passo 4 - acessando a URL temporária

Se o domínio for o principal da conta:

- http://**hostname.do.servidor**/~**logincpanel**/

Se o site estiver num addon domain:

- http://**hostname.do.servidor**/~**logincpanel**/**dominio.com**

Se você colocou o domínio adicional dentro de um diretório **_addons_**, o endereço será:

- http://**hostname.do.servidor**/~**logincpanel**/**_addons_**/**dominio.com**

Obviamente, você deve:

- substituir **hostname.do.servidor** pelo hostname ou endereço IP do servidor
- substituir **logincpanel** pelo login da sua conta
- substituir **dominio.com** pelo domínio em questão

O site não abriu? Verifique com o suporte da empresa de hospedagem se o acesso via URL temporária (ou o **mod_userdir**) está ativado.

O site abriu? Ótimo! Vamos ao último passo.

### Passo 5 - configurando os Links Permanentes (Permalinks)

Adicione **/wp-admin** ao final da URL, faça o login, e navegue até **Configurações > Links Permanentes**. Salve o formulário (não precisa modificar nada).

Agora, volte ao frontend do site e verifique se as páginas/posts estão abrindo como deveriam.

Se tudo correr bem, o site estará totalmente funcional, tanto pela URL temporária quanto pela URL definitiva (caso esteja usando o [SkipDNS](/blog/skipdns-acessando-dominios-a-partir-de-um-servidor-especifico) ou tenha [modificado o arquivo hosts do seu computador](/blog/modificando-o-arquivo-hosts-do-seu-computador) - ou, ainda, depois de apontar o domínio para este novo servidor).

### Notas

- Conforme você trabalha no site (faz modificações) a partir da URL temporária, alguns registros serão salvos no banco de dados do site com essa URL. Por isso:

  1. É preferível editar o arquivo hosts do seu computador ou usar o [SkipDNS](/blog/skipdns-acessando-dominios-a-partir-de-um-servidor-especifico) em relação a este método.

  2. Depois que o site estiver no ar com a URL definitiva, é importante você fazer uma substituição de todas as referências ao endereço temporário no banco de dados usando um plugin de "search and replace" (tem vários do tipo no catálogo público do WordPress), ou terá problemas quando (e se) um dia migrar o site para outra hospedagem, pois haverão referência ao hostname/IP dessa empresa de hospedagem no banco de dados (e aí vai ter que iniciar uma caçada para encontrar qual é a bendita URL e fazer a substituição às pressas, em meio a uma migração - já pensou?).

- Para que o site **deixe de ser acessível** pela URL temporária (evitando dupla-indexação pelo Google, o que poderia te render um **duplicate content** flag), depois que o site estiver pronto e devidamente apontando para o novo servidor, entre no wp-admin a partir da URL definitiva (do domínio de fato) e salve os Links Permanentes novamente.

E aí, gostou do tutorial? Deixe o seu comentário abaixo.
