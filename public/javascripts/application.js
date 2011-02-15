// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

  if ($('#character_data').length > 0) {
    var f_text = $('#character_data').attr('innerHTML').replace(/\>\s+/g,"\>").replace(/\>\s+/g,"\>");
    $('#character_markup').attr('value', f_text );
  }

  load_dots_dropdown = function(context, controller){
        var id_value_string = context.val();
        var dots_dropdown = context.parent().find('.dots');
        if (id_value_string == "") {
            // if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
            dots_dropdown.find('option').remove();
            var row = "<option value=\"" + "" + "\">" + "" + "</option>";
            $(row).appendTo(dots_dropdown);
        }
        else {
            // Send the request and update sub category dropdown
            $.ajax({
                dataType: "json",
                cache: false,
                url: '/' + controller + '/' + id_value_string + '/dot_range.json',
                timeout: 2000,
                error: function(XMLHttpRequest, errorTextStatus, error){
                    alert("Failed to submit : " + errorTextStatus + " ;" + error);
                },
                success: function(data){                    
                    // Clear all options from sub category select
                    dots_dropdown.find('option').remove();
                    //put in a empty default line
                    var row = "<option value=\"" + "" + "\">" + "" + "</option>";
                    $(row).appendTo(dots_dropdown);                        
                    // Fill sub category select
                    $.each(data, function(i, j){
                        row = "<option value=\"" + j[0] + "\">" + j[1] + "</option>";  
                        $(row).appendTo(dots_dropdown);                    
                    });            
                 }
            });
        };
    };

    $(".autofill-merit-dots").change(function() { load_dots_dropdown($(this), 'merits') });
    $(".autofill-skill-dots").change(function() { load_dots_dropdown($(this), 'skills') });
    $(".autofill-contract-dots").change(function() { load_dots_dropdown($(this), 'contracts') });	
    
});
