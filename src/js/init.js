/*global $ document window*/
//DOCUMENT READY
		$(document).ready(function () {
			//SIDE NAV
			$(".button-collapse").sideNav();
			verMasBtn();
			verOpcionalesBtn();
			$('.modal').modal();
			//SLIDER CREATION
			$('.slider').slider({
				full_width: true,
				indicators: false,
				height: 600,
				interval: 6000
			});
			//NAVBAR STYLE
			if ($(window).width()>600){
				$('nav.fix').pushpin({
					top: 20,
					offset: 0,
				});
			}else{
				$('nav.fix').pushpin({
					top: 0,
					offset: 0,
				});
			}
			$('#mobile-ad img').removeClass("responsive-img");
			resizing();
		});
		//jQUERY WINDOW RESIZE
		$( window ).resize(resizing);
		//RESIZE FUNCTION
		function resizing(){
			var w=$( window ).width();
			var h=$( window ).height();
			if (w>h){
				$('#mobile-ad').width(w);
				$('#mobile-ad').height(h);
				$('#mobile-ad img').width(w);
				$('#mobile-ad img').height('auto');
				$('#cap4').css('margin-top', '0px');
				$('#cap4').css('margin-bottom', '0px');
				$('#cap4').css('position', 'absolute');
				$('#cap4').css('top', (	1)*h/4+'px');
				$('#cap4').css('width', '100%');
			}else{
				$('#mobile-ad').height(h);
				$('#mobile-ad').width('auto');
				$('#mobile-ad img').height(h);
				$('#mobile-ad img').width('auto');
				$('#cap4').css('margin-top', '0px');
				$('#cap4').css('margin-bottom', '0px');
				$('#cap4').css('position', 'absolute');
				$('#cap4').css('top', (1)*h*(1/10)+'px');
				$('#cap4').css('width', '100%');
			}
		}
		function verMasBtn(){
			$("#mas-planes-btn").click(function(){
				$(this).slideUp();
				$("#ver-mas-row").slideDown();
			})
		}
		function verOpcionalesBtn(){
			$("#mas-servicios-btn").click(function(){
				$(this).slideUp();
				$("#mas-servicios").slideDown();
			})
		}
