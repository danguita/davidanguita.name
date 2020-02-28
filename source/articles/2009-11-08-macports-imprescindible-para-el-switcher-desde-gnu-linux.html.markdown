---
title: MacPorts, imprescindible para el switcher desde GNU/Linux
tagline:
date: 2009-11-08 00:00
comments: true
tags: GNU/Linux, Mac OS X, Ports
description:
---

Siempre que en la comunidad Mac nos referimos a switcher, todo nos lleva a pensar que se trata de un usuario que abandona el tedioso Microsoft Windows para pasar a Mac OS X, aunque no es menos habitual que un switcher proceda de otros Sistemas Operativos como GNU/Linux. Este fue mi caso concreto, aunque no puedo considerarme switcher ya que nunca abandoné mi sistema original, los compagino muy a menudo aunque es cierto que el sistema en el que trabajo más horas diarias es OS X.

Los usuarios de GNU/Linux en prácticamente cualquiera de sus distribuciones estarán habituados al concepto de sistema de gestión de paquetes (como es APT en distribuciones Debian/Ubuntu), algo de lo que no podemos disfrutar nativamente en nuestros OS X y que nos abstraería de arduas instalaciones de software desde los fuentes.

Ante esta dificultad para instalar software libre/opensource en sistemas Darwin (base de Mac OS X) surge MacPorts (originalmente conocido como DarwinPorts), que integra un completo repositorio de paquetes portados a Darwin que pueden ser gestionados a través de órdenes sencillas como éstas:

### Búsqueda

```shell
$ port search <nombre_del_paquete>
```

### Instalación

```shell
$ port install <nombre_del_paquete>
```

### Actualización

```shell
$ port upgrade <nombre_del_paquete>
```

En la web oficial de MacPorts podemos encontrar completa información para la instalación del sistema de gestión de paquetes en las diferentes versiones de OS X. Cumpliendo los requisitos mínimos (tener instalado Xcode Developer Tools y X11) el proceso es automático.

Disfrutad de los más de 6300 ports disponibles a día de hoy.

[Web oficial de MacPorts](http://www.macports.org/).

