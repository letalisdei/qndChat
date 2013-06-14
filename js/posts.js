function get_posts(room_nr) {
	if (room_nr == undefined) {
	  room_nr = 1; //TODO: public room ermitteln
	}
	dojo.xhrGet({
		url: "/post",
		handleAs: "json",
		content: {
			room: room_nr
		},
		load: function(newContent) {
			
			console.info("JSON loaded from server:  ",newContent);
			var contentNode = dojo.byId("posts");
			var buffer = "";
			
			dojo.forEach(newContent, function(post){
			
			buffer +=  post.content +"<br>";
			
			});
			
			contentNode.innerHTML = buffer;
			
			
		},
	});
}