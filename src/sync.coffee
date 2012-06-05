module.exports = ->
  data = Backbone.Model()
  data.attributes = {a:12,b:23}
  data.changeDates = {a:1338927199999}
  syncDate = 1338927100000
  server = {}

  crc = data.getCrc()
  server_data = server.getDataFrom(syncDate, crc)
  if server_data.ok?
    return

  time = server_data.time

  data.set attr, val for attr, val of server_data.data when not data.changeDates[attr]?
  for attr,val of server_data.changeDates when data.changeDates[attr]? and val > data.changeDates[attr]
    do (attr,val) ->
      data.set attr, server_data.data[attr]



  send = data.get attr for attr,val of data.changeDates
  server.setData(send)

  syncDate = time

  crc = data.getCrc()
  server_data = server.getDataFrom(syncDate, crc)
  if not server_data.ok? and not server_data.changeDates?
    server.setData(data.attributes)


