<script>
$(function() {
       $("#btnsubmit").on('click',function(){

       		if( document.myForm.taskname.value == "" )
	         {
	           alert( "Please Specify Task name" );
	           document.myForm.taskname.focus() ;
	           return false;
	         }

			var _data = $('form').serialize();
			$.post("<?php echo SITE_URL ?>/admin/dashboard/ajax/create_task_controller",_data, function(data){
				data = $.trim(data);
				console.log(data);
				if(data=="1"){						
					Modal.hasHeader = 
					Modal.hasButton = false;
					Modal.addId = "action_modal";
					Modal.contents = "<h1 style='text-align:center;'>Task Created Successfully!</h1>";
					Modal.show($);
					location.reload();		
				}else{
					alert('Error! Please Contact System Administrator!');	
				}
			});
			return false;
		});

       $("#btnupdate").on('click',function(){

       		if( document.myFormUpdate.tasknameup.value == "" )
	         {
	           alert( "Please Specify Task name" );
	           document.myFormUpdate.tasknameup.focus() ;
	           return false;
	         }

			var _data = $('form').serialize();
			$.post("<?php echo SITE_URL ?>/admin/dashboard/ajax/update_task_controller",_data, function(data){
				data = $.trim(data);
				console.log(data);
				if(data=="1"){						
					Modal.hasHeader = 
					Modal.hasButton = false;
					Modal.addId = "action_modal";
					Modal.contents = "<h1 style='text-align:center;'>Task Updated Successfully!</h1>";
					Modal.show($);
					location.reload();		
				}else{
					alert('Error! Please Contact System Administrator!');	
				}
			});
			return false;
		});

       $("#btndelete").on('click',function(){

       		if( document.myFormUpdate.tasknameup.value == "" )
	         {
	           alert( "Please Specify Task name" );
	           document.myFormUpdate.tasknameup.focus() ;
	           return false;
	         }

			var _data = $('form').serialize();
			$.post("<?php echo SITE_URL ?>/admin/dashboard/ajax/delete_task_controller",_data, function(data){
				data = $.trim(data);
				console.log(data);
				if(data=="1"){						
					Modal.hasHeader = 
					Modal.hasButton = false;
					Modal.addId = "action_modal";
					Modal.contents = "<h1 style='text-align:center;'>Task Deleted Successfully!</h1>";
					Modal.show($);
					location.reload();		
				}else{
					alert('Error! Please Contact System Administrator!');	
				}
			});
			return false;
		});
});

</script>