---
date: 2017-10-02 01:30:00
title: Resolvendo problemas de mixed content (cadeado amarelo) em sites WordPress
slug: resolvendo-problemas-de-mixed-content-em-sites-wordpress
description: Neste post eu apresento um script que te ajuda a resolver probelmas de conteúdo misto (que geram um aviso no browser a respeito de "conteúdo possivelmente inseguro, tais como imagens") em sites WordPress que usam protocolo HTTPS
---
Se você tem um site em WordPress e instalou o SSL recentemente, pode estar vendo avisos no seu navegador como "conteúdo potencialmente inseguro" ou "conteúdo misto detectado", etc... (e o cadeado de segurança fica com uma exclamação ou um triângulo amarelo).

Isso acontece porque qualquer conteúdo carregado por meio do protocolo HTTP (não criptografado) em uma página HTTPS pode afetar a segurança do visitante. Essa imagem carregada por meio de um protocolo inseguro, abre uma brecha para ataques [MITM - Man in the Middle](https://pt.wikipedia.org/wiki/Ataque_man-in-the-middle).

Para resolver o problema, você precisa alterar no banco de dados do site todas as referências que usam o protocolo HTTP para que usem o protocolo HTTPS. Isso dá um trabalho grande - quando você tem que fazer a procura e a substituição manualmente.

Não vá fazer a gambiarra de exportar o banco de dados em .sql e substituir diretamente no arquivo exportado, usando um "find and replace" no seu editor de texto! Isso vai quebrar os índices de [dados serializados](http://php.net/manual/pt_BR/function.serialize.php). Outro recurso que muitos utilizam: plugins que substituem o protocolo nas referências de forma dinâmica, quando a página é carregada (tal como o Really Simple SSL - que eu nem vou colocar o link aqui, por que não gosto dele). O problema desses plugins é que as substituições são feitas **a cada pageview** e haja servidor pra aguentar isso!

Uma forma prática de resolver isso **da maneira correta** é utilizar [este script](https://github.com/renatofrota/search-replace-ssl) que eu desenvolvi: ele substitui, em todas as referências ao domínio do site que existirem no banco de dados, o protocolo HTTP por HTTPS.

Se, após a substituição, ainda houver algum problema com o cadeado de segurança, então você ainda tem referências a imagens (ou scripts) inseguros [em arquivos estáticos](/blog/substituindo-dominio-e-ou-protocolo-em-arquivos-estaticos-de-forma-pratica) ou **externos** (sendo carregados de outros domínios que não o do seu próprio site). Você pode averiguar quais são essas referências usando o Console do seu navegador (F12) ou ferramenas como o [Why no Padlock?](https://www.whynopadlock.com/) (que significa, "Por que não tem cadeado?").

O script depende do [WP-CLI](http://wp-cli.org/). Você pode instalá-lo manualmente, mesmo em hospedagens compartilhadas - não requer privilégios administrativos. Mas se a sua hospedagem não tem ele pré-instalado, é hora de mudar para [uma hospedagem de respeito](https://www.siteground.com/go/compare-shared-plans).

Se tiver qualquer dificuldade no uso do script, é só [abrir uma issue lá no GitHub](https://github.com/renatofrota/search-replace-ssl/issues/new) ou enviar um comentário logo abaixo.
