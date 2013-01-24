# About

There are the app files of my tiny [personal website](http://davidanguita.name), that's how I did it:

* Dirty work done by [nanoc framework](http://nanoc.stoneship.org/).
* Stylesheets managed by [Compass framework](http://compass-style.org/).
* JavaScript written in [CoffeeScript](http://jashkenas.github.com/coffee-script/) language.

# Dependencies
### nanoc framework
<http://nanoc.stoneship.org/docs/2-installation/>

Quick info:

    gem install nanoc

### Compass framework
<http://compass-style.org/install/>

Quick info:

    gem install compass

### CoffeeScript
<http://jashkenas.github.com/coffee-script/#installation>

Quick info:

    npm install -g coffee-script

# Build instructions
Run `script/build` (shell script):

    chmod +x script/build && script/build

or

    sh script/build

After that, you might have a fully deployable static website on `/output` dir.

# Deployment instructions
My `/output` dir is linked to [another GitHub repo](https://github.com/danguita/danguita.github.com) which is configured as GitHub Page.

After each build, I move into `/output` and commit+push all changes. GitHub Pages does the rest.

# License
Feel free to use any of files. If you do use them, a link back to my personal webpage would be appreciated, but is not required.
