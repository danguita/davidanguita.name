---
title: Migrando a Octopress
tagline:
date: 2012-11-20 09:13
comments: true
tags: Blog, Octopress, Jekyll
description:
---

## Motivación

Me decanté por Posterous buscando comodidad para crear contenidos y a los pocos meses se convirtió en un lastre que provocaba justo lo contrario. Si a esto le sumamos su adquisición por parte de Twitter, que convertirá el servicio en software congelado, mis ganas de migrar se multiplicaron.

Por otro lado, hace tiempo que conozco y he trabajado con [Jekyll](https://github.com/mojombo/jekyll) y más tarde con [Octopress](http://octopress.org), con los que desde el primer despliegue tuve claro que "esto es lo que estaba buscando".

## *Esto es lo que estaba buscando*

Su autor define Octopress como *"A blogging framework for hackers"*, algo pretencioso pero buena declaración de intenciones. Nos vale.

Está basado en el generador de sitios estáticos [Jekyll](https://github.com/mojombo/jekyll), especialmente utilizado para construir blogs y ahora motor de [GitHub Pages](http://pages.github.com/), al que Octopress especializa como plataforma de blogging *ready-to-use* a través templates en front-end (HTML5, responsive layout, Compass…) y una colección de herramientas con las que generar y gestionar los contenidos.

Una de sus principales características es la de generar un sitio completamente estático (únicamente archivos HTML en una estructura de directorios), a partir de un archivo de reglas y los propios fuentes del contenido.

Ventajas y desventajas:

* El servidor se limitará a servir estáticos, lo que será tremendamente
  eficiente.
* Gran comodidad de despliegue:
  * Los requisitos en servidor son mínimos.
  * Puedes deplegarlo de forma gratuita en servicios como [GitHub Pages](http://octopress.org/docs/deploying/github/) o [Heroku](http://octopress.org/docs/deploying/heroku/).
* Existe un proceso para regenerar todo el site, que puede ser lento si el volumen de posts es grande.

## Migración

### Exportación desde Posterous

Usando el [script de migración](https://github.com/pepijndevos/jekyll/blob/patch-1/lib/jekyll/migrators/posterous.rb) proporcionado por la comunidad de Jekyll el proceso fue sencillo. El script hace uso del [API de Posterous](http://posterous.com/api) para, previa autorización vía user/pass + api_token, volcar el contenido de tus posts en archivos HTML y descargar las imágenes asociadas:

```shell
$ ruby posterous.rb <username> <password> <api_token>
```

El script realiza la exportación del *Site* o *Space* configurado como primario. Para realizar la exportación de cualquier otro *Site* del que seas propietario será necesario editar la línea [#21](https://github.com/pepijndevos/jekyll/blob/patch-1/lib/jekyll/migrators/posterous.rb#L21) especificando su id de esta forma: `site = Site.find(<site_id>)`.

Para obtener esta información puedes usar la gema [posterous-gem](https://github.com/posterous/posterous-gem/) en un script Ruby o ejecutar el cliente interactivo proporcionado en `bin/posterous`. Esta gema actúa como cliente oficial del API y puedes lanzar acciones como `> Site.all.pluck(:id)` para obtener los ids de tus *Sites*.

### Procesado

Para favorecer la mantenibilidad de los posts anteriores he preferido convertirlos a [Markdown](http://daringfireball.net/projects/markdown/syntax): 

1. Eliminación de *markup* HTML y conversión de caracteres aplicando [estos reemplazos](https://github.com/danguita/blog.davidanguita.name/blob/master/lib/migration-replacements).
1. Inserción de imágenes a través del plugin [Image Tag](http://octopress.org/docs/plugins/image-tag/).
1. Conversión de nombres de archivo (extensión .html a .markdown para que el generador de Jekyll procese los archivos con este formato).

### Despliegue en GitHub Pages

Fue pan comido con las [herramientas](http://octopress.org/docs/deploying/github/) proporcionadas:

El script de inicialización `setup_github_pages` realiza *automágicamente* los ajustes de despliegue para que la tarea `deploy` realice su cometido:

1. Regenerar el sitio.
1. Copiar los archivos generados al directorio `_deploy`.
1. Push hacia el repo en GitHub, en mi caso bajo el branch `gh-pages` al tratarse de una [*Project Page*](https://help.github.com/articles/user-organization-and-project-pages).

## Conclusión

He escrito este post en formato Markdown usando Vim, he usado `preview` para revisarlo en el layout definitivo y hecho esto está listo para regenerar y desplegar en GitHub. Mola.

