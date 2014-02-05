# Load dependencies
crypto = require 'crypto'
fs     = require 'fs'

# Generate the sha1 sum of a file synchronously
#
# @param  [String] path
# @return [String]
#
module.exports = (path) ->
  try
    shasum = crypto.createHash 'sha1'
    shasum.update fs.readFileSync path
    shasum.digest 'hex'
  catch e
    null

