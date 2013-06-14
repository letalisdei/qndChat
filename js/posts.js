function get_posts(room_nr_) {
	if (room_nr_ == undefined) {
	  room_nr_ = room_nr; 
	}
	else{
	  room_nr = room_nr_;	//update global room_nr with tab value
	}
	dojo.byId("room").value = room_nr;
	dojo.xhrGet({
		url: "/post",
		handleAs: "json",
		content: {
			room: room_nr_
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