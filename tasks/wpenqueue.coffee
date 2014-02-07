# Load dependencies
getFiles = require '../lib/files'
ect      = require 'ect'

# Create template renderer
{ render } = ect root: "#{__dirname}/../templates", ext: '.ect'

# Grunt plugin for enqueueing scripts and stylesheets in a WordPress theme or
# plugin. Handles incrementing version numbers.
#
# @param [Object] grunt
#
module.exports = (grunt) ->

  grunt.registerMultiTask 'enqueue', ->

    @options = @data.options ? {}

    # Get file names
    versionFile = @options.versionFile ? ".enqueue-#{@target}.json"
    enqueueFile = @options.enqueueFile ? "enqueue-#{@target}.php"

    # Get the versions
    try
      versionData = grunt.file.readJSON versionFile
    catch e
      versionData = {}

    # Render the enqueue php file
    enqueueSrc = render 'enqueue.php',
      files: getFiles @files, versionData
      functionName: @options.functionName ? "enqueue_#{@target}"
      directory: if @options.parentTheme then 'template' else 'stylesheet'

    # Update the version file
    grunt.file.write versionFile, JSON.stringify versionData, null, 2

    # Write the enqueue file
    grunt.file.write enqueueFile, enqueueSrc

