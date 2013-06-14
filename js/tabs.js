function get_tabs() {
	// Using dojo.xhrGet, as no information is being sent -- only requesting
	dojo.xhrGet({
		url: "/tabs",
		handleAs: "json",
		content: {
			user: "1" 
		},
		load: function(newContent) {
			
			console.info("JSON loaded from server:  ",newContent);
			var contentNode = dojo.byId("tabs");
			var buffer = "";
			
			dojo.forEach(newContent, function(tabs){
			
			buffer += '<div id="tab" onclick="get_posts(' + tabs.id + ')">' + tabs.name + '</div>';
			
			});
			
			contentNode.innerHTML = buffer;
			
		},
	});
}