---
title: CSS extendido con LESS
tagline:
date: 2009-12-05 00:00
comments: true
tags: Front-end, Rubygems, CSS
description:
---

Ante lo tosco –sintácticamente hablando– que puede resultar un desarrollo CSS atendiendo a las especificaciones actuales, numerosos son los frameworks CSS o utilidades que surgen con el objetivo de flexibilizar este proceso.

LESS es una gema Ruby que nos permite generar ficheros CSS a partir de su propia especificación, que no es otra que una extensión de CSS con cuatro mejoras fundamentales:

* Variables
* Mixins
* Reglas anidadas
* Operaciones 

## Variables
Permite definir atributos en el documento CSS y asignarlos a múltiples clases, por lo que las modificaciones de estos atributos tienen repercusión de forma global.

```css
#colors {
  header: #fff;
  wrapper: #000;
  footer: blue;
}
```

A los que accederemos con:

```css
.wrapper {
  color: #colors[@wrapper];
}
```

## Mixins
Permite asociar todos los atributos de una clase a cualquier otra, permitiendo también el paso de parámetros a la primera, lo que a efectos prácticos la convierte en una función que devuelve una serie de atributos.

```css
.bordered(@color: #fff) {
  border: 1px solid @color;
}
```

## Reglas anidadas

Permite definir la jerarquía de clases en el DOM estableciendo unas claras reglas de herencia.

```css
#header {
  background-color: #000;
  .wrapper {
    width: 960px;
  }
}
```

## Operaciones
Aporta un dinamismo relativo a la generación de CSS permitiendo aplicar operaciones aritméticas a valores y colores definidos en la hoja de estilo.


```css
.wrapper {
  background-color: #888 / 2 + #000;
}
```

Para trabajar con LESS, una vez instalado en nuestro sistema a través de ruby-gems, editaremos un archivo con extensión .less que utilizaremos para generar el CSS estándar de forma automática a través de la gema.

Este es un buen ejemplo de código LESS y su correspondiente CSS generado aplicando la mayoría de sus mejoras (extraído de http://github.com/cloudhead/less/tree):

### LESS

```css
@dark: #110011;

.outline (@width: 1) {
  border: (@width * 10px) solid black;
}

.article {
  a { text-decoration: none }
  p { color: @dark }
  .outline(3);
}
```

### CSS

```css
.article a { text-decoration: none }

.article p { color: #110011 }

.article { border: 30px solid black }
```

Recordemos que no estamos hablando de CSS dinámico, sino de una especificación extendida del CSS estático que conocemos. Las técnicas de CSS dinámico requieren generalmente un servidor o intérprete y tienen objetivos adicionales a flexibilizar el proceso de desarrollo.

LESS es open source bajo Licencia Apache y mantiene un repositorio público en github desde [este proyecto](http://github.com/cloudhead/less).

