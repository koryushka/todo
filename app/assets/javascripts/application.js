// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .




$(function(){
  $(document).on("change", ".update :checkbox", function(){
    $("#edit_task_"+ $(this).closest('.well').attr("id")).submit()
  })
})  


$(function(){
  $(document).on("change",".update :checkbox",function(){
    var w_id = $(this).closest('.well').attr('id')
    var origin = $(".well[id="+w_id+"]")
    var clone = $(".well[id="+w_id+"]").clone()



    if($(this).is(":checked")){
      if($(".todo :checkbox").length==1){
        setTimeout(function(){
          $(".todo").html("<h3>Congratulations! Your todo list is empty.<h3>")
        },1700)
        
      }
      $.ajax({
        type: "POST",
        url: "tasks/"+w_id+"/resolve",
        beforeSend: function(){
          origin.css("background-color","#BDB4F9")
        },
        success: function(){
          origin.text("Done!").addClass('justDone')
          setTimeout(function(){
            clone.slideDown(700).prependTo('.done').css("background-color","#E8E4FF")
          },1000)
          setTimeout(function(){origin.slideUp(700)},1000)
          setTimeout(function(){origin.remove()},1700)
          setTimeout(function(){clone.css("background-color","#6EE893")}, 3000)
        } 
      })
    } else {
      $("#congratulations").hide()
      if($(".todo:contains('list')")){
        $('.todo h3').remove()
      }
      $.ajax({
        type: "POST",
        url: "tasks/"+w_id+"/unresolve",
        success: function(){
            clone.slideDown(700).prependTo('.todo').css("background-color","#E8E4FF")
            origin.slideUp(700)  
          setTimeout(function(){origin.remove()},1700)
          setTimeout(function(){clone.css("background-color","#F8EE89")}, 3000)
        } 
      })

    }
  })  
}) 












