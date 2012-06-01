
isArray = (value) ->
  typeof value == 'object' && value instanceof Array

should = exports

exports.equal  = (first,second) ->
    if first != second
      throw new Exception 'Values should equal! \n First: ' + JSON.stringify(first) + ' \n Second: '+JSON.stringify(second)

exports.beArray = (value) ->
  if !isArray(value)
    throw new Exception 'Value should be array! \n Value: ' + JSON.stringify(value)

exports.beObject = (value) ->
  if typeof value != 'object'
    throw new Exception 'Value should be object! \n Value: ' + JSON.stringify(value)

exports.beEmpty = (value) ->
  if value == null
    return
  if typeof value == 'undefined'
    return
  throw new Exception 'Value should be empty! \n Value: ' + JSON.stringify(value)

exports.notBeEmpty = (value) ->
  if value == null || typeof value == 'undefined'
    throw new Exception 'Value should not be empty! \n Value: ' + JSON.stringify(value)

exports.beNull = (value) ->
  if value == null
    return
  throw new Exception 'Value should be empty! \n Value: ' + JSON.stringify(value)

exports.contain = (array,value) ->
  should.beArray(array)
  if array.indexOf(value) == -1
    throw new Exception 'Array should contain value! \n Array: ' + JSON.stringify(array) + ' \n Value: ' + JSON.stringify(value)

exports.haveProperty = (object, propKey) ->
  should.beObject(object)
  if !object.hasOwnProperty(propKey)
    throw new Exception 'Object should have property! \n Object: ' + JSON.stringify(array) + ' \n Property: ' + JSON.stringify(value)
