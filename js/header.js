function get_user() {

  require(["dojo/request"], function(request){
    request.get("/header", {
      handleAs: "json"
    }).then(function(data){
      request.get("header.html", {
        handlesAs: "text"
      }).then(function(template){
        var contentNode = dojo.byId("header");
        var html = "";
        console.log("TEMPLATE:", template);
        console.log("JSON:", data);
        html = Mustache.to_html(template, data);
        console.log("HTML:", html);
        contentNode.innerHTML = html;


      });
    });
  });

  //  dojo.xhrGet({
  //    url: "/header",

  //  handleAs: "json",

  //load: function(data) {
  // console.info("JSON loaded from server:  ",data);
  //var contentNode = dojo.byId("header");
  //var html = "";


  // var template = '{{name}}, du bist Angemeldet <br><a href="/log_out">Abmelden</a>'; 

  // console.info("HTML:", template);
  // html = Mustache.to_html(template, data);  
  //  contentNode.innerHTML = html;

  //},
  // });
}
