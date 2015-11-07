

		//Bad TV Effect Demo
		//Using Three.js r.66
		//by Felix Turner / www.airtight.cc / @felixturner

		var camera, scene, renderer;
		var video, videoTexture,videoMaterial;
		var composer;
		var shaderTime = 0;
		var badTVParams, badTVPass;		
		var staticParams, staticPass;		
		var rgbParams, rgbPass;	
		var filmParams, filmPass;	
		var renderPass, copyPass;
		var gui;
		var pnoise, globalParams;
		window.doanim = true;
		var ccc;
		function preinit(){
			videos = $('.pic img');
			currentVideo = 0;
		}
		var $bod = $('body');

		function init() {

			camera = new THREE.PerspectiveCamera(55, 1080/ 720, 20, 3000);
			camera.position.z = 1000;
			scene = new THREE.Scene();

			//Load Video
			// video = document.createElement( 'video' );
			// video.loop = true;
			// video.src = "vendor/fits.mp4";
			// video.play();
			
			//video = document.createElement( 'img' );

			video = videos[currentVideo];
			//video.src = "vendor/img.jpeg";


			videoTexture = new THREE.Texture( video );
			videoTexture.needsUpdate = true;
			videoTexture.minFilter = THREE.LinearFilter;
			videoTexture.magFilter = THREE.LinearFilter;

			videoMaterial = new THREE.MeshBasicMaterial( {
				map: videoTexture
			} );

			//Add video plane
			var planeGeometry = new THREE.PlaneGeometry( 1080, 720,1,1 );
			var plane = new THREE.Mesh( planeGeometry, videoMaterial );
			scene.add( plane );
			plane.z = 0;
			plane.scale.x = plane.scale.y = 1.45;

			//add stats
			// stats = new Stats();
			// stats.domElement.style.position = 'absolute';
			// stats.domElement.style.top = '0px';
			// container.appendChild( stats.domElement );

			//init renderer
			renderer = new THREE.WebGLRenderer();
			renderer.setSize( 800, 600 );
			video.parentNode.appendChild( renderer.domElement );
			videoWidth = video.parentNode.offsetWidth;
			videoHeight = video.parentNode.offsetHeight;
			//video.parentNode.removeChild(video);
			video.style.display="none";

			//POST PROCESSING
			//Create Shader Passes
			renderPass = new THREE.RenderPass( scene, camera );
			badTVPass = new THREE.ShaderPass( THREE.BadTVShader );
			rgbPass = new THREE.ShaderPass( THREE.RGBShiftShader );
			filmPass = new THREE.ShaderPass( THREE.FilmShader );
			staticPass = new THREE.ShaderPass( THREE.StaticShader );
			copyPass = new THREE.ShaderPass( THREE.CopyShader );

			//set shader uniforms
			filmPass.uniforms[ "grayscale" ].value = 0;

			//Init DAT GUI control panel
			badTVParams = {
				mute:false,
				show: false,
				distortion: 2.0,
				distortion2: 1.0,
				speed: 0.3,
				rollSpeed: 0.1
			}

			staticParams = {
				show: false,
				amount:0.5,
				size2:4.0
			}

			rgbParams = {
				show: false,
				amount: 0.7,
				angle: 0.4,
			}

			filmParams = {
				show: false,
				count: 800,
				sIntensity: 0.9,
				nIntensity: 0.4
			}

			onToggleShaders();
			onParamsChange();

			window.addEventListener('resize', onResize, false);
			onResize();

			function bbb(){
				badTVParams.show = true;
				rgbParams.show = true;
				onToggleShaders();
				$bod.addClass('scroll');
			}

			ccc = function(){
				badTVParams.show = false;
				rgbParams.show = false;
				onToggleShaders();
				$bod.removeClass('scroll');
			}

			$(window).scroll($.debounce( 50, true, bbb));
			
			$(window).scroll($.debounce( 50, ccc));
		}

		function onParamsChange() {
			//copy gui params into shader uniforms
			badTVPass.uniforms[ "distortion" ].value = badTVParams.distortion;
			badTVPass.uniforms[ "distortion2" ].value = badTVParams.distortion2;
			badTVPass.uniforms[ "speed" ].value = badTVParams.speed;
			badTVPass.uniforms[ "rollSpeed" ].value = badTVParams.rollSpeed;

			staticPass.uniforms[ "amount" ].value = staticParams.amount;
			staticPass.uniforms[ "size" ].value = staticParams.size2;

			rgbPass.uniforms[ "angle" ].value = rgbParams.angle*Math.PI;
			rgbPass.uniforms[ "amount" ].value = rgbParams.amount;

			filmPass.uniforms[ "sCount" ].value = filmParams.count;
			filmPass.uniforms[ "sIntensity" ].value = filmParams.sIntensity;
			filmPass.uniforms[ "nIntensity" ].value = filmParams.nIntensity;
		}

		function onToggleShaders(){

			//Add Shader Passes to Composer
			//order is important 
			composer = new THREE.EffectComposer( renderer);
			composer.addPass( renderPass );
			
			if (filmParams.show){
				composer.addPass( filmPass );
			}

			if (badTVParams.show){
				composer.addPass( badTVPass );
			}

			if (rgbParams.show){
				composer.addPass( rgbPass );
			}

			if (staticParams.show){
				composer.addPass( staticPass );
			}

			composer.addPass( copyPass );
			copyPass.renderToScreen = true;
		}

		function animate() {
			if(!window.doanim) { return }
			shaderTime += 0.1;
			badTVPass.uniforms[ 'time' ].value =  shaderTime;
			filmPass.uniforms[ 'time' ].value =  shaderTime;
			staticPass.uniforms[ 'time' ].value =  shaderTime;

			if ( video.readyState === video.HAVE_ENOUGH_DATA ) {
				if ( videoTexture ) videoTexture.needsUpdate = true;
			}

			requestAnimationFrame( animate );
			composer.render( 0.1);
			// stats.update();
		}

		function onResize() {
			renderer.setSize(videoWidth, (videoHeight*1.5));
			camera.aspect = videoWidth / (videoHeight*1.5);
			camera.updateProjectionMatrix();
		}