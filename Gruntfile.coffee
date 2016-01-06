'use strict'

module.exports = (grunt) ->

  # -------------------------------------------------------------------------- #
  # Project configuration
  # -------------------------------------------------------------------------- #
  grunt.initConfig

    # Read in the package.json file data
    # ------------------------------------------------------------------------ #
    pkg: grunt.file.readJSON('package.json')

    # Path settings
    # ------------------------------------------------------------------------ #
    path:

      # Base locations
      dev:    'dev'
      craft:  'craft'
      public: 'public'

      # Bower components
      bootstrap: 'bower/bootstrap-sass-official/assets'
      jquery: 'bower/jquery/dist'

    # Clean - Empties build directories
    # ------------------------------------------------------------------------ #
    clean:
      templates: [
        '<%= path.craft %>/templates/*',
        '!<%= path.craft %>/templates/.gitignore'
      ]
      assets: [
        '<%= path.public %>/assets/*',
        '!<%= path.public %>/assets/.gitignore'
      ]

    # Coffee - JS Proprocessor
    # ------------------------------------------------------------------------ #
    coffee:
      options:
        bare: true
        sourceMap: true
      build:
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/js'
          src: '**/*.coffee'
          dest: '<%= path.public %>/assets/js'
          ext: '.js'
        ]

    # Concat some files
    # ------------------------------------------------------------------------ #
    concat:
      options:
        sourceMap: true
        stripBanners: true
      bootstrap_js:
        files: {
          '<%= path.public %>/assets/js/lib/bootstrap.js' : [
            # Comment out the components that we aren't using
            # '<%= path.bootstrap %>/javascripts/bootstrap/affix.js'
            # '<%= path.bootstrap %>/javascripts/bootstrap/alert.js'
            # '<%= path.bootstrap %>/javascripts/bootstrap/button.js'
            # '<%= path.bootstrap %>/javascripts/bootstrap/carousel.js'
            # '<%= path.bootstrap %>/javascripts/bootstrap/collapse.js'
            # '<%= path.bootstrap %>/javascripts/bootstrap/dropdown.js'
            # '<%= path.bootstrap %>/javascripts/bootstrap/tab.js'
            '<%= path.bootstrap %>/javascripts/bootstrap/transition.js'
            # '<%= path.bootstrap %>/javascripts/bootstrap/scrollspy.js'
            # '<%= path.bootstrap %>/javascripts/bootstrap/modal.js'
            # '<%= path.bootstrap %>/javascripts/bootstrap/tooltip.js'
            # '<%= path.bootstrap %>/javascripts/bootstrap/popover.js'
          ]
        }
      jquery:
        files: '<%= path.public %>/assets/js/lib/jquery.js': '<%= path.jquery %>/jquery.min.js'

    # Copy files from A to B
    # ------------------------------------------------------------------------ #
    copy:
      gif:
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/img'
          src: '**/*.gif'
          dest: '<%= path.public %>/assets/img'
        ]
      jpg:
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/img'
          src: '**/*.{jpg,jpeg}'
          dest: '<%= path.public %>/assets/img'
          ext: '.jpg'
        ]
      png:
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/img'
          src: '**/*.png'
          dest: '<%= path.public %>/assets/img'
        ]
      svg:
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/img'
          src: '**/*.svg'
          dest: '<%= path.public %>/assets/img'
        ]
      js:
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/js'
          src: '**/*.js'
          dest: '<%= path.public %>/assets/js'
        ]
      fonts:
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/fonts'
          src: '**/*'
          dest: '<%= path.public %>/assets/fonts'
        ]

    # HTMLmin - Minify HTML files
    # ------------------------------------------------------------------------ #
    htmlmin:

      templates:
        options:
          removeComments: true
          collapseWhitespace: true
        files: [
          expand: true
          cwd: '<%= path.dev %>/templates'
          src: '**/*.html'
          dest: '<%= path.craft %>/templates'
        ]

    # Sass - CSS preprocessing
    # ------------------------------------------------------------------------ #
    sass:
      options:
        loadPath: ['bower']
        style: 'compressed'
      styles:
        options:
          compass: true
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/css'
          src: [
            '**/*.{sass,scss}'
            '!**/_*.{sass,scss}'
            '!**/*bootstrap.{sass,scss}'
          ]
          dest: '<%= path.public %>/assets/css'
          ext: '.css'
        ]
      bootstrap:
        files: ['<%= path.public %>/assets/css/bootstrap.css': '<%= path.dev %>/assets/css/bootstrap.sass']

    # Uglify - JS compression
    # ------------------------------------------------------------------------ #
    uglify:
      options:
        compress:
          drop_console: false
        preserveComments: false
      scripts:
        files: '<%= path.public %>/assets/js/scripts.min.js': [
          '<%= path.public %>/assets/js/lib/jquery.js'
          '<%= path.public %>/assets/js/lodash.min.js',
          '<%= path.public %>/assets/js/fixedsticky.js',
          '<%= path.public %>/assets/js/three.min.js',
          '<%= path.public %>/assets/js/dat.gui.min.js',
          '<%= path.public %>/assets/js/EffectComposer.js',
          '<%= path.public %>/assets/js/RenderPass.js',
          '<%= path.public %>/assets/js/ShaderPass.js',
          '<%= path.public %>/assets/js/MaskPass.js',
          '<%= path.public %>/assets/js/CopyShader.js',
          '<%= path.public %>/assets/js/FilmShader.js',
          '<%= path.public %>/assets/js/RGBShiftShader.js',
          '<%= path.public %>/assets/js/BadTVShader.js',
          '<%= path.public %>/assets/js/StaticShader.js',
          '<%= path.public %>/assets/js/throttle.js',
          '<%= path.public %>/assets/js/glitch.js',
          '<%= path.public %>/assets/js/scripts.js'

        ]

    # Watch - Run tasks when files are modified
    # ------------------------------------------------------------------------ #
    watch:

      options:
        livereload: true

      # Gruntfile
      grunt:
        files: [
          'Gruntfile.{coffee,js}'
          'config.rb'
        ]

      # Templates
      templates:
        files: ['<%= path.dev %>/templates/**/*']
        tasks: ['htmlmin:templates']

      # Scripts
      scripts:
        files: ['<%= path.dev %>/assets/js/*']
        tasks: [
          'coffee',
          'uglify'
        ]

      # Styles
      styles:
        files: [
          '<%= path.dev %>/assets/css/**/*',
          '!<%= path.dev %>/assets/css/bootstrap.sass'
        ]
        tasks: ['sass:styles']
      bootstrap_styles:
        files: [
          '<%= path.dev %>/assets/css/{_variables,bootstrap}.sass'
        ]
        tasks: ['sass:bootstrap']

      # Images
      img_gif:
        files: ['<%= path.dev %>/assets/img/**/*.gif']
        tasks: ['newer:copy:gif']
      img_jpg:
        files: ['<%= path.dev %>/assets/img/**/*.{jpg,jpeg}']
        tasks: ['newer:copy:jpg']
      img_png:
        files: ['<%= path.dev %>/assets/img/**/*.png']
        tasks: ['newer:copy:png']
      img_svg:
        files: ['<%= path.dev %>/assets/img/**/*.svg']
        tasks: ['newer:copy:svg']
      img_js:
        files: ['<%= path.dev %>/assets/js/**/*.js']
        tasks: ['newer:copy:js']

  # -------------------------------------------------------------------------- #
  # Load all Grunt tasks
  # -------------------------------------------------------------------------- #
  require('load-grunt-tasks')(grunt)

  # -------------------------------------------------------------------------- #
  # Build tasks
  # -------------------------------------------------------------------------- #
  grunt.registerTask 'build', [

    # Start off with a blank slate
    'clean'

    # Minimize templates and copy to Craft folder
    'htmlmin:templates'

    # Generate images
    'copy:gif'
    'copy:jpg'
    'copy:png'
    'copy:svg'
    'copy:js'
    'copy:fonts'

    # Generate scripts
    'coffee'
    'concat:bootstrap_js'
    'concat:jquery'
    'uglify:scripts'

    # Generate styles
    'sass'

  ]

  # -------------------------------------------------------------------------- #
  # Listen tasks
  # -------------------------------------------------------------------------- #
  grunt.registerTask 'listen', [

    # Watch dev files for changes
    'watch'
  ]

  # -------------------------------------------------------------------------- #
  # Default tasks
  # -------------------------------------------------------------------------- #
  grunt.registerTask 'default', ['build', 'listen']

  return
