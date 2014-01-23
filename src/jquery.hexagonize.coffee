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
    margin_top_offset: 0
    hover_target: null

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
        marginTop: @options.margin_top_offset || -@options.height*0.2
        overflow: "hidden"
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
        position: "relative"
        top: "-200%"
        overflow: "hidden"
        width: "100%"
        height: "100%"
        backgroundRepeat: "no-repeat"
        backgroundPosition: "50%"
        backgroundImage: "url(#{img_url})"
        "-webkit-transform": "rotate(-60deg)"
        "-moz-transform": "rotate(-60deg)"
        "-o-transform": "rotate(-60deg)"
        transform: "rotate(-60deg)"

      $cover = $("<div/>")
      $cover.css
        position: "relative"
        top: "-100%"
        overflow: "hidden"
        width: "100%"
        height: "100%"
        backgroundColor: "rgba(255,255,255,0.5)"
        "-webkit-transform": "rotate(-60deg)"
        "-moz-transform": "rotate(-60deg)"
        "-o-transform": "rotate(-60deg)"
        transform: "rotate(-60deg)"

      $hov = $("<div/>")
      $hov.css
        overflow: "hidden"
        width: "100%"
        height: "100%"
        backgroundRepeat: "no-repeat"
        backgroundPosition: "50%"
        backgroundImage: "url(#{hover_url})"
        "-webkit-transform": "rotate(-60deg)"
        "-moz-transform": "rotate(-60deg)"
        "-o-transform": "rotate(-60deg)"
        transform: "rotate(-60deg)"

      $hover_target = $(@options.hover_target) or @$element

      $hover_target.hover ->
        $grand.stop(true, true).fadeOut 250
      , 
        ->
          $grand.stop(true, true).fadeIn 250
      
      $child.append $hov
      $child.append $cover
      $child.append $grand
      @$element.append $child

      @$element

  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(@, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))
