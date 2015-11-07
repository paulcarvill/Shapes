# Shapes website

This is a Craft CMS website. The build uses node, grunt and bower to generate template and asset files.

- - -

## Getting Started

To get this project up and running, follow these steps:

### Requirements
* Vagrant
* Virtualbox
* Node & npm

### Environment Setup

1. In the project directory, type `npm install` to install the project's back-end (Node/Grunt) dependencies. This might take a couple of minutes to finish.
2. Type `bower install` to install the project's front-end (Bower) dependencies.
3. Type `grunt` to build the template/asset files for the site and watch for changes to the files in the `dev/` folder. If you're not interested in watching the project, type `grunt build` instead.
4. Type `vagrant up` to install and provision an Ubuntu VM, which runs inside Vagrant and serves the built files from the above step as if it were a real webserver.

### Craft Setup

6. Type `chmod -R 774 craft/{app,config,storage}` to make sure Craft can edit certain files.
7. Create a database on the Ubuntu VM by visiting phpMyAdmin on it at http://localhost:9000.
8. Change the database settings in `craft/config/db.php` to point to the database you just created.
9. Open a browser and navigate to Craft's admin URL (e.g. `http://localhost:8080/admin/`). This walkthrough will help you install Craft on your server.
10. Visit your website at http://localhost:8080
11. Optional: import the Shapes db backup in data/shapesdb.sql using phpMyAdmin as above.

- - -

## Working with Grunt

The folder structure of this project looks like this:

    ./
      bower/
        [bower packages]
      craft/
        app/
        config/
        plugins/
        storage/
        templates/
      dev/
        assets/
          css/
          img/
          js/
        templates/
      public/
        assets/
        uploads/

### Craft Templates

We develop our Craft templates in the `dev/templates/` folder. Grunt minimizes these templates and stores the optimized files in the `craft/templates/` folder.

### Assets

We develop the project's front-end assets in the `dev/assets/` folder. Our CSS is written in Sass and our JS is written in Coffeescript. Grunt compiles and optimizes these files, and then saves them to their appropriate CSS/JS locations in the `public/assets/` folder.