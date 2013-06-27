function main() {
  room_nr = 1;
  dojo.byId("room").value = room_nr;
  user = 1;
  //alert("rufe get_user auf");
  get_user();
  //alert("rufe get_tabs auf");
  get_tabs();
  get_posts();
  get_users();

}
