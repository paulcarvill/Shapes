var namespace,
  __slice = [].slice;

namespace = function(target, name, block) {
  var item, top, _i, _len, _ref, _ref1;
  _ref = arguments.length < 3 ? [(typeof exports !== 'undefined' ? exports : window)].concat(__slice.call(arguments)) : void 0, target = _ref[0], name = _ref[1], block = _ref[2];
  top = target;
  _ref1 = name.split('.');
  for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
    item = _ref1[_i];
    target = target[item] || (target[item] = {});
  }
  return block(target, top);
};

namespace("App", function(exports) {
  exports.hello = function(subject) {
    if (subject == null) {
      subject = "world";
    }
    console.log("Hello, " + subject + ".");
  };
  (exports.init = function() {
    $("html").removeClass("no-js");
  })();
});

//# sourceMappingURL=scripts.js.map
$('nav li a>span').each(function(){
  CodeWordTransitioner.to($(this).data('name'), $(this));
});

$('nav li a>span').on('mouseover', function(){
  CodeWordTransitioner.to($(this).data('name'), $(this));
});