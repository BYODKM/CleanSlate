module.exports = (grunt)->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig

    jade:
      options:
        pretty: true
      compile:
        files: 'dev/jade/jade.html': ['dev/jade/src.jade']

    stylus:
      options:
        compress: false
        use: [require('kouto-swiss')]
      compile:
        files: 'dev/styl/styl.css': ['dev/styl/src.styl']

    sass:
      options:
        loadPath: require('node-bourbon').includePaths
        sourcemap: 'none'
        style: 'expanded'
      sass:
        files: 'dev/sass/sass.css': ['dev/sass/src.sass']
      scss:
        files: 'dev/scss/scss.css': ['dev/scss/src.scss']

    coffee:
      compile:
        files: 'dev/coffee/coffee.js': ['dev/coffee/src.coffee']

    jshint:
      files: ['dev/coffee/coffee.js']

    connect:
      server:
        options:
          port: '3000'
          base: 'dev/'
          open:
            target: 'http://localhost:<%= connect.server.options.port %>/jade/jade.html'

    watch:
      options:
        livereload: true
      default:
        files: ['dev/**/src.*']
        tasks: ['build']

  grunt.registerTask 'default', ['build', 'serve']
  grunt.registerTask 'build', ['jade', 'stylus', 'sass', 'coffee', 'jshint']
  grunt.registerTask 'serve', ['connect', 'watch']
