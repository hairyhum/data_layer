
should = require './should'
async = require 'async'

DataStore = (provider) ->
  should.notBeEmpty provider
  should.haveProperty provider, 'get'
  should.haveProperty provider, 'set'
  should.haveProperty provider, 'delete'
  iterateAsync = (fun) ->
    (data,cb) ->
      props = key for key,val of data
      async.forEachSeries props
      ,(prop,callback) =>
        fun.call(@, prop, callback)
      ,(err) ->
        cb(err)
  Store =
    provider: provider
    load: iterateAsync (prop,callback) ->
      @provider.get prop, (value,err) ->
        data[prop] = value
        callback(err)

    save: iterateAsync (prop, callback) ->
      @provider.set data[prop], callback

    delete: iterateAsync (prop, callback) ->
      @provider.delete prop, (value,err) ->
        data[prop] = value
        callback(err)








