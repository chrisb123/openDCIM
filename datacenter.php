<?php
	require_once( 'db.inc.php' );
	require_once( 'facilities.inc.php' );

	$user=new User();

	$user->UserID=$_SERVER['REMOTE_USER'];
	$user->GetUserRights($facDB);

	if(!$user->SiteAdmin){
		// No soup for you.
		header('Location: '.redirect());
		exit;
	}

	$dc=new DataCenter();
	if(isset($_REQUEST['action']) && (($_REQUEST['action']=='Create')||($_REQUEST['action']=='Update'))){
		$dc->DataCenterID = $_REQUEST['datacenterid'];
		$dc->Name = $_REQUEST['name'];
		$dc->SquareFootage = $_REQUEST['squarefootage'];
		$dc->DeliveryAddress = $_REQUEST['deliveryaddress'];
		$dc->Administrator = $_REQUEST['administrator'];
		$dc->DrawingFileName = $_REQUEST['drawingfilename'];
		$dc->rows = $_REQUEST['rows'];
		$dc->cols = $_REQUEST['cols'];
		$dc->ppd = $_REQUEST['ppd'];
		$dc->start_row = $_REQUEST['start_row'];
		$dc->start_col = $_REQUEST['start_col'];
		
		if($_REQUEST['action']=='Create'){
			$dc->CreateDataCenter($facDB);
		}else{
			$dc->UpdateDataCenter($facDB);
		}
	}

	if(isset($_REQUEST['datacenterid']) && $_REQUEST['datacenterid'] >0){
		$dc->DataCenterID=$_REQUEST['datacenterid'];
		$dc->GetDataCenter($facDB);
	}
	$dcList=$dc->GetDCList($facDB);
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
  <title>openDCIM Data Center Inventory</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <link rel="stylesheet" href="css/inventory.css" type="text/css">
  <!--[if lt IE 9]>
  <link rel="stylesheet"  href="css/ie.css" type="text/css">
  <![endif]-->
  <script type="text/javascript" src="scripts/jquery.min.js"></script>
</head>
<body>
<div id="header"></div>
<div class="page">
<?php
	include( 'sidebar.inc.php' );
?>
<div class="main">
<h2><?php echo $config->ParameterArray['OrgName']; ?></h2>
<h3>Data Center Detail</h3>
<div class="center"><div>
<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="POST">
<div class="table">
<div>
   <div><label for="datacenterid">Data Center ID</label></div>
   <div><select name="datacenterid" id="datacenterid" onChange="form.submit()">
      <option value="0">New Data Center</option>
<?php
	foreach($dcList as $dcRow){
		echo "<option value=\"$dcRow->DataCenterID\"";
		if($dcRow->DataCenterID == $dc->DataCenterID){
			echo ' selected="selected"';
		}
		echo ">$dcRow->Name</option>\n";
	}
?>
	</select></div>
</div>
<div>
   <div><label for="dcname">Name</label></div>
   <div><input type="text" name="name" id="dcname" size="50" value="<?php echo $dc->Name; ?>"></div>
</div>
<div>
   <div><label for="sqfootage">Square Footage</label></div>
   <div><input type="text" name="squarefootage" id="sqfootage" size="10" value="<?php echo $dc->SquareFootage; ?>"></div>
</div>
<div>
   <div><label for="deliveryaddress">Delivery Address</label></div>
   <div><input type="text" name="deliveryaddress" id="deliveryaddress" size="60" value="<?php echo $dc->DeliveryAddress; ?>"></div>
</div>
<div>
   <div><label for="administrator">Administrator</label></div>
   <div><input type="text" name="administrator" id="administrator" size=60 value="<?php echo $dc->Administrator; ?>"></div>
</div>
<div>
   <div><label for="drawingfilename">Drawing URL</label></div>
   <div><input type="text" name="drawingfilename" id="drawingfilename" size=60 value="<?php echo $dc->DrawingFileName; ?>"></div>
</div>
<div>
   <div><label for="drawingfilename">Rows</label></div>
   <div><input type="text" name="rows" id="rows" size=60 value="<?php echo $dc->rows; ?>"></div>
</div>
<div>
   <div><label for="drawingfilename">Cols</label></div>
   <div><input type="text" name="cols" id="cols" size=60 value="<?php echo $dc->cols; ?>"></div>
</div>
<div>
   <div><label for="drawingfilename">Div</label></div>
   <div><input type="text" name="ppd" id="ppd" size=60 value="<?php echo $dc->ppd; ?>"></div>
</div>
<div>
   <div><label for="drawingfilename">Start row</label></div>
   <div><input type="text" name="start_row" id="start_row" size=60 value="<?php echo $dc->start_row; ?>"></div>
</div>
<div>
   <div><label for="drawingfilename">Start Col</label></div>
   <div><input type="text" name="start_col" id="start_col" size=60 value="<?php echo $dc->start_col; ?>"></div>
</div>
<div class="caption">
<?php
	if($dc->DataCenterID >0){
		echo '   <input type="submit" name="action" value="Update">';
	}else{
		echo '   <input type="submit" name="action" value="Create">';
	}
?>
</div>
</div> <!-- END div.table -->
</form>
</div></div>
<a href="index.php">[ Return to Main Menu ]</a>
</div><!-- END div.main -->
</div><!-- END div.page -->
</body>
</html>
