
should = require('./should')

store_types = [
  'database',
  'file',
  'remote'
]

DataStore = (options) ->
  type = options.type
  should.notBeEmpty(type)
  should.contain(store_types, type)



