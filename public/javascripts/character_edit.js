$(document).ready(function() {

	$('#character_submit').hide();
	var auth_tok = "vwZfILJx1QYJ5Y4AuV1LahBwiKYkzqpPcDZHoInxMg8=";

	// submit data with dot field
    submit_character_smc_data = function(context, controller, smc_dropdown_class) {
		var dots_val = context.val();
        if (dots_val === "") {
			return false;
		}
		var controller_singular = controller.substring(0, controller.length - 1);
        var smc_type_dropdown = context.parent().find('.' + smc_dropdown_class);
        var specialty_type = context.parent().find('.specialty-type').val();
        var smc_data_row_id_node = context.parent().find('.' + controller_singular + '-id')
        var smc_data_row_id = smc_data_row_id_node.text();
		var smc_type_val = smc_type_dropdown.val();
		var char_id = $('#character-id').text();
		
		var smc_data = get_smc_json_data( smc_data_row_id, smc_type_val, char_id, controller, specialty_type, dots_val );
		var url = '/characters/' + char_id + '/' + controller + ((smc_data_row_id === '') ? '' : '/') + smc_data_row_id + '.json';
		
        // Send the POST request as create() or update(), depending on whether id exists
        $.post( url, smc_data, function(data, textStatus) {
			if (textStatus === 'error') {
            	$('#notice').text("Error saving merit type: " + errorTextStatus + ".");
            };
            if (textStatus === 'success') {    
               $('#notice').text("Successfully saved " + smc_type_val + ", " + dots_val + " dots.");
                // Clear all options from sub category select
               smc_data_row_id_node.text(data["character_" + controller_singular]["id"]);
            };
        }, 'json');
    };

	// creates data to be sent in Ajax request, stringified
	get_smc_json_data = function(character_smc_id, smc_id, char_id, smc_type, selected_specialty, selected_dots) {
		
		var method = (character_smc_id ? "PUT" : "POST");
		
		if (smc_type == 'merits') {
			return { _method: method, authenticity_token: auth_tok, character_id: char_id, character_merit: { merit_id: smc_id, specialty: selected_specialty, dots: selected_dots } };
		} else if (smc_type == 'skills') {
			return { _method: method, authenticity_token: auth_tok, character_id: char_id, character_skill: { skill_id: smc_id, specialty: selected_specialty, dots: selected_dots } };
		} else if (smc_type == 'contracts') {
			return { _method: method, authenticity_token: auth_tok, character_id: char_id, character_contract: { contract_id: smc_id, specialty: selected_specialty, dots: selected_dots } };
		} 
		return false;
	}

    $(".merit-dots").change(function() { submit_character_smc_data($(this), 'merits', 'merit-type') });
    $(".skill-dots").change(function() { submit_character_smc_data($(this), 'skills', 'skill-type') });
    $(".contract-dots").change(function() { submit_character_smc_data($(this), 'contracts', 'contract-type') });	

	var changed = false;
	$(".specialty-type").focus(function() { changed = false; });
	$(".specialty-type").change(function() { changed = true; });
    $(".specialty-type").blur(function() { if(changed) { $(this).parent().find('.merit-dots, .skill-dots, .contract-dots').triggerHandler('change') } });

	// submit character data update for only the control passed in
    submit_character_data = function(control) {
	  re_test = /^character\[([A-Za-z_]+)\]$/.exec(control.name);
	  if (re_test.length > 1) {
		var field_name = re_test[1];
		var char_id = $('#character-id').text();
		var url = '/characters/' + char_id + '.json';
		// creating JSON for selected field (field_name), then executing command after JSON for field name is filled in
		eval("var json_data = { _method: \"PUT\", authenticity_token: auth_tok, character: { " + field_name + ": \"" + $(control).val() + "\" } };");


	    // Send the POST request as create() or update(), depending on whether id exists
	    $.post( url, json_data, function(data, textStatus) {
				if (textStatus === 'error') {
	            	$('#notice').text("Error saving merit type: " + errorTextStatus + ".");
	            };
	            if (textStatus === 'success') {    
	               $('#notice').text("Successfully saved " + smc_type_val + ", " + dots_val + " dots.");
	                // Clear all options from sub category select
	               smc_data_row_id_node.text(data["character_" + controller_singular]["id"]);
	            };
	    }, 'json');
	  }
	}
	
	$(".core-stat").change(function() { submit_character_data(this) });

});