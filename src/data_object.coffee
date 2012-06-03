DEFAULT_DUMP_PERIOD = 5000
exports.DEFAULT_DUMP_INTERVAL = DEFAULT_DUMP_PERIOD

DataStore = require './data_store'
Environment = require './environment'

class DataObject
  constructor:(options = null) ->
    @dump_period = options.period ? DEFAULT_DUMP_PERIOD
    @dataStore = DataStore(options.store ? Environment.getStore())
    @data = options.data ? {}
    keys = options.keys ? []
    @data[key] = undefined for key in keys when typeof(@data[key]) == 'undefined'
    @load()
    @interval = setInterval => @save(), @dump_period
    eventMachine = Environment.getEventMachine()
    eventMachine.regiter 'down', => @kill()

  save: ->
    @dataStore.save(@data)

  load: ->
    @dataStore.load(@data)

  kill: ->
    clearInterval(@interval)
    @interval = undefined
    @save()





