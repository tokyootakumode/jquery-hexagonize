/*
 *  jQuery Hexagonize - v0.0.1
 *  make hexagon shape.
 *  http://jquery-hexagonize.github.io
 *
 *  Made by pchw
 *  Under MIT License
 */
(function() {
  (function($) {
    var Plugin, defaults, pluginName;
    pluginName = "hexagonize";
    defaults = {
      width: 200,
      height: 400
    };
    Plugin = (function() {
      function Plugin(element, options) {
        this.element = element;
        this.options = $.extend({}, defaults, options);
        this._defaults = defaults;
        this._name = pluginName;
        this.$element = $(this.element);
        this.init();
      }

      Plugin.prototype.init = function() {
        return this.applyHexagon();
      };

      Plugin.prototype.applyHexagon = function() {
        var $child, $grand, hover_url, img_url;
        if (!img_url) {
          img_url = this.$element.data("img-url");
        }
        if (!hover_url) {
          hover_url = this.$element.data("img-hover-url");
        }
        this.$element.css({
          width: this.options.width,
          height: this.options.height,
          marginTop: "-" + (this.options.height * 0.2) + "px",
          overflow: "hidden",
          visibility: "hidden",
          cursor: "pointer",
          "-webkit-transform": "rotate(120deg)",
          "-moz-transform": "rotate(120deg)",
          "-o-transform": "rotate(120deg)",
          transform: "rotate(120deg)"
        });
        $child = $("<div/>");
        $child.css({
          overflow: "hidden",
          width: "100%",
          height: "100%",
          "-webkit-transform": "rotate(-60deg)",
          "-moz-transform": "rotate(-60deg)",
          "-o-transform": "rotate(-60deg)",
          transform: "rotate(-60deg)"
        });
        $grand = $("<div/>");
        $grand.css({
          width: "100%",
          height: "100%",
          backgroundRepeat: "no-repeat",
          backgroundPosition: "50%",
          backgroundImage: "url(" + img_url + ")",
          visibility: "visible",
          "-webkit-transform": "rotate(-60deg)",
          "-moz-transform": "rotate(-60deg)",
          "-o-transform": "rotate(-60deg)",
          transform: "rotate(-60deg)"
        });
        $grand.hover(function() {
          return $(this).css("backgroundImage", "url(" + hover_url + ")");
        }, function() {
          return $(this).css("backgroundImage", "url(" + img_url + ")");
        });
        $child.append($grand);
        this.$element.append($child);
        return this.$element;
      };

      return Plugin;

    })();
    return $.fn[pluginName] = function(options) {
      return this.each(function() {
        if (!$.data(this, "plugin_" + pluginName)) {
          return $.data(this, "plugin_" + pluginName, new Plugin(this, options));
        }
      });
    };
  })(jQuery);

}).call(this);
