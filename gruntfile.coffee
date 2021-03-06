module.exports = (grunt)->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig

    jade:
      options:
        pretty: true
      compile:
        files: 'dev/jade/jade.html': ['dev/jade/src.jade']

    markdown:
      compile:
        files: 'dev/md/md.html': ['dev/md/src.md']

    stylus:
      options:
        compress: false
        use: [require('kouto-swiss')]
      compile:
        files: 'dev/styl/styl.css': ['dev/styl/src.styl']

    sass:
      options:
        includePaths: require('node-bourbon').includePaths
      sass:
        files: 'dev/sass/sass.css': ['dev/sass/src.sass']
      scss:
        files: 'dev/scss/scss.css': ['dev/scss/src.scss']

    autoprefixer:
      options:
        browsers: ['last 2 versions', 'Android >= 2.3', 'ie >= 9']
      sass:
        src: 'dev/sass/sass.css'
      scss:
        src: 'dev/scss/scss.css'
      styl:
        src: 'dev/styl/styl.css'

    csscomb:
      options:
        config: '.csscomb.json'
      sass:
        files: 'dev/sass/sass.css': ['dev/sass/sass.css']
      scss:
        files: 'dev/scss/scss.css': ['dev/scss/scss.css']
      styl:
        files: 'dev/styl/styl.css': ['dev/styl/styl.css']

    coffee:
      options:
        bare: true
      compile:
        files: 'dev/coffee/coffee.js': ['dev/coffee/src.coffee']

    jshint:
      globals:
        angular: true
      files: ['dev/**/*.js']

    connect:
      server:
        options:
          port: '3000'
          open:
            target: 'http://localhost:<%= connect.server.options.port %>/dev/jade/jade.html'

    watch:
      options:
        livereload: true
      html:
        files: ['dev/**/*.jade', 'dev/**/*.md']
        tasks: ['jade', 'markdown']
      css:
        files: ['dev/**/*.styl', 'dev/**/*.sass', 'dev/**/*.scss']
        tasks: ['stylus', 'sass', 'autoprefixer', 'csscomb']
      js:
        files: ['dev/**/*.coffee']
        tasks: ['coffee', 'jshint']

  grunt.registerTask 'default', ['jade', 'markdown', 'stylus', 'sass', 'autoprefixer', 'csscomb', 'coffee', 'jshint', 'connect', 'watch']
