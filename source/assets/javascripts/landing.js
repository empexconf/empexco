(function() {
  function navigateToPage(page) {
    return function() {
      window.location.href = "/" + page + ".html";
    };
  }

  function allowClick(event) {
    console.log("allow", event);
    event.stopPropagation();
  }

  $(".hero-card--nyc").click(navigateToPage("nyc"));
  $(".hero-card--la").click(navigateToPage("la"));

  $(".hero-card--nyc a").click(allowClick);
  $(".hero-card--la a").click(allowClick);
})();
