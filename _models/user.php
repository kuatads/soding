<?php
class User{
	function __construct(){
		
	}
	function add_account(){
		$db = new DB();
		$proc_name = 'addAccount';
		$param = array(
			array('pos'=>"OUT",'nam'=>'_error','typ'=>"VARCHAR",'lim'=>100),
			array('pos'=>"IN",'nam'=>'_ID','typ'=>"INT",'lim'=>10,'val'=>$_SESSION['user_ID']),
			array('pos'=>"IN",'nam'=>'_placement_ID','typ'=>"INT",'lim'=>10,'val'=>$_POST['pid']),
			array('pos'=>"IN",'nam'=>'_position','typ'=>"VARCHAR",'lim'=>5,'val'=>$_POST['position']),
			array('pos'=>"IN",'nam'=>'_type','typ'=>"VARCHAR",'lim'=>10,'val'=>$_POST['acc_type']),
			array('pos'=>"IN",'nam'=>'_amount','typ'=>"INT",'lim'=>10,'val'=>$_POST['amount']),
			array('pos'=>"IN",'nam'=>'_username','typ'=>"VARCHAR",'lim'=>100,'val'=>$_POST['username']),
		);
		$result = $db->create_proc($proc_name,$param);
		return $result[0];
		//$db->drop_proc($proc_name);
	}
	
	function insert($info){
		$db = new DB();
		$salt = md5($info['password']+"tangly");
		$proc_name = 'userReg';
		$param=array(
			array('pos'=>"OUT",'nam'=>'_user_ID','typ'=>"INT",'lim'=>10),
			// users
		    array('pos'=>"IN",'nam'=>'_name','typ'=>"VARCHAR",'lim'=>100,'val'=>$info['name']),
		    array('pos'=>"IN",'nam'=>'_password','typ'=>"TEXT",'val'=>$info['password']=md5($info['password'].$salt)),
		    array('pos'=>"IN",'nam'=>'email','typ'=>"VARCHAR",'lim'=>100,'val'=>$info['email']),
		    array('pos'=>"IN",'nam'=>'mobile','typ'=>"VARCHAR",'lim'=>100,'val'=>$info['mobile']),
		    array('pos'=>"IN",'nam'=>'photo','typ'=>"TEXT",'val'=>$info['photo']),
		    array('pos'=>"IN",'nam'=>'address','typ'=>"TEXT",'val'=>$info['address']),
		    array('pos'=>"IN",'nam'=>'username','typ'=>"VARCHAR",'lim'=>100,'val'=>$info['username']),	    
		    array('pos'=>"IN",'nam'=>'pin','typ'=>"VARCHAR",'lim'=>30,'val'=>$this->encrypt_decrypt('encrypt',$info['pin'])),	    
		    // array('pos'=>"IN",'nam'=>'_status','typ'=>"VARCHAR",'lim'=>100,'val'=>$info['status']),	
		    // user-meta
		    array('pos'=>"IN",'nam'=>'sponsor_ID','typ'=>"INT",'lim'=>10,'val'=>$info['sid']),
		    array('pos'=>"IN",'nam'=>'placement_ID','typ'=>"INT",'lim'=>10,'val'=>$info['pid']),
		    array('pos'=>"IN",'nam'=>'_position','typ'=>"VARCHAR",'lim'=>5,'val'=>$info['position']),
		    array('pos'=>"IN",'nam'=>'_type','typ'=>"VARCHAR", 'lim'=>100,'val'=>$info['_type']),
		    // user-payment
		    array('pos'=>"IN",'nam'=>'payment_type','typ'=>"VARCHAR",'lim'=>50,'val'=>$info['payment_type']),
		    array('pos'=>"IN",'nam'=>'amount','typ'=>"INT",'lim'=>7,'val'=>$info['payed_amount']),
		    array('pos'=>"IN",'nam'=>'_code','typ'=>"TEXT",'val'=>$info['codes']),
		    array('pos'=>"IN",'nam'=>'receipt_url','typ'=>"TEXT",'val'=>$info['payment_receipt'])
		);

		$result = $db->create_proc($proc_name,$param);
		$_SESSION['user_ID'] = $result[0]['@user_ID'];
		$_SESSION['name'] = $info['name'];
		$_SESSION['photo'] = $info['photo'];
		$_SESSION['user_type']= $info['_type'];
		$_SESSION['pin'] = $info['pin'];//$this->encrypt_decrypt('decrypt',$result[0]['pin']);

		//$db->drop_proc('userReg');
	}

	public function update($newpass){
		$db = new DB();

		$salt = md5($newpass+"tangly");
		$uid = $_SESSION['user_ID'];

		$data = array(
				'password'=>$newpass=md5($newpass.$salt)
			);

		$q = "UPDATE `users` SET password=:password WHERE id=:ID";
		$arr = array("password"=>$newpass, "ID"=>$_SESSION['user_ID']);
		$db->query($q,$arr);

	}
	
	private function encrypt_decrypt($action, $string) {
	    $output = false;

	    $encrypt_method = "AES-256-CBC";
	    $secret_key = SECRET_KEY;
	    $secret_iv = SECRET_IV;

	    // hash
	    $key = hash('sha256', $secret_key);
	    
	    // iv - encrypt method AES-256-CBC expects 16 bytes - else you will get a warning
	    $iv = substr(hash('sha256', $secret_iv), 0, 16);

	    if( $action == 'encrypt' ) {
	        $output = openssl_encrypt($string, $encrypt_method, $key, 0, $iv);
	        $output = base64_encode($output);
	    }
	    else if( $action == 'decrypt' ){
	        $output = openssl_decrypt(base64_decode($string), $encrypt_method, $key, 0, $iv);
	    }

	    return $output;
	}

	function validate_login($data){
		$db = new DB();
		$password = $data['password'];

		$salt = md5($password+"tangly");
		$password=md5($password.$salt);

		$param = array(
				'username'=>$_POST['username'],
				'password'=>$password
			);
		$stmt = $db->query("SELECT ID, photo, name FROM users WHERE username=:username AND password=:password",$param);
		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
		if(empty($result))
			return false;
		else{
			$_SESSION['user_ID'] = $result[0]['ID'];
			$_SESSION['name'] = $result[0]['name'];
			$_SESSION['user_type'] = $result[0]['user_type'];
			$_SESSION['photo'] = $result[0]['photo'];

			return true;

		}			
	}

	private function saltifypassword(&$pass){
		$salt = md5($pass+"tangly");
		$pass=md5($pass.$salt);
	}

}