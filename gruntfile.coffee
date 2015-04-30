module.exports = (grunt)->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig

    bower:
      install: {}

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

    coffee:
      compile:
        files: 'dev/coffee/coffee.js': ['dev/coffee/src.coffee']

    ts:
      options:
        watch: 'never'
        sourceMap: false
      compile:
        src: ['dev/ts/src.ts']
        out: 'dev/ts/ts.js'

    jshint:
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
        tasks: ['stylus', 'sass', 'autoprefixer']
      js:
        files: ['dev/**/*.coffee', 'dev/**/*.ts']
        tasks: ['coffee', 'ts', 'jshint']

  grunt.registerTask 'default', ['bower', 'build']
  grunt.registerTask 'build', ['jade', 'markdown', 'stylus', 'sass', 'autoprefixer', 'coffee', 'ts', 'jshint', 'watch']
  grunt.registerTask 'serve', ['connect', 'watch']
