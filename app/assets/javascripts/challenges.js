jQuery(document).ready(function () {
	jQuery('[id^=finish_]').each(function(index,element) {
		element.onclick = function() {
			finish_challenge(/(\d+)$/.exec(element.id)[0]);
		}
	});	
    jQuery('[id^=question_tab_]').each(function(index,element) {
        element.onclick = function() {
            load_question_with_index(/(\d+)$/.exec(element.id)[0]);
        }
    }); 
    $(".popover-trigger").click(function() {
        el = $(this);
        $.get(el.data('ajaxload'), function(response) {
          el.unbind('click').popover({
            content: response,
            title: 'Schedule Challenge',
            html: true,
            delay: {show: 100, hide: 100}
        }).popover('show');
      });
    });
});
jQuery(document).on("click","#schedule_challenge_button",function(){
    scheduleChallenge();
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

jQuery(document).on("click","#addNewChallenge",function(){

    var title= jQuery("#title").val();
    if(title === ""){
        alert("Enter title");
        return false;
    }
    jQuery.ajax({
        type : 'POST',
        data:{
            title: title,
            start_time: jQuery("#start_time").val(),
            end_time: jQuery("#end_time").val(),
        },
        url: "/challenge/create",
        success: function(data) {
            alert("done deal");
            window.location.reload();
        },
        error: function(error){
            alert("Something went wrong, please try again later.");
        }
    });
});
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
function scheduleChallenge() {
    var challenge_id=jQuery("#challenge_id").val();
    var start_time = jQuery("#start_time").val();
    var end_time = jQuery("#end_time").val();
    jQuery.ajax({
        type : 'POST',
        data:{
            challenge_id: challenge_id,
            start_time: start_time,
            end_time: end_time,
        },
        url: "/challenge/schedule",
        success: function(data) {
            alert("done deal");
            window.location.reload();
        },
        error: function(error){
            alert("Something went wrong, please try again later.");
        }
    });
}

function load_question_with_index(question_id) {
    jQuery(".on_display").fadeOut("slow", function() {
            jQuery(".on_display").removeClass().addClass("hide");
    })
    jQuery(".active").removeClass();
    jQuery("#questions_content").slideUp("slow", function() {
        jQuery("#question_tab_"+question_id).addClass("active");
        jQuery("#question_data_"+question_id).removeClass().css("display","none");
        jQuery("#question_tab_"+question_id).removeClass().addClass("active");
        jQuery("#questions_content").slideDown();
        jQuery("#question_data_"+question_id).fadeIn("slow", function() {}).addClass("show on_display");
    });
}