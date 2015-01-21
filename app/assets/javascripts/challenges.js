jQuery(document).ready(function () {
    $('[id^=submission_form_id_]').bind("ajax:success", function(data){
        $(this).remove();
    });
    $('[id^=submission_form_id_]').bind("ajax:error", function(data){
        Alert("Let me see !!! Oops !!! Something went wrong !!!");
    });
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
    $('.schedule-button').qtip({
        show: {
            solo: true,
            event: 'click',
            effect: function(offset) {
                        $(this).slideToggle(100); // "this" refers to the tooltip
                    }
        },
        hide: {
            event: 'unfocus'
        },
        content: {
            text: 'My tooltip content',
            title: "qwe"
        },
        style: {
            classes: 'qtip-bootstrap'
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
    scheduleChallenge(jQuery(this).attr("challengeID"));
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
            Alert("Challenge closed successfully", "Success !!");
        },
        error: function(error){
            Alert("Something went wrong, please try again later.","Alert!!");
        }
    });
}

jQuery(document).on("click","#addNewChallenge",function(){

    var title= jQuery("#title").val();
    if(title === ""){
        Alert("Enter title", "Validation Failure !!");
        return false;
    }
    jQuery.ajax({
        type : 'POST',
        data:{
            title: title,
            start_date: moment(jQuery("#datetimepicker1").val()).valueOf(),
            end_date: moment(jQuery("#datetimepicker2").val()).valueOf(),
        },
        url: "/challenge/create",
        success: function(data) {
            Alert("Created new challenge successfully", "Success !!");
            window.location.reload();
        },
        error: function(error){
            Alert("Something went wrong, please try again later.","Alert!!");
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
     if(!(titles[i]=="" && descriptions[i]=="")) {
      if(titles[i]=="" || descriptions[i]=="") {
        Alert("Incomplete data for the question", "Validation Failure !!");
        return false;
    }
}
}
jQuery('[id^=edit_challenge_]')[0].submit();    
}
function scheduleChallenge(id) {
    var start_time = jQuery('#start_time'+id).val();
    var end_time = jQuery('#end_time'+id).val();
    jQuery.ajax({
        type : 'POST',
        data:{
            challenge_id: id,
            start_time: start_time,
            end_time: end_time,
        },
        url: "/challenge/schedule",
        success: function(data) {
            Alert("Scheduled challenge successfully", "Success !!");
        },
        error: function(error){
            Alert("Something went wrong, please try again later.","Alert!!");
        }
    });
}
jQuery(document).ready(function () {
    $('.schedule-button').qtip({
        show: {
            solo: true,
            event: 'click'
        },
        hide: {
            event: 'unfocus'
        },
        content: {
            text: 'Loading...', // The text to use whilst the AJAX request is loading
            title: "Schedule Challenge",
            button: 'close'
        },
        style: {
            classes: 'qtip-bootstrap qtip-custom',
        },
        position: {
            my: 'right center',  // Position my top left...
            at: 'left center', // at the bottom right of...
        },
        events: {
                    show:function(event, api) {
                                var id = api.target.attr("id");
                               jQuery.ajax({
                                type : 'POST',
                                data:{
                                    challenge_id: id
                                },
                                url: "/load_datepicker",
                                success: function(data) {
                                    api.set('content.text', data);
                                    setCalender(id);
                                },
                                error: function(error){
                                    Alert("Something went wrong, please try again later.","Alert!!");
                                }
                            });
                    }
        }
    });
});
function setCalender(id){
    $('#start_time'+id).datetimepicker();
    $('#end_time'+id).datetimepicker();
    $('#start_time'+id).on("dp.change",function (e) {
        $('#end_time'+id).data("DateTimePicker").setMinDate(e.date);
    });
    $('#end_time'+id).on("dp.change",function (e) {
        $('#start_time'+id).data("DateTimePicker").setMaxDate(e.date);
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

function submitResponse(question_id) {
    var solution=jQuery("#solution_"+question_id).val();
    jQuery.ajax({
        type : 'POST',
        data:{
            question_id: question_id,
            solution: solution,
        },
        url: "/validate_submission",
        success: function(data) {
            Alert(data.text, "Solution submitted successfully !!"); 
            jQuery("#solution_space_"+data.question_id).html("<h4><b>Opprtunity knocks your door only once !!!<br><small>You have submitted your solution for this question</h4>");
        },
        error: function(error){
            Alert("Something went wrong!!!");
        }
    });
}

function addTestCase(question_id, index) {
    var count=jQuery('[id^="test_case_'+question_id+'_row_"]').size();
    var row_content="<div class='col-sm-2'><input class='form-control' name='challenge[questions_attributes]["+index+"][test_cases]["+count+"][points]' size='2' maxWidth='2' placeholder='Points'></div>";
    var input_content="<div class='col-sm-5'><input class='form-control' name='challenge[questions_attributes]["+index+"][test_cases]["+count+"][input_file]' type='file' title='Input Test Case'></div>";
    var output_content="<div class='col-sm-5'><input class='form-control' name='challenge[questions_attributes]["+index+"][test_cases]["+count+"][output_file]' type='file' title='Output Test Case'></div>";

    var content="<div class='form_group' id = test_case_"+question_id+"_row_"+count+">"+row_content+input_content+output_content+"</div></br>"
    jQuery("#test_cases_"+question_id).append(content);
}

function deleteTestCase(question_test_case_id)
{
    jQuery.ajax({
        type : 'POST',
        data:{
            question_test_case_id: question_test_case_id,
        },
        url: "/delete_test_case",
        success: function(data) {
            jQuery("#test_case_"+data.question_id+"_row_"+data.test_case_id).remove();
        },
        error: function(error){
            Alert("Something went wrong!!!");
        }
    });
}