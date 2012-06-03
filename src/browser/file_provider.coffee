exports.requirements = ->
  return typeof localStorage isnt 'undefined'

exports.Provider = (prefix = '', suffix = '') ->
  getKey = (key) ->
    prefix + key + suffix
  provider =
    set: (key,data) ->
      localStorage.setItem getKey(key), JSON.stringify(data)
    get: (key) ->
      JSON.parse localStorage.getItem(getKey(key))
    delete: (key) ->
      data = @get key
      localStorage.removeItem getKey(key)
      data