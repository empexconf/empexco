(function() {
  function navigateToPage(page) {
    return function() {
      window.location.href = '/' + page + '.html';
    }
  }

  $('.hero-card--nyc').click(navigateToPage('nyc'));
  $('.hero-card--la').click(navigateToPage('la'));
})();
