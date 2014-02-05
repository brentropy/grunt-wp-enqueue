# Load Dependencies
getShasum = require './shasum'
handle    = require './handle'
path      = require 'path'

# Get array of files to be enqueued.
#
# @param  [Object[]] files
# @param  [Object]   versionData
# @return [Object[]]
#
module.exports = (files, versionData) ->
  data = []

  # Iterate over all sources in the files array
  for sources in files
    for file in sources.src
      # Create key for new files
      versionData[file] = mtime: null, version: 0 unless versionData[file]?

      # Increment version number for changed files
      shasum = getShasum file
      if shasum != versionData[file].shasum
        versionData[file].shasum = shasum
        versionData[file].version += 1

      # Add to enqueue template data
      data.push
        handle: handle file
        type: if path.extname(file) == '.css' then 'style' else 'script'
        file: file
        version: versionData[file].version
        deps: '' # TODO

  # Return
  data

