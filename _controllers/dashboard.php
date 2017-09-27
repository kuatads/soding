<?php
include_once('admin.php');
class Dashboard extends Admin {
	private $param = array();

	function __construct(){
	
	}
	function FIRST(){
		Load::model('dashboard_model');
		$dashboard_model = new Dashboard_model();

			
		$result['record'] = $dashboard_model->get_tasklist();
		Load::view('dashboard',$result);
		Load::hook_js('modal');
		Load::hook_footer('actionjs');
	}

	function create_task_controller(){
		Load::hook_js('modal');
		Load::model('dashboard_model');
		$dashboard_model = new Dashboard_model();

		if ($_POST['taskname'] != "")
		{
			$dashboard_model->createTask($_POST['taskname'],$_POST['taskdesc']);
			echo 1; // Success
		} else { 
			echo 0; // Error
		}
		exit();
	}

	function update_task_controller(){
		
		Load::hook_js('modal');
		Load::model('dashboard_model');
		$dashboard_model = new Dashboard_model();

		if ($_POST['taskidup'] != "")
		{
			$dashboard_model->update_task($_POST['taskidup'],$_POST['tasknameup'],$_POST['taskdescup']);
			echo 1; // Success
		} else { 
			echo 0; // Error
		}
		exit();
	}

	function delete_task_controller(){
		
		Load::hook_js('modal');
		Load::model('dashboard_model');
		$dashboard_model = new Dashboard_model();

		if ($_POST['taskidup'] != "")
		{
			$dashboard_model->delete_task($_POST['taskidup']);
			echo 1; // Success
		} else { 
			echo 0; // Error
		}
		exit();
	}


}