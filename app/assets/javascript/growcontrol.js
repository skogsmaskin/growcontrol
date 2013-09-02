$(document).ready(function() {
  $("#feed-button").click(function() {
      if(!!EventSource) {
        var source = new EventSource('/feed');
        source.addEventListener('message', function(e) {
          console.log(e.data);
          var data = JSON.parse(e.data);
          switch(data.action) {
            case "start":
              $(".feed-status").html("Feeding in progress!");
              break;
            case "stop":
              $(".feed-status").html("Feeding is done!");
              source.close();
              break;
          }
        }, false);
      }
    }
  );
});
