<div class="col-sm-9 col-md-10 main">
<!--  Start Editing Here  -->
<div class="container main" id="dashboard">
	<h3>Tasks</h3>
	<table class="table">
		<thead>
			<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Description</th>
				<th>datecreated</th>
				<th>dateupdated</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<?php if(count($record)>0) : ?>
				<?php
				if($record) :
					foreach($record as $k=>$v) : ?>
					<tr>
						<td><?php echo $v['id'] ?></td>
						<td><?php echo $v['name'] ?></td>
						<td><?php echo $v['description'] ?></td>
						<td><?php echo $v['datecreated'] ?></td>
						<td><?php echo $v['dateupdated'] ?></td>
						<td>
							<button data-target="#AddBookDialog" data-toggle="modal" data-taskid="<?php echo $v['id'] ?>" name="<?php echo $v['id'] ?>" data-id="<?php echo $v['name'] ?>" data-name="<?php echo $v['description'] ?>"  type="button" class="open-AddBookDialog btn btn-warning" href="#addBookDialog">View</button>
													
						</td>
					</tr>
					<?php endforeach;
				else: ?>
					<tr>
						<td colspan="6">No record yet</td>
					</tr>
				<?php
				endif;
				?>
			<?php else: ?>
				<tr>
					<td colspan="6">No record yet</td>
				</tr>
			<?php endif; ?>

		</tbody>
	</table>
</div>

<button type="button" class="btn btn-primary pull-right" data-id="" data-name=""  data-toggle="modal" data-target="#myModal">Create Task</button>
<!-- End Editing Here -->

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Create Task</h4>
      </div>
      <form action="" name="myForm" method="POST">
	      <div class="modal-body">
	        <p>Task Name</p>
	        <input class="form-control" type="text" name="taskname" id="taskname">
	        <p>Task Description</p>
	        <input class="form-control" type="text" name="taskdesc" id="taskdesc">
	      </div>
	      <div class="modal-footer">
	      	<button type="button" id="btnsubmit" class="btn btn-primary">Add</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
     </form>
  </div>
</div>

<div id="AddBookDialog" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Create Task</h4>
      </div>
      <form action="" name="myFormUpdate" method="POST">
	      <div class="modal-body">
	        <p>Task Name</p>
	        <input class="form-control" type="text" name="tasknameup" id="tasknameup">
	        <p>Task Description</p>
	        <input class="form-control" type="text" name="taskdescup" id="taskdescup">
	        <input class="form-control" type="hidden" name="taskidup" id="taskidup">
	      </div>
	      <div class="modal-footer">
	      	<button type="button" id="btnupdate" class="btn btn-primary">Update</button>
	      	<button type="button" id="btndelete" class="btn btn-danger">Delete</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
     </form>
  </div>
</div>







</div>
</div>
</div>

