function showChallenge(chId){
  var title = jQuery("#title"+chId+" a")[0].text;
  var desc = jQuery("#desc"+chId)[0].value;
  jQuery("#chtitle").val(title);
  jQuery("#chdescription").text(desc);
  jQuery("#challenge_id").val(chId);
  if (jQuery("#subscription"+chId).val() == "true"){
    jQuery("#subscribe").val("Unsubscribe !!")
  }else{
    jQuery("#subscribe").val("Subscribe !!")
  }
  $('#detailsModal').modal('show')
}
