fs = require('fs')

exports.requirements = ->
  return typeof fs.realpathSync isnt 'undefined'

exports.Provider = (prefix = '', suffix = '', directory) ->
  directory = fs.realpathSync directory
  fileName = (key) ->
    directory + '/' + prefix + key + suffix
  self =
    set : (key, data) ->
      fs.writeFileSync fileName(key), JSON.stringify(data)
    get : (key) ->
      JSON.parse fs.readFileSync(fileName(key), JSON.stringify(data), 'utf8')
    delete: (key) ->
      data = @get key
      fs.unlinkSync fileName(key)
      data

