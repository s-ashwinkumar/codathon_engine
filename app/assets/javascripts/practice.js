jQuery(document).ready(function () {
    jQuery('[id^=practice_question_tab_]').each(function(index,element) {
        element.onclick = function() {
            load_practice_question_with_index(/(\d+)$/.exec(element.id)[0]);
        }
    }); 
});
function load_practice_question_with_index(question_id) {
    jQuery(".on_display").fadeOut("slow", function() {
            jQuery(".on_display").removeClass().addClass("hide");
    });
    jQuery(".active").removeClass();
    jQuery("#practice_questions_content").slideUp("slow", function() {
        jQuery("#practice_question_tab_"+question_id).addClass("active");
        jQuery("#practice_question_data_"+question_id).removeClass().css("display","none");
        jQuery("#practice_question_tab_"+question_id).removeClass().addClass("active");
        jQuery("#practice_questions_content").slideDown();
        jQuery("#practice_question_data_"+question_id).fadeIn("slow", function() {}).addClass("show on_display");
    });
}

function practice_submitResponse(question_id) {
    if(jQuery("#practice_output_file_" + question_id).val().trim().length == 0){
        Alert("Please select a file!");
    }else{
        jQuery("#practice_submit_area_"+question_id).html("");
    }
}