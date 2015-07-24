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
  latitude: coordinates_data(c, 'latitude').valueString
  longitude: coordinates_data(c, 'longitude').valueString

to_coordinates = (extensions, m)->
  c = coordinates(extensions)
  coordinates_data(c, 'latitude').valueString = m.latitude
  coordinates_data(c, 'longitude').valueString = m.longitude
  extensions

from = (o, m)->
  for k,v of o
    switch k
      when 'extension'
        m.coordinates = from_coordinates(v)
  m

to = (o, m)->
  for k,v of m
    switch k
      when 'coordinates'
        o.extension = to_coordinates(o.extension, v)
  o

module.exports =
  from: from
  to: to

