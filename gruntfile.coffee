module.exports = (grunt) ->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig

    jade:
      options:
        pretty: true
      compile:
        files: 'dev/jade/index.html': ['dev/jade/index.jade']

    stylus:
      options:
        compress: false
      compile:
        files: 'dev/styl/style.css': ['dev/styl/style.styl']

    coffee:
      compile:
        files: 'dev/coffee/script.js': ['dev/coffee/script.coffee']

    jshint:
      files: ['dev/coffee/script.js']

    connect:
      server:
        options:
          port: '3000'
          base: 'dev/'
          open:
            target: 'http://localhost:<%= connect.server.options.port %>/jade/'

    watch:
      options:
        livereload: true
      default:
        files: ['dev/**/*.jade', 'dev/**/*.styl', 'dev/**/*.coffee']
        tasks: ['build']

  grunt.registerTask 'build', ['jade', 'stylus', 'coffee', 'jshint']
  grunt.registerTask 'serve', ['connect', 'watch']
