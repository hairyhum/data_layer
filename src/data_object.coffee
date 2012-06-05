DUMP_INTERVAL = 5000
exports.DUMP_INTERVAL = DUMP_INTERVAL

DUMP_INTERVAL_SYNC = 50000
exports.DUMP_INTERVAL_SYNC = DUMP_INTERVAL_SYNC


DataStore = require './data_store'
SyncProvider = require './sync_provider'
LocalProvider = require './browser/local_storage_provider'
SyncService = require './sync'


class DataObject
  constructor:(data, options = null) ->
    dump_period = options.interval ? DUMP_INTERVAL
    @local_store = DataStore(new LocalProvider(options.prefix, options.suffix))

    if options.sync
      sync = options.sync
      sync_period = sync.interval ? DUMP_INTERVAL_SYNC
      @sync_store = DataStore(new SyncProvider(sync.provider))

    @data = data ? {}
    keys = key for key,val of data when typeof data[key] is 'undefined'
    @load ->
      interval = setInterval (=> @save()), dump_period
      if sync
        sync_interval = setInterval (=> @sync()), dump_period
      @kill = (cb) ->
        clearInterval interval
        clearInterval sync_interval
        @save(cb)
      options.events?.down = (cb) => @kill(cb)

  save: (cb) ->
    @local_store.save @data, cb

  load: (cb) ->
    @local_store.load @data,cb

  sync: (cb) ->
    @save ->
      SyncService.sync @data, @sync_store

  destroy_local: (cb) ->
    @kill ->
      @local_store.delete @data,cb

  destroy: (cb) ->
    @sync_store.delete @data, ->
      @destroy_local cb



