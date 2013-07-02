  function get_user() {



  dojo.xhrGet({
    url: "/header",
    handleAs: "json",

    load: function(data) {
      console.info("JSON loaded from server:  ",data);
      var contentNode = dojo.byId("header");
      var html = "";


      var template = '{{name}}, du bist Angemeldet <br><a href="/log_out">Abmelden</a>'; 
alert('Mustache sollte jetzt ausgeführt werden');
      html = Mustache.to_html(template, data);  

      contentNode.innerHTML = html;

    },
  });
}
