<div class="container-fluid">
<div class="row">
<div class="col-sm-3 col-md-2 sidebar">

<?php if(!isset($current_page)) $current_page = ""; ?>
<div id="sidebar" class="<?php echo "acctype-{$_SESSION['user_type']}"; ?>">
	<span class="extension"></span>
	<ul>
		<li><a href="/admin/dashboard"><i class="fa fa-lightbulb-o"></i><span>Dashboard</span></a></li>
	</ul>
</div>
<!--
<a href="/admin/dashboard">Home</a>
<a href="/admin/ewallet">Ewallet</a>
<a href="/admin/geneology">Geneology</a>
<a href="/admin/library">Library</a>
<a href="/admin/jobs">Jobs</a>
<a href="/admin/account">Account</a>

<hr />
 special 
<a href="/admin/request">Request</a>
<a href="/admin/db">Database</a>
<a href="/admin/bstatus">Business Status</a>
-->
</div>