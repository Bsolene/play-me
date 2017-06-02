//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require_tree .


$('#myModal').on('shown.bs.modal', function () {
  $('#myInput').focus()
})

$(document).ready(function(){
  $(".list-delete").on("click", function(e){
    $(this).parent().addClass("hidden");
  });
});
