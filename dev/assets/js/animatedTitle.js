var video;
var videos;
var currentVideo;
var videoWidth;
var videoHeight;

function c(a,b,c){
	var d = b || 0,
	e = c || 150;
	return Math.min(Math.max(a,d),e)
}

var h = 150;
var i = 60;
var j = {

	isTitleSlidingOut : [!1, !1, !1, !1, !1],
	persistentHeaderHeight : 0,
	scollTopDocument : 0,
	allTitleYs: [],

	cancelRender : function(){
		this.$window &&
			window.cancelAnimationFrame &&
			(this.$window[0].cancelAnimationFrame(this.idRequestAnimationFrame),
				this.isRequestAnimationFrameRunning=!1
			)
	},

	handleTitleAnimationOnWindowScrollResize : function(a){
		var b = this;
		return "resize" === a.type && (this.windowHeight = this.$window.height()),
		"scroll" === a.type && (this.scollTopDocument = $(document).scrollTop()),
		this.$allAnimatedTitles.each(function(index){
			b.handleTitleAnimation(index);
		})
	},

	handleTitleAnimation : function(animatedTitleIndex) {
		var a = this,
		
		/* check element has come into view */
		b = function(){
			var b = a.windowHeight - a.persistentHeaderHeight;
			return a.scollTopDocument + b > a.animatedTitleTops[animatedTitleIndex];
		},
		
		/* check element has not scrolled out top of view yet */
		c = function(){
			var b = a.animatedTitleTops[animatedTitleIndex] + a.animatedTitleHeights[animatedTitleIndex];
			return a.scollTopDocument<b
		},
		
		d = function(){
			var b = function(){
				var b = a.scollTopDocument + a.persistentHeaderHeight + i;
				return b > a.animatedTitleTops[animatedTitleIndex]
			};
		
			return b() && c()
		};

		if (b() && c()) {
			// when next pic comes into view
			if(animatedTitleIndex > currentVideo){
				// reshow original img
				video.style.display="inline";
				currentVideo = animatedTitleIndex;
				init();
			}
			(this.isTitleSlidingOut[animatedTitleIndex] = !1, this.runRender(), (d() && (this.isTitleSlidingOut[animatedTitleIndex] = !0)))
		}
	},

	initializeRequestAnimationFrame : function(){
		if(this.$window){
			for(var a = this.$window[0], b=0, c=["webkit","moz"], d=0;
				d < c.length && !a.requestAnimationFrame; ++d) {
					a.requestAnimationFrame = a[c[d]+"RequestAnimationFrame"],
					a.cancelAnimationFrame = a[c[d]+"CancelAnimationFrame"]||a[c[d]+"CancelRequestAnimationFrame"];
					a.requestAnimationFrame || (a.requestAnimationFrame=function(c){
						var d = (new Date).getTime(),
							e = Math.max(0,16-(d-b)),
							f = a.setTimeout(function(){
								c(d+e)
							}, e);
						return b = d + e, f
					}),
					a.cancelAnimationFrame || (a.cancelAnimationFrame=function(a){
						clearTimeout(a)
					})
				}
		}
	},

	initializeTitleAnimation : function(){
		var a = this;
		this.renderTitlePosition();
		this.$allAnimatedTitles.each(function(index){
			a.handleTitleAnimation(index);
		})
		this.initializeRequestAnimationFrame(),
		this.isAnimatedTitleinitialized = !0
	},

	prefixedTransformTranslateY:function(a){
		var b = Math.ceil(a);

		return{
			"-webkit-transform":"translateY("+b+"%)",
			"-ms-transform":"translateY("+b+"%)",
			transform:"translateY("+b+"%)"
		}
	},

	refreshCachedValues:function(){
		this.windowHeight = this.$window.height(),
		this.animatedTitleHeights = this.$allAnimatedTitles.map(function () {
			return $(this).height();
		});
		this.animatedTitleTops = this.$allAnimatedTitles.map(function () {
			return $(this).parent().offset().top
		});
	},

	renderTitlePosition : function(index){
		var a = this;
		this.$allAnimatedTitles.each(function(index){
			$(this).css(a.prefixedTransformTranslateY(a.allTitleYs[index]));
			if(shapes_size.width > shapes_size.height){
				$(this).closest('.meta').css(a.prefixedTransformTranslateY(a.allTitleYs[index]/10));
			}
		})
	},

	runRender : function(){
		if(!this.isRequestAnimationFrameRunning){
			this.refreshCachedValues();

			var a = this.$window[0], b = this;
			b.renderFrame = function(){

				b.$allAnimatedTitles.each(function(index){
					b.updateTitlePosition(index)
					b.renderTitlePosition(index)
				}),
				b.idRequestAnimationFrame = a.requestAnimationFrame(b.renderFrame)
			},
			this.idRequestAnimationFrame = a.requestAnimationFrame(this.renderFrame),
			this.isRequestAnimationFrameRunning = !0
		}
	},

	setTitleY : function(a, index){
		this.allTitleYs[index] = c(a)
	},

	setupAnimatedTitle : function(){
		this.$allAnimatedTitles = $('h2'),
		this.setupBindings(),
		this.refreshCachedValues(),
		this.initializeTitleAnimation();
	},

	setupBindings : function(){
		"undefined" != typeof window && (
			this.$window = $(window),
			this.updateHandler = this.handleTitleAnimationOnWindowScrollResize.bind(this),
			this.lazyUpdateHandler = _.debounce(this.handleTitleAnimationOnWindowScrollResize.bind(this),100),
			this.$window.on("scroll",this.updateHandler).on("resize",this.lazyUpdateHandler)
		)
	},

	updateTitlePosition : function(animatedTitleIndex) {
		var a , b = this.windowHeight/2;
		if(!this.isTitleSlidingOut[animatedTitleIndex]){
			var c = this.windowHeight - this.persistentHeaderHeight,
			//d = this.scollTopDocument + c/2;
			d = this.scollTopDocument + c/2;
			return a = (this.animatedTitleTops[animatedTitleIndex] - d) * h/b, this.setTitleY(a, animatedTitleIndex)
		}

		var e = this.scollTopDocument + this.persistentHeaderHeight + i;
		a = -(100*(this.animatedTitleTops[animatedTitleIndex]-e)) / (4*this.animatedTitleHeights[animatedTitleIndex]),
		this.setTitleY(a, animatedTitleIndex);
	}

}