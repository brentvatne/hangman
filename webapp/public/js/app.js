$(function(){
  $("#guess").select();

  var make_guess = function() {
      var guess = $("#guess").attr("value"),
          current_url = window.location.href,
          split_url,
          separator = "",
          new_url;

      split_url = current_url.split("/");
      if (split_url[split_url.length - 2] == "puzzles") {
        separator = "/";
      }
      
      new_url = current_url + separator + guess;
      window.location.href = new_url;
  };

  $("#submit").click(function() {
    make_guess();
  });

  $("#guess").keypress(function(event) {
    if (event.which == 13) {
      make_guess();
    } 
  });

});
