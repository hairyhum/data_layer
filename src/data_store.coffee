
should = require './should'
async = require 'async'

DataStore = (provider) ->
  should.notBeEmpty provider
  should.haveProperty provider, 'get'
  should.haveProperty provider, 'set'
  should.haveProperty provider, 'delete'
  Store =
    provider: provider
    load: (data, cb) ->
      props = data.getOwnPropertyNames()
      async.forEachSeries props
      (prop,callback) =>
        @provider.get prop, (value,err) ->
          data[prop] = value
          callback(err)
      (err) ->
        cb(err)
    save: (data, cb) ->
      props = data.getOwnPropertyNames()
      async.forEachSeries props
      (prop, callback) =>
        @provider.set data[prop], callback
      (err) ->
        cb(err)









