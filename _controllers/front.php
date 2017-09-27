<?php

class Front{
	function __construct(){
		// always called first
		session_start();
	}
	function end(){
		// always called last
		Load::view('partials/footer');
	}
	function FIRST(){
		// first to call
		$this->login();
	}

	public function login(){
		$param=array();
		if(isset($_POST['username'])) {
			Load::model('user');
			$User = new User();			
			if( $User->validate_login($_POST) )
				Load::redirect('admin/dashboard');
			else
				$param = array("msg"=>"Wrong username and password.");
		}
		Load::view('partials/header-login');
		Load::view('login',$param);
		Load::hook_footer('signin');
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
}