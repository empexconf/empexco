/*
   Eventually by HTML5 UP
   html5up.net | @n33co
   Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
   */

(function() {

  "use strict";

  // window.addEventListener
  (function() {
    if (!("addEventListener" in window)) {
      window.addEventListener = function(type,f) { window.attachEvent("on"+type,f); }
    }
  })();

  var	$body = document.querySelector('body');

  // Disable animations/transitions until everything's loaded.
  $body.classList.add('is-loading');

  window.addEventListener('load', function() {
    window.setTimeout(function() {
      $body.classList.remove('is-loading');
      var $moon = document.querySelector('#moon div');
      $moon.classList.add('visible');
    }, 100);
  });

  // Slideshow Background.
  // (function() {
  //
  //   // Settings.
  //   var settings = {
  //
  //     // Images (in the format of 'url': 'alignment').
  //     images: {
  //       '/assets/images/empex-moon.jpg': 'center'
  //     },
  //
  //     // Delay.
  //     delay: 6000
  //
  //   };
  //
  //   var	pos = 0, lastPos = 0,
  //     $wrapper, $bgs = [], $bg,
  //       k, v;
  //
  //       // Create BG wrapper, BGs.
  //       $wrapper = document.createElement('div');
  //       $wrapper.id = 'bg';
  //       $body.appendChild($wrapper);
  //
  //       for (k in settings.images) {
  //
  //         // Create BG.
  //         $bg = document.createElement('div');
  //         $bg.style.backgroundImage = 'url("' + k + '")';
  //         $bg.style.backgroundPosition = settings.images[k];
  //         $wrapper.appendChild($bg);
  //
  //         // Add it to array.
  //         $bgs.push($bg);
  //
  //       }
  //
  //       // Main loop.
  //       $bgs[pos].classList.add('visible');
  //       $bgs[pos].classList.add('top');
  //
  //       // Bail if we only have a single BG or the client doesn't support transitions.
  //       if ($bgs.length == 1
  //         ||	!canUse('transition'))
  //       return;
  //
  //       window.setInterval(function() {
  //
  //         lastPos = pos;
  //         pos++;
  //
  //         // Wrap to beginning if necessary.
  //         if (pos >= $bgs.length)
  //           pos = 0;
  //
  //         // Swap top images.
  //         $bgs[lastPos].classList.remove('top');
  //         $bgs[pos].classList.add('visible');
  //         $bgs[pos].classList.add('top');
  //
  //         // Hide last image after a short delay.
  //         window.setTimeout(function() {
  //           $bgs[lastPos].classList.remove('visible');
  //         }, settings.delay / 2);
  //
  //       }, settings.delay);
  //
  // })();
  //
})();
