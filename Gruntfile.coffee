module.exports = (grunt) ->
  grunt.initConfig
    
    # Import package manifest
    pkg: grunt.file.readJSON("hexagonize.jquery.json")
    
    # Banner definitions
    meta:
      banner: """
/*
 *  <%= pkg.title || pkg.name %> - v<%= pkg.version %>
 *  <%= pkg.description %>
 *  <%= pkg.homepage %>
 *
 *  Made by <%= pkg.author.name %>
 *  Under <%= pkg.licenses[0].type %> License
 */

"""

    
    # Concat definitions
    concat:
      dist:
        src: ["src/jquery.hexagonize.js"]
        dest: "dist/jquery.hexagonize.js"

      options:
        banner: "<%= meta.banner %>"

    
    # Lint definitions
    jshint:
      files: ["src/jquery.hexagonize.js"]
      options:
        jshintrc: ".jshintrc"

    
    # Minify definitions
    uglify:
      my_target:
        src: ["dist/jquery.hexagonize.js"]
        dest: "dist/jquery.hexagonize.min.js"

      options:
        banner: "<%= meta.banner %>"

    # Comple .jade file
    jade:
      compile:
        options:
          data:
            debug: false
          pretty: true
        files:
          "demo/index.html": "demo/index.jade"

    
    # CoffeeScript compilation
    coffee:
      compile:
        files:
          "src/jquery.hexagonize.js": "src/jquery.hexagonize.coffee"

  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.registerTask "default", [
    "jade"
    "coffee"
    "jshint"
    "concat"
    "uglify"
  ]
  grunt.registerTask "travis", ["jshint"]
