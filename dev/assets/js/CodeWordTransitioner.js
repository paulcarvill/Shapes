
      var CodeWordTransitioner, encode;
      CodeWordTransitioner = (function() {
        function CodeWordTransitioner() {}

        CodeWordTransitioner.config = {
          MIN_WRONG_CHARS: 1,
          MAX_WRONG_CHARS: 7,
          MIN_CHAR_IN_DELAY: 40,
          MAX_CHAR_IN_DELAY: 70,
          MIN_CHAR_OUT_DELAY: 80,
          MAX_CHAR_OUT_DELAY: 140,
          CHARS: '•••••••••••••‣◆‣◆‣◆‣◆‣◆‣◆∙∘‣◆∙∘‣◆∙∘‣◆∙∘••......'.split('').map(function(char) {
            return char;
          }),
          CHAR_TEMPLATE: "<span data-codetext-char=\"{{ char }}\" data-codetext-char-state=\"{{ state }}\">{{ char }}</span>"
        };

        CodeWordTransitioner._wordCache = {};

        CodeWordTransitioner._getWordFromCache = function($el, initialState) {
          var id, word;
          if (initialState == null) {
            initialState = null;
          }
          id = $el.attr('data-codeword-id');
          if (id && CodeWordTransitioner._wordCache[id]) {
            word = CodeWordTransitioner._wordCache[id];
          } else {
            CodeWordTransitioner._wrapChars($el, initialState);
            word = CodeWordTransitioner._addWordToCache($el);
          }
          return word;
        };

        CodeWordTransitioner._addWordToCache = function($el) {
          var chars, id;
          chars = [];
          $el.find('[data-codetext-char]').each(function(i, el) {
            var $charEl;
            $charEl = $(el);
            return chars.push({
              $el: $charEl,
              rightChar: $charEl.attr('data-codetext-char')
            });
          });
          id = _.uniqueId();
          $el.attr('data-codeword-id', id);
          CodeWordTransitioner._wordCache[id] = {
            word: _.pluck(chars, 'rightChar').join(''),
            $el: $el,
            chars: chars,
            visible: true
          };
          return CodeWordTransitioner._wordCache[id];
        };

        CodeWordTransitioner._wrapChars = function($el, initialState) {
          // var char, chars, html, j, len, state;
          // if (initialState == null) {
          //   initialState = null;
          // }
          // chars = $el.text().split('');
          // state = initialState || $el.attr('data-codeword-initial-state') || "";
          // html = [];
          // for (j = 0, len = chars.length; j < len; j++) {
          //   char = chars[j];
          //   if (char === ' ') {
          //     char = '&nbsp;';
          //   }
          //   html.push(CodeWordTransitioner._supplantString(CodeWordTransitioner.config.CHAR_TEMPLATE, {
          //     char: char,
          //     state: state
          //   }));
          // }
          // $el.html(html.join(''));
          // return null;
        };

        CodeWordTransitioner._prepareWord = function(word, target, charState) {
          var char, i, j, len, ref, targetChar;
          if (charState == null) {
            charState = '';
          }
          ref = word.chars;
          for (i = j = 0, len = ref.length; j < len; i = ++j) {
            char = ref[i];
            targetChar = (function() {
              switch (true) {
                case target === 'right':
                  return char.rightChar;
                case target === 'wrong':
                  return this._getRandomChar();
                case target === 'empty':
                  return '';
                default:
                  return target.charAt(i) || '';
              }
            }).call(CodeWordTransitioner);
            if (targetChar === ' ') {
              targetChar = '&nbsp;';
            }
            char.wrongChars = CodeWordTransitioner._getRandomWrongChars();
            char.targetChar = targetChar;
            char.charState = charState;
          }
          return null;
        };

        CodeWordTransitioner._getRandomWrongChars = function() {
          var charCount, chars, i, j, ref;
          chars = [];
          charCount = _.random(CodeWordTransitioner.config.MIN_WRONG_CHARS, CodeWordTransitioner.config.MAX_WRONG_CHARS);
          for (i = j = 0, ref = charCount; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
            chars.push({
              char: CodeWordTransitioner._getRandomChar(),
              inDelay: _.random(CodeWordTransitioner.config.MIN_CHAR_IN_DELAY, CodeWordTransitioner.config.MAX_CHAR_IN_DELAY),
              outDelay: _.random(CodeWordTransitioner.config.MIN_CHAR_OUT_DELAY, CodeWordTransitioner.config.MAX_CHAR_OUT_DELAY)
            });
          }
          return chars;
        };

        CodeWordTransitioner._getRandomChar = function() {
          var char;
          char = CodeWordTransitioner.config.CHARS[_.random(0, CodeWordTransitioner.config.CHARS.length - 1)];
          return char;
        };

        CodeWordTransitioner._getLongestCharDuration = function(chars) {
          var char, i, j, k, len, len1, longestTime, longestTimeIdx, ref, time, wrongChar;
          longestTime = 0;
          longestTimeIdx = 0;
          for (i = j = 0, len = chars.length; j < len; i = ++j) {
            char = chars[i];
            time = 0;
            ref = char.wrongChars;
            for (k = 0, len1 = ref.length; k < len1; k++) {
              wrongChar = ref[k];
              time += wrongChar.inDelay + wrongChar.outDelay;
            }
            if (time > longestTime) {
              longestTime = time;
              longestTimeIdx = i;
            }
          }
          return longestTimeIdx;
        };

        CodeWordTransitioner._animateChars = function(word, sequential, cb) {
          var activeChar, args, char, i, j, len, longestCharIdx, ref;
          activeChar = 0;
          if (sequential) {
            CodeWordTransitioner._animateChar(word.chars, activeChar, true, cb);
          } else {
            longestCharIdx = CodeWordTransitioner._getLongestCharDuration(word.chars);
            ref = word.chars;
            for (i = j = 0, len = ref.length; j < len; i = ++j) {
              char = ref[i];
              args = [word.chars, i, false];
              if (i === longestCharIdx) {
                args.push(cb);
              }
              CodeWordTransitioner._animateChar.apply(CodeWordTransitioner, args);
            }
          }
          return null;
        };

        CodeWordTransitioner._animateChar = function(chars, idx, recurse, cb) {
          var char;
          char = chars[idx];
          if (recurse) {
            CodeWordTransitioner._animateWrongChars(char, function() {
              if (idx === chars.length - 1) {
                return CodeWordTransitioner._animateCharsDone(cb);
              } else {
                return CodeWordTransitioner._animateChar(chars, idx + 1, recurse, cb);
              }
            });
          } else {
            if (typeof cb === 'function') {
              CodeWordTransitioner._animateWrongChars(char, function() {
                return CodeWordTransitioner._animateCharsDone(cb);
              });
            } else {
              CodeWordTransitioner._animateWrongChars(char);
            }
          }
          return null;
        };

        CodeWordTransitioner._animateWrongChars = function(char, cb) {
          var wrongChar;
          if (char.wrongChars.length) {
            wrongChar = char.wrongChars.shift();
            setTimeout(function() {
              char.$el.html(wrongChar.char);
              return setTimeout(function() {
                return CodeWordTransitioner._animateWrongChars(char, cb);
              }, wrongChar.outDelay);
            }, wrongChar.inDelay);
          } else {
            char.$el.attr('data-codetext-char-state', char.charState).html(char.targetChar);
            if (typeof cb === "function") {
              cb();
            }
          }
          return null;
        };

        CodeWordTransitioner._animateCharsDone = function(cb) {
          if (typeof cb === "function") {
            cb();
          }
          return null;
        };

        CodeWordTransitioner._supplantString = function(str, vals) {
          return str.replace(/([^{}]*)/g, function(a, b) {
            var r;
            r = vals[b];
            if (typeof r === "string" || typeof r === "number") {
              return r;
            } else {
              return a;
            }
          });
        };

        CodeWordTransitioner.to = function(targetText, $el, charState, sequential, cb) {
          var _$el, j, len, word;
          if (sequential == null) {
            sequential = false;
          }
          if (cb == null) {
            cb = null;
          }
          if (_.isArray($el)) {
            for (j = 0, len = $el.length; j < len; j++) {
              _$el = $el[j];
              CodeWordTransitioner.to(targetText, _$el, charState, sequential, cb);
            }
            return;
          }
          word = CodeWordTransitioner._getWordFromCache($el);
          word.visible = true;
          CodeWordTransitioner._prepareWord(word, targetText, charState);
          CodeWordTransitioner._animateChars(word, sequential, cb);
          return null;
        };

        CodeWordTransitioner["in"] = function($el, charState, sequential, cb) {
          var _$el, j, len, word;
          if (sequential == null) {
            sequential = false;
          }
          if (cb == null) {
            cb = null;
          }
          if (_.isArray($el)) {
            for (j = 0, len = $el.length; j < len; j++) {
              _$el = $el[j];
              CodeWordTransitioner["in"](_$el, charState, sequential, cb);
            }
            return;
          }
          word = CodeWordTransitioner._getWordFromCache($el);
          word.visible = true;
          CodeWordTransitioner._prepareWord(word, 'right', charState);
          CodeWordTransitioner._animateChars(word, sequential, cb);
          return null;
        };

        CodeWordTransitioner.out = function($el, charState, sequential, cb) {
          var _$el, j, len, word;
          if (sequential == null) {
            sequential = false;
          }
          if (cb == null) {
            cb = null;
          }
          if (_.isArray($el)) {
            for (j = 0, len = $el.length; j < len; j++) {
              _$el = $el[j];
              CodeWordTransitioner.out(_$el, charState, sequential, cb);
            }
            return;
          }
          word = CodeWordTransitioner._getWordFromCache($el);
          if (!word.visible) {
            return;
          }
          word.visible = false;
          CodeWordTransitioner._prepareWord(word, 'empty', charState);
          CodeWordTransitioner._animateChars(word, sequential, cb);
          return null;
        };

        CodeWordTransitioner.scramble = function($el, charState, sequential, cb) {
          var _$el, j, len, word;
          if (sequential == null) {
            sequential = false;
          }
          if (cb == null) {
            cb = null;
          }
          if (_.isArray($el)) {
            for (j = 0, len = $el.length; j < len; j++) {
              _$el = $el[j];
              CodeWordTransitioner.scramble(_$el, charState, sequential, cb);
            }
            return;
          }
          word = CodeWordTransitioner._getWordFromCache($el);
          if (!word.visible) {
            return;
          }
          CodeWordTransitioner._prepareWord(word, 'wrong', charState);
          CodeWordTransitioner._animateChars(word, sequential, cb);
          return null;
        };

        CodeWordTransitioner.unscramble = function($el, charState, sequential, cb) {
          var _$el, j, len, word;
          if (sequential == null) {
            sequential = false;
          }
          if (cb == null) {
            cb = null;
          }
          if (_.isArray($el)) {
            for (j = 0, len = $el.length; j < len; j++) {
              _$el = $el[j];
              CodeWordTransitioner.unscramble(_$el, charState, sequential, cb);
            }
            return;
          }
          word = CodeWordTransitioner._getWordFromCache($el);
          if (!word.visible) {
            return;
          }
          CodeWordTransitioner._prepareWord(word, 'right', charState);
          CodeWordTransitioner._animateChars(word, sequential, cb);
          return null;
        };

        CodeWordTransitioner.prepare = function($el, initialState) {
          var _$el, j, len;
          if (_.isArray($el)) {
            for (j = 0, len = $el.length; j < len; j++) {
              _$el = $el[j];
              CodeWordTransitioner.prepare(_$el, initialState);
            }
            return;
          }
          CodeWordTransitioner._getWordFromCache($el, initialState);
          return null;
        };

        CodeWordTransitioner.getScrambledWord = function(word) {
          var char, j, len, newChars, ref;
          newChars = [];
          ref = word.split('');
          for (j = 0, len = ref.length; j < len; j++) {
            char = ref[j];
            newChars.push(CodeWordTransitioner._getRandomChar());
          }
          return newChars.join('');
        };

        CodeWordTransitioner.getWrappedWord = function(word) {
          var $tempEl;
          $tempEl = $('<div />');
          $tempEl.text(word);
          CodeWordTransitioner._wrapChars($tempEl);
          return $tempEl.html();
        };

        return CodeWordTransitioner;

      })();