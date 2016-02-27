"use strict";

(function() {
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
})();
