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
  $(document).on("click",".d a",function(){
    var w_id = $(this).closest('.well').attr('id')
    var origin = $(".well[id="+w_id+"]")
    var clone = $(".well[id="+w_id+"]").clone()

    $.ajax({
      type: "POST",
      url: "tasks/"+w_id+"/resolve",
      beforeSend: function(){
        origin.css("background-color","#BDB4F9")
      },
      success: function(){
        setTimeout(function(){
          origin.css("background-color","#BDB4F9")

        },100)
        setTimeout(function(){
          origin.text("Done!")
          clone.fadeIn("slow").prependTo('.done')

        },700)
        setTimeout(function(){
          origin.slideUp(function(){this.remove})
          clone.find(":checkbox").prop("checked", true)
        },1000)

      }
    })
  })  
})












