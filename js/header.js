function get_user() {
	dojo.xhrGet({
		url: "/header",
		handleAs: "json",
		content: {
			user: "1" 
		},
		load: function(newContent) {
			console.info("JSON loaded from server:  ",newContent);
			var contentNode = dojo.byId("user");
			var buffer = "";

			buffer = newContent.name;
			
			contentNode.innerHTML = buffer;
			
			
		},
	});
}