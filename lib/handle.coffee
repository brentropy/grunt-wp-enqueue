# Load dependencies
path = require 'path'

# Build a WordPress enqueue handle from a file path
#
# @param [string] file relative file path
# @return [string]
#
module.exports = (file) ->
  file.replace ///#{path.sep}|\.///g, '_'
