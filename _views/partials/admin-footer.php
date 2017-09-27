  </body>
  <script src="<?php echo SITE_URL ?>/assets/js/jquery.min.js"></script>
  <script src="<?php echo SITE_URL ?>/assets/js/bootstrap.min.js"></script>
  <script>
	$(document).on("click", ".open-AddBookDialog", function () {
	    
	     var mytask = $(this).data('id');
	     $(".modal-body #tasknameup").val( mytask );
	      
	     var mytaskdesc = $(this).data('name');
	     $(".modal-body #taskdescup").val( mytaskdesc );

	     var mytaskidup = $(this).data('taskid');
	     $(".modal-body #taskidup").val( mytaskidup );
	});
</script>
  
  <?php Load::do_css(); ?>
  <?php Load::do_js(); ?>
  <?php Load::do_footer(); ?>

</html>
