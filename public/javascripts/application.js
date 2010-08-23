// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$('.gbook-listing').live('click', function(e){
  $('.booktitle h1').html($('#'+$(this).attr('ref')+' .crany_item_title').text());
	$('.bookcover img').attr('src',$('#'+$(this).attr('ref')+' .crany_item_cover img').attr('src'));
	$('.bookinfo_sectionwrap div:last').html($('#'+$(this).attr('ref')+' .crany_item_authors').html());
	$('.bookinfo_sectionwrap div:first').html($('#'+$(this).attr('ref')+' .crany_item_publisher').text()+', '+$('#'+$(this).attr('ref')+' .crany_item_date').text()+' - '+$('#'+$(this).attr('ref')+' .crany_item_format').text());
	$('#synopsistext').text($('#'+$(this).attr('ref')+' .crany_item_description').html());
	$('#book_data').val($('#'+$(this).attr('ref')+' .crany_item_raw').html())
  e.preventDefault();
  return false;
});

function loadDataForSlide(slideNum) {
// SS.move_to_slide(slideNum);
slideNumber = slideNum;
};