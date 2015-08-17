class Dashing.JenkinsFailing extends Dashing.Widget
  constructor: ->
    super
    @_setClass()

  @accessor 'green', Dashing.AnimatedValue

  @accessor 'hasRedJobs', ->
    @get('red')?.length > 0

  onData: (data) =>
    @_setClass()

  _setClass: ->
    $(@get('node')).toggleClass 'failing', @get('hasRedJobs')
