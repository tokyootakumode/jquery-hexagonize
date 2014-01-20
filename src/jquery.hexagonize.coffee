# Note that when compiling with coffeescript, the plugin is wrapped in another
# anonymous function. We do not need to pass in undefined as well, since
# coffeescript uses (void 0) instead.
do ($ = jQuery) ->

  # window and document are passed through as local variable rather than global
  # as this (slightly) quickens the resolution process and can be more efficiently
  # minified (especially when both are regularly referenced in your plugin).

  # Create the defaults once
  pluginName = "hexagonize"
  defaults =
    width: 200
    height: 400

  # The actual plugin constructor
  class Plugin
    constructor: (@element, options) ->
      # jQuery has an extend method which merges the contents of two or
      # more objects, storing the result in the first object. The first object
      # is generally empty as we don't want to alter the default options for
      # future instances of the plugin
      @options = $.extend {}, defaults, options
      @_defaults = defaults
      @_name = pluginName
      @$element = $ @element
      @init()

    init: ->
      do @applyHexagon
      # Place initialization logic here
      # You already have access to the DOM element and the options via the instance,
      # e.g., @element and @options

    applyHexagon: ->
      img_url = @$element.data("img-url")  unless img_url
      hover_url = @$element.data("img-hover-url")  unless hover_url
      @$element.css
        width: @options.width
        height: @options.height
        marginTop: "-#{@options.height*0.2}px"
        overflow: "hidden"
        visibility: "hidden"
        cursor: "pointer"
        "-webkit-transform": "rotate(120deg)"
        "-moz-transform": "rotate(120deg)"
        "-o-transform": "rotate(120deg)"
        transform: "rotate(120deg)"

      $child = $("<div/>")
      $child.css
        overflow: "hidden"
        width: "100%"
        height: "100%"
        "-webkit-transform": "rotate(-60deg)"
        "-moz-transform": "rotate(-60deg)"
        "-o-transform": "rotate(-60deg)"
        transform: "rotate(-60deg)"

      $grand = $("<div/>")
      $grand.css
        width: "100%"
        height: "100%"
        backgroundRepeat: "no-repeat"
        backgroundPosition: "50%"
        backgroundImage: "url(#{img_url})"
        visibility: "visible"
        "-webkit-transform": "rotate(-60deg)"
        "-moz-transform": "rotate(-60deg)"
        "-o-transform": "rotate(-60deg)"
        transform: "rotate(-60deg)"

      $grand.hover ->
        $(this).css "backgroundImage", "url(#{hover_url})"
      , 
        ->
          $(this).css "backgroundImage", "url(#{img_url})"

      $child.append $grand
      @$element.append $child

      @$element

  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(@, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))
