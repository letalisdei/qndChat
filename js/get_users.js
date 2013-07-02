
function get_users() {
	// Using dojo.xhrGet, as no information is being sent -- only requesting
	//alert("tabs" + user);
	dojo.xhrGet({
		url: "/get_users",
		handleAs: "json",

		load: function(newContent) {
			
			console.info("JSON loaded from server:  ",newContent);
			var contentNode = dojo.byId("user_select");
			var buffer = "";
			
			dojo.forEach(newContent, function(user){
			
			
			buffer += '<input type="checkbox" name="users[]" value="' + user.id + '">' + user.name + '<br>';
			});
			contentNode.innerHTML = buffer;
			
		},
	});
}
