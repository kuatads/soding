<?php

class Dashboard_model{
	function __construct(){
		
	}
	
	function get_tasklist(){
		$db = new DB();
		$stmt = $db->query("SELECT * FROM task", array());
		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
		return (empty($result)) ? false : $result;
	}

	function createTask($taskname,$taskdesc){
		$db = new DB();
		$db->set('table_name','task');
		$param['name']=$taskname;
		$param['description']=$taskdesc;
		$param['datecreated']=date("Y-m-d");
		$db->insert($param);
	}

	public function update_task($id,$taskname,$taskdesc){
		$db = new DB();

		$q = "UPDATE `task` SET name=:name, description=:description, dateupdated=NOW() WHERE id=:id";
		$arr = array("id"=>$id, "name"=>$taskname, "description"=>$taskdesc);
		$db->query($q,$arr);

	}

	public function delete_task($id){
		$db = new DB();

		$q = "DELETE FROM `task` WHERE id=:id";
		$arr = array("id"=>$id);
		$db->query($q,$arr);

	}
}