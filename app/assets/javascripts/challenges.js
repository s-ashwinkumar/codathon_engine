function convertUserToAdmin(userId){
  $.ajax({
    type: "POST",
    url: "/convert_user",
    data: { user_id: userId },
    success: function(data){
      Alert(data,"Operation Status")
    }
  });
}
