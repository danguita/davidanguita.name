---
title: Dropbox para sincronizar tus equipos de trabajo
tagline:
comments: true
tags: Productivity, Dropbox
description:
---

Por muchos es conocida Dropbox, aplicación que nos permite almacenar archivos en la nube con objetivo de compartirlos, mantenerlos sincronizados entre varios equipos, realizar un backup de los más críticos o simplemente disponer de una versión accesible vía web de los mismos. Aprovechando la integración de Dropbox con los distintos sistemas de archivos podemos utilizarlo para sincronizar automáticamente los archivos esenciales, que en mi caso son los que me permitan tener un entorno de desarrollo preparado en el menor tiempo posible.

Habitualmente trabajo con sistemas UNIX (Mac OS X y GNU/Linux) por lo que empleo enlaces simbólicos para enlazar los archivos que necesito sincronizar en el directorio Dropbox, de esta forma:

```shell
$ ln -s /ruta/del/directorio/dropbox/archivo /ruta/del/archivo
```

Los tipos de archivo que mantengo sincronizados:

## Dotfiles

Archivos generalmente alojados en el directorio de usuario, cuyos nombres comienzan con un punto y definen variables de entorno, alias, opciones de ejecución y preferencias globales de intérpretes del sistema y otras aplicaciones.

Algunos de ellos:

* .bashrc (bash shell)
* .bash_profile (bash shell)
* .vimrc (editor de textos vim)
* .gitconfig (git VCS)
* .gitignore (git VCS)
* .irbrc (Intérprete interactivo Ruby)
* .screenrc (GNU screen)
* .zshrc (zsh shell)

> ### Actualización Nov 18th, 2012
> 
> Desde hace meses mantengo un repositorio público de dotfiles en GitHub con una
> doble intención: Compartir mis configuraciones con la comunidad y
> permitir la sincronización entre equipos sin requerir la instalación del
> cliente Dropbox.
> 
> Podéis acceder a dicho repo desde
> [danguita/dotfiles](https://github.com/danguita/dotfiles).

## Archivos de configuración

* Archivos de preferencias, Bundles y Themes de IDEs y editores de texto
* Sitios FTP
* Medios de acceso a equipos remotos
* Conexiones a Bases de Datos (con y sin túnel SSH)

## Scripts de sistema

Principalmente orientados a automatización de tareas en servidor.

## Documentación

* Referencias sobre frameworks y lenguajes de programación
* Cheat Sheets
* Presentaciones
* Otra bibliografía esencial

## Claves y certificados

* Passwords (encriptado)
* Certificados de usuario y seguridad

## Enlaces de descarga

Suelo almacenar enlaces de descarga de mis aplicaciones esenciales en un archivo de texto, para descargarlas en lote en un equipo nuevo.

Con todos estos archivos sincronizados, el enfrentarnos a un equipo nuevo supondrá perder menos horas de productividad, bastará con instalar las aplicaciones y realizar los enlaces simbólicos en el sentido inverso. ¿Cuáles son vuestras técnicas para ganar minutos en este tipo de tareas que, inevitablemente, nos hacen perder tiempo cada vez que renovamos hardware?
