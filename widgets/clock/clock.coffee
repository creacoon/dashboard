class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  startTime: =>
    today = new Date()

    h = today.getHours()
    m = @formatTime(today.getMinutes())
    s = today.getSeconds()
    @set('time', h + ":" + m)
    @set('date', today.toDateString())
	
  formatTime: (i) ->
    if i < 10 then "0" + i else i