DEFAULT_DUMP_PERIOD = 5000
exports.DEFAULT_DUMP_INTERVAL = DEFAULT_DUMP_PERIOD

DataStore = require './data_store'


class DataObject
  killInterval = ->
    clearInterval(@interval)
    @interval = undefined

  constructor:(options = null) ->
    @dump_period = options.period ? DEFAULT_DUMP_PERIOD
    @dataStore = DataStore(options.provider)
    @data = options.data ? {}
    keys = options.keys ? []
    (@data[key] = undefined) for key in keys when typeof(@data[key]) == 'undefined'
    @load ->
      @interval = setInterval (=> @save()), @dump_period
      options.events?.down = ((cb) => @dump(cb))

  save: (cb) ->
    @dataStore.save(@data, cb)

  load: (cb) ->
    @dataStore.load(@data,cb)

  dump: (cb) ->
    killInterval.call(this)
    @save(cb)

  dispose: (cb) ->
    @dataStore.delete(@data,cb)





