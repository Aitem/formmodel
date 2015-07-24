get_in = (obj, path) ->
  t = obj
  for x in path
    return null if !t
    if _isFn(x)
      t = t.filter(x)[0]
    else
      t = t[x]
  t
_isFn = (x)-> typeof(x) == 'function'

coordinates = (d)->
  k = "http://zdrav.spb.ru"
  get_in(d, [((x)-> get_in(x, ['url']) == k)])

coordinates_data = (d, k)->
  get_in(d, ['extension', ((x)-> get_in(x, ['url']) == k)])

from_coordinates = (extensions)->
  c = coordinates(extensions)
  [coordinates_data(c, 'latitude').valueString, coordinates_data(c, 'longitude').valueString]

to_coordinates = (extensions, m)->
  c = coordinates(extensions)
  unless c
    c =
      extension:[{url: 'latitude',},{url: 'longitude'}]
      url: "http://zdrav.spb.ru"
    unless typeof(extensions) == 'array'
      extensions = []
    extensions.push c
  coordinates_data(c, 'latitude').valueString = m[0]
  coordinates_data(c, 'longitude').valueString = m[1]
  extensions

from_address = (v)->
  v[0].text
  
to_address = (v, m)->
  v[0].text = m
  v

orgtype = (d)->
  k = "OrgType"
  get_in(d, ['coding', ((x)-> get_in(x, ['system']) == k)])

from_orgtype = (type)->
  type = orgtype(type)
  code: get_in(type, ['code'])
  system: 'OrgType'
  display: get_in(type, ['display'])

to_orgtype = (type, m)->
  t = orgtype(type)
  unless t
    t = {code:'', system:'', display:''}
    type.coding.push t
  t.code = m.code
  t.system = 'OrgType'
  t.display= m.display
  type

from = (o, m)->
  for k,v of o
    switch k
      when 'extension'
        m.coordinates = from_coordinates(v)
      when 'address'
        m.address = from_address(v)
      when 'type'
        m.orgtype = from_orgtype(v)
      else
        m[k] = v
  m

to = (o, m)->
  for k,v of m
    switch k
      when 'coordinates'
        o.extension = to_coordinates(o.extension, v)
      when 'address'
        o.address = to_address(o.address, v)
      when 'orgtype'
        o.type = to_orgtype(o.type, v)
      else
        o[k] = v
  o

module.exports =
  from: from
  to: to
