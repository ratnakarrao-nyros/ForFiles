# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->
 
 validRegEx=new RegExp("^[-;:_.a-zA-Z0-9 ]+\.[a-z]{3,4}$")
 emptyRegEx=new RegExp("[_a-zA-z0-9]")
 emailRegEx = new RegExp("^[-_.a-z0-9]+@[-_a-z0-9]+\.[a-z]{2,4}$")


 
 validateInputs = (input,regex,style) ->
  error=[]  
  if regex.test($(input).val())
    $('.'+style).css("display","none") 
  else
    error.push($(input).attr('class'))
    $('.'+style).addClass("error") 
    $('.'+style).css("display","block")
  return error
   

 validateForm = () ->
    $.extend(badFields = [], validateInputs('.file_field', emptyRegEx,'empty'), validateInputs('.file_field', validRegEx,'valid'))
    if badFields.length is 0
      valid = true
    else
      valid = false
    return valid




  $('.validate-form').submit ->
    return validateForm()


  err=[]
  validateReadInputs = (input,regEx,style) ->
   if regEx.test($(input).val()) 
    $('.'+style).css("display","none")
    err=[]
   else
    err.push($(input).attr('class'))
    $('.'+style).addClass("error") 
    $('.'+style).css("display","block")
   return err 
 
  
  $('.read-form .mail_fields .mail_id').blur () ->
   validateReadInputs('.read-form .mail_fields .mail_id',emptyRegEx,'empty')
   validateReadInputs('.read-form .mail_fields .mail_id',emailRegEx,'email')
 
 
   
  
  validateRead = () ->
   $.extend(badFields = [], validateReadInputs('.read-form .mail_fields .mail_id',emptyRegEx,'empty'),
   validateReadInputs('.read-form .mail_fields .mail_id',emailRegEx,'email')) 
   if badFields.length is 0
     valid = true
   else
     valid = false
   return valid
   
   
  $('.read-form').submit ->
   return validateRead()

  $('.file_field').click ->
    $('.success_msg,.valid,.empty').css("display","none");		
		


 

