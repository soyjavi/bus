module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    meta:
      file: 'bus'
      endpoint: 'app/'
      banner: """
        /* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("m/d/yyyy") %>
           <%= pkg.homepage %>
           Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %> - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */

        """

    source:
      coffee: [
        'source/app.coffee',
        'source/models/*.coffee',
        'source/views/*.coffee',
        'source/controllers/*.coffee']

      stylesheets: [
        'source/stylesheets/*.styl',
        'source/components/lungo.theme/*.styl']

      css_core: [
        'source/components/lungo*/lungo.css',
        'source/components/lungo*/lungo.icon.css']

      js_core: [
        'source/components/quojs/quo.js',
        'source/components/lungo*/lungo.js',
        'source/components/monocle/monocle.js',
        'source/components/device.js/device.js',
        'source/components/hope/hope.js']

    coffee:
      compile: files: '<%= meta.endpoint %>static/javascripts/<%= meta.file %>.debug.js': ['<%= source.coffee %>']

    uglify:
      options: compress: false, banner: "<%= meta.banner %>"
      coffee: files: '<%= meta.endpoint %>static/javascripts/<%= meta.file %>.js': '<%= meta.endpoint %>static/javascripts/<%= meta.file %>.debug.js'
      core: files: '<%= meta.endpoint %>static/javascripts/<%= meta.file %>.core.js': '<%= source.js_core %>'

    stylus:
      stylesheets: files: '<%= meta.endpoint %>static/stylesheets/<%= meta.file %>.css': ['<%= source.stylesheets %>']

    concat:
      css:
        src: ['<%= source.css_core %>'],
        dest: '<%= meta.endpoint %>static/stylesheets/<%= meta.file %>.core.css'

    watch:
      coffee:
        files: ["<%= source.coffee %>"]
        tasks: ["coffee"]
      stylesheets:
        files: ["<%= source.stylesheets %>"]
        tasks: ["stylus"]
      core:
        files: ["<%= source.js_core %>", "<%= source.css_core %>"]
        tasks: ["uglify:core", "concat"]


  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-stylus"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-watch"

  grunt.registerTask "default", ["coffee", "uglify", "stylus", "concat"]
