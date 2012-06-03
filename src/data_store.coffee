
should = require('./should')

store_types = [
  'database',
  'file',
  'remote'
]

DataStore = do ->
  stores = []


  DataStore = (options) ->
    provider =
    type = options.type
    should.notBeEmpty(type)
    should.contain(store_types, type)





