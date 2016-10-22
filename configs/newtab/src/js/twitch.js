var links=["ethotv","nebris","zisteau","coestar","mindcrack"];
var names=["Etho",  "Nebris","Zisteau","Coestar","Mindcrack"];

var focus= $("<div />")
for (var i=0;i<links.length;i++) {
  (function(i) {
    focus.queue("apicalls",function(next){
      link=links[i];
      name=names[i];
      url="https://api.twitch.tv/kraken/streams/"+links[i]
      $.getJSON(url).then(function(channel) {
        if (channel["stream"] == null) {
         document.getElementById("twitch").innerHTML += "";
        } else {
         document.getElementById("twitch").innerHTML += "<li><a href='https://www.twitch.tv/"+link+"'>"+name+"</a></li>";
        }
        next();
      });
    });
  })(i);
}
focus.dequeue('apicalls');
