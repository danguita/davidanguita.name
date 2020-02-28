---
title: Distribución del Runtime Adobe AIR
tagline:
date: 2009-11-26 00:00
comments: true
tags: Adobe AIR, Desktop
description:
---

Recientemente he trabajado con la tecnología *Adobe AIR 1.5* en su perfil AJAX, que nos permite desarrollar RIA (*Rich Internet Applications*) como aplicaciones de escritorio multisistema. Aunque esta característica no es un concepto nuevo (otras tecnologías como Google Gears o Sun JavaFX tienen propósitos muy similares) y podríamos profundizar bastante en sus virtudes, hoy quiero centrarme en las condiciones de distribución del Runtime Adobe AIR.

Básicamente existen dos perfiles principales de distribución del Runtime, que recordemos es necesario instalar en las máquinas cliente para ejecutar nuestras aplicaciones.

## Distribución web
A través de esta opción no es necesario firmar ninguna Licencia de Distribución siempre y cuando empleemos el medio de distribución web de aplicaciones Adobe AIR proporcionado por Adobe y conocido como Badge Install. Se trata de un pequeño script web (JavaScript y Flash) que tras una sencilla configuración permite descargar e instalar el Runtime desde los propios servidores de Adobe y nuestra aplicación (desde el servidor que decidamos, las condiciones de distribución afectan únicamente al Runtime) en un único proceso de instalación. 

## Distribución en soportes físicos (CD/DVD)
En este caso debemos solicitar una Licencia de distribución a Adobe a través del un formulario en el que debemos aportar cierta información sobre el proyecto para el que solicitamos la licencia.Una vez Adobe haya estudiado y aprobado nuestra solicitud de licencia (puede tardar unos 3 días laborables), se nos aportará una completa documentación sobre las formas de distribución del Runtime junto a nuestras aplicaciones.

Las posibilidades se reducen a la instalación del Runtime junto a nuestra aplicación (un único proceso de instalación "invisible" al usuario) o instalación del Runtime standalone seguido de nuestra aplicación (orientado principalmente a equipos IT que realicen la instalación de forma silenciosa a través de la intranet de su empresa).

Comentar también que la concesión de Licencia de distribución por parte de Adobe no nos da libertad total en cuanto al Runtime, por ejemplo no se permite su distribución con modificaciones por nuestra parte. Este es un extracto de la Descripción general de licencia aportada por Adobe referente a las condiciones que debemos cumplir al aceptar la licencia:

> El receptor de la licencia puede distribuir el tiempo de ejecución de Adobe AIR a múltiples clientes en un entorno de intranet cerrado.
> El receptor de la licencia puede distribuir el tiempo de ejecución de Adobe AIR a múltiples usuarios finales incluyendo instaladores del tiempo de ejecución de Adobe AIR en CD, DVD u otros soportes físicos.
> El receptor de la licencia sólo puede distribuir instaladores de Adobe AIR para su uso en plataformas compatibles; por ejemplo, los dispositivos que no son PC y los sistemas integrados no son plataformas compatibles. Si desea volver a distribuir el tiempo de ejecución de Adobe AIR en sistemas operativos o dispositivos no compatibles, póngase en contacto con Adobe en la dirección license-air@adobe.com para obtener más información.
> El receptor de la licencia puede distribuir los archivos del tiempo de ejecución de Adobe AIR como parte de su producto de software o incluidos en un instalador original.
> El receptor de la licencia debe distribuir los instaladores y los archivos de Adobe AIR tal cual, sin ninguna modificación.
> Los receptores de la licencia, si lo desean, podrán mostrar los logotipos "Includes Adobe AIR" ("Incluye Adobe AIR") en productos o sitios de la intranet, según las directrices de marcas comerciales de Adobe.
> El receptor de la licencia no podrá distribuir el instalador o los archivos del instalador de Adobe AIR con el fin de evitar la instalación del tiempo de ejecución de Adobe AIR, una aplicación de Adobe AIR o el EULA.
> El receptor de la licencia no podrá distribuir ni utilizar el tiempo de ejecución de Adobe AIR, sus bibliotecas, componentes o archivos del instalador de un modo no documentado. Consulte las preguntas frecuentes para obtener información más detallada.

El número de aplicaciones desarrolladas con esta tecnología crece día a día (probablemente todos nosotros tenemos alguna aplicación AIR instalada en nuestro sistema o incluso la utilizamos habitualmente –los tuiteros lo sabrán bien por clientes como TweetDeck–) y aparentemente el medio de distribución más utilizado es el web, lo que nos aleja de la citada maraña de condiciones de distribución, aunque es muy útil conocerlas cuando, como es mi caso, realizamos una distribución a través de soportes físicos.

### Enlaces de interés:

* [Distribución del tiempo de ejecución de Adobe© AIR™](http://www.adobe.com/es/products/air/runtime_distribution1.html)
* [Preguntas frecuentes sobre la distribución del tiempo de ejecución de Adobe© AIR™](http://www.adobe.com/es/products/air/runtime_distribution_faq.html)
* [Deploying Adobe AIR applications seamlessly with badge install (Inglés)](http://www.adobe.com/devnet/air/articles/air_badge_install.html)

