// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

  $('.autofill-dots').change(function() {
    var dot_dropdown = $(this).parent().find('.dots');
    if ($(this).attr("value") === "") {
      dot_dropdown.attr("value", "");
    } else {
      dot_dropdown.attr("value", "1");
    }
  });

  if ($('#character_data').length > 0) {
    var f_text = $('#character_data').attr('innerHTML').replace(/\>\s+/g,"\>").replace(/\>\s+/g,"\>");
    $('#character_markup').attr('value', f_text );
  }

});
