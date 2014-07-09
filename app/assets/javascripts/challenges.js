jQuery(document).ready(function () {
	jQuery('[id^=finish_]').each(function(index,element) {
		element.onclick = function() {
			finish_challenge(/(\d+)$/.exec(element.id)[0]);
		}
	});	
});

function finish_challenge(challenge_id) {
	jQuery.ajax({
        type : 'POST',
        data:{
        	challenge_id: challenge_id,
            },
        url: "/challenge/finish",
        success: function(data) {
        	jQuery("#finish_"+challenge_id).attr("disabled","disabled");
        	jQuery("#schedule_"+challenge_id).attr("disabled","disabled");
        	alert("Challenge closed successfully");
            },
        error: function(error){
            alert("Something went wrong, please try again later.");
            }
        });
}

function finish_challenge(challenge_id) {
	jQuery.ajax({
        type : 'POST',
        data:{
        	challenge_id: challenge_id,
            },
        url: "/challenge/finish",
        success: function(data) {
        	jQuery("#finish_"+challenge_id).attr("disabled","disabled");
        	jQuery("#schedule_"+challenge_id).attr("disabled","disabled");
        	alert("Challenge closed successfully");
            },
        error: function(error){
            alert("Something went wrong, please try again later.");
            }
        });
}

function validateAndSaveChallenge() {
	var titles = [];
	var descriptions = [];
	var points = [];

	for (var i = 0; i < 3; i++) {
    	titles[i] = jQuery("#challenge_questions_attributes_"+ i +"_title").val();
    	descriptions[i] = jQuery("#challenge_questions_attributes_"+ i +"_description").val();
    	points[i] = jQuery("#challenge_questions_attributes_"+ i +"_points").val();
    	if(!(titles[i]=="" && descriptions[i]=="" && points[i]=="")) {
    		if(titles[i]=="" || descriptions[i]=="" || points[i]=="") {
				alert("Incomplete data for the question");
				return false;
			}
    	}
	}
	jQuery('[id^=edit_challenge_]')[0].submit();
}



