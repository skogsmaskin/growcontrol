$(document).ready(function() {
  function feed() {
    var r = confirm("Are you sure you want to feed it?");
    if (r==true) {
      if(!!EventSource) {
        var source = new EventSource('/feed');
        source.addEventListener('message', function(e) {
          console.log(e.data);
          var data = JSON.parse(e.data);
          var seconds = null;
          switch(data.action) {
            case "start":
              $(".feed-status").html("Feeding in progress!");
              seconds = data.seconds-1;
              function progress(){
                $(".feed-status").html("<span class='feed-progress'>"+(seconds--).toString()+"</span>");
                if(seconds <= 0) {
                  clearInterval(interval_id);
                }
              }
              var interval_id=setInterval(function(){progress()},1000);
              break;
            case "stop":
              $(".feed-status").html("Feeding is done!");
              source.close();
              setTimeout(function() { $(".feed-status").html(""); }, 3000);
              break;
          }
        }, false);
      }
    } else {
      return false;
    }
  }    
  $("#feed-button").click(feed);
});
