// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

  if ($('#character_data').length > 0) {
    var f_text = $('#character_data').attr('innerHTML').replace(/\>\s+/g,"\>").replace(/\>\s+/g,"\>");
    $('#character_markup').attr('value', f_text );
  }

  // methods for adding new skill/merit/contract rows
  $('#new_skill').click(function() {
	new_row = $('#skills_cell p.item:last').clone(true);
	$(new_row).children().each(function() { $(this).val(''); });
	$(this).before(new_row);
    return false;
  });
  $('#new_merit').click(function() {
	new_row = $('#merits_cell p.item:last').clone(true);
	$(new_row).children().each(function() { $(this).val(''); });
	$(this).before(new_row);
    return false;
  });
  $('#new_contract').click(function() {
	new_row = $('#contracts_cell p.item:last').clone(true);
	$(new_row).children().each(function() { $(this).val(''); });
	$(this).before(new_row);
    return false;
  });

  // loads the dot dropdown via JSON, if a skill/merit/contract type is selected
  load_dots_dropdown = function(context, controller, dot_dropdown_class){
        var id_value_string = context.val();
        var dots_dropdown = context.parent().find('.' + dot_dropdown_class);
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

    $(".merit-type").change(function() { load_dots_dropdown($(this), 'merits', 'merit-dots') });
    $(".skill-type").change(function() { load_dots_dropdown($(this), 'skills', 'skill-dots') });
    $(".contract-type").change(function() { load_dots_dropdown($(this), 'contracts', 'contract-dots') });	
    

});
