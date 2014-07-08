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




