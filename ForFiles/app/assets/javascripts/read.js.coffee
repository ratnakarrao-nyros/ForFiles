$(document).ready ->
 $('.delete').click ->	
  me=$(this)	
  $.get '/upload/delete_file',{id:$(this).attr("file_id")},(data) ->
   if data 
    me.parent().parent().hide("slow")
