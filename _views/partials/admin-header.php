<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Soding</title>
	<link href="<?php echo SITE_URL ?>/assets/css/bootstrap.min.css" rel="stylesheet">
  <link href="<?php echo SITE_URL ?>/assets/css/font-awesome.min.css" rel="stylesheet">
  <link href="<?php echo SITE_URL ?>/assets/css/site.css" rel="stylesheet">
	<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body class="<?php echo $acc_type ?>">

<header class="navbar navbar-static-top bs-docs-nav" id="top" role="banner">
  <div id="header" class="block clearfix">
    <div id="branding" class="center">
    </div>
    <div class="pull-right vcenter">      
      <a href="#" id="avatar">
        <img src='<?php echo SITE_URL ?>/uploads/avatar.png' />
      </a>
      <span id="username">Welcome <?php echo $name ?>!</span>
      <a href="<?php echo SITE_URL ?>/admin/logout" id="btn-logout" class="center"><i class="fa fa-power-off"></i></a>
    </div>
    <div id="headings">
    </div>
  </div>
</header>
<hr />
