(function() {
  (function($) {
    var Plugin, defaults, pluginName;
    pluginName = "hexagonize";
    defaults = {
      width: 200,
      height: 400,
      margin_top_offset: 0,
      hover_target: null
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
        var $child, $cover, $grand, $hov, $hover_target, hover_url, img_url;
        if (!img_url) {
          img_url = this.$element.data("img-url");
        }
        if (!hover_url) {
          hover_url = this.$element.data("img-hover-url");
        }
        this.$element.css({
          width: this.options.width,
          height: this.options.height,
          marginTop: this.options.margin_top_offset || -this.options.height * 0.2,
          overflow: "hidden",
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
          position: "relative",
          top: "-200%",
          overflow: "hidden",
          width: "100%",
          height: "100%",
          backgroundRepeat: "no-repeat",
          backgroundPosition: "50%",
          backgroundImage: "url(" + img_url + ")",
          "-webkit-transform": "rotate(-60deg)",
          "-moz-transform": "rotate(-60deg)",
          "-o-transform": "rotate(-60deg)",
          transform: "rotate(-60deg)"
        });
        $cover = $("<div/>");
        $cover.css({
          position: "relative",
          top: "-100%",
          overflow: "hidden",
          width: "100%",
          height: "100%",
          backgroundColor: "rgba(255,255,255,0.5)",
          "-webkit-transform": "rotate(-60deg)",
          "-moz-transform": "rotate(-60deg)",
          "-o-transform": "rotate(-60deg)",
          transform: "rotate(-60deg)"
        });
        $hov = $("<div/>");
        $hov.css({
          overflow: "hidden",
          width: "100%",
          height: "100%",
          backgroundRepeat: "no-repeat",
          backgroundPosition: "50%",
          backgroundImage: "url(" + hover_url + ")",
          "-webkit-transform": "rotate(-60deg)",
          "-moz-transform": "rotate(-60deg)",
          "-o-transform": "rotate(-60deg)",
          transform: "rotate(-60deg)"
        });
        $hover_target = $(this.options.hover_target) || this.$element;
        $hover_target.hover(function() {
          return $grand.stop().fadeOut(250);
        }, function() {
          return $grand.stop().fadeIn(250);
        });
        $child.append($hov);
        $child.append($cover);
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
