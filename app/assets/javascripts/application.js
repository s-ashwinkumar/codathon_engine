// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
jQuery(document).ready(function () {
 	$('#myModal').on('hidden.bs.modal', function() {
    	$(this).removeData('bs.modal');
	});
	
});
$(document).on("change",".customSelect",function() {
    $.ajax({
		type: "POST",
		url: "/dashboards",
		data: { month: jQuery("#date_month").val(),
				year: jQuery("#date_year").val()
			  },
		success: function(data){
                    if (data.length > 1){
                    	jQuery("#empty_data").hide();
                    	jQuery(".table").fadeIn();
                    	jQuery("#table_data").html(data);
                    }else{
                    	jQuery(".table").hide();
                    	jQuery("#empty_data").fadeIn();
                    }
		}
	});
});