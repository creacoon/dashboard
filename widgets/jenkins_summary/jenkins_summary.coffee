class Dashing.JenkinsSummary extends Dashing.Widget
  @height = 0
  constructor: ->
    super
    @_setClass()
    window.scroll_height = 0

    window.setInterval (->
      elem = document.getElementById('failing_container')
      elem.scrollTop = window.scroll_height
      window.scroll_height += 1
      console.log window.scroll_height
      if window.scroll_height >= document.getElementById('failing_container').scrollHeight
        elem.scrollTop = 0
        window.scroll_height = 0
      return
    ), 100


  @accessor 'green', Dashing.AnimatedValue

  @accessor 'hasRedJobs', ->
    @get('red') > 0

  onData: (data) =>
    @_setClass()

  _setClass: ->
    $(@get('node')).toggleClass 'failing', @get('hasRedJobs')
