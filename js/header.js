function get_user() {
	dojo.xhrGet({
		url: "/header",
		handleAs: "json",
	     
		load: function(newContent) {
			console.info("JSON loaded from server:  ",newContent);
			var contentNode = dojo.byId("user");
			var buffer = "";

			user = newContent.id;
			//alert ("getuser: " + user);
			buffer = newContent.name;
			
			contentNode.innerHTML = buffer;
			
		},
	});
}