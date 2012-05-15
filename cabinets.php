<?php
	require_once( 'db.inc.php' );
	require_once( 'facilities.inc.php' );

	$user=new User();
	$user->UserID=$_SERVER['REMOTE_USER'];
	$user->GetUserRights( $facDB );

	if(!$user->SiteAdmin){
		// No soup for you.
		header('Location: '.redirect());
		exit;
	}

	$cab=new Cabinet();
	$dept=new Department();
	$dc=new DataCenter();
	$dc->DataCenterID=$_REQUEST['datacenterid'];
	$dc->GetDataCenter($facDB);

	if(isset($_REQUEST['cabinetid'])){
		$cab->CabinetID=$_REQUEST['cabinetid'];
		$cab->GetCabinet($facDB);
	}

	if(isset($_REQUEST['action']) && $user->WriteAccess){
		if(($cab->CabinetID >0)&&($_REQUEST['action']=='Update')){
			$cab->DataCenterID=$_REQUEST['datacenterid'];
			$cab->Location=$_REQUEST['location'];
			$cab->AssignedTo=$_REQUEST['assignedto'];
			$cab->CabinetHeight=$_REQUEST['cabinetheight'];
			$cab->Model=$_REQUEST['model'];
			$cab->MaxKW=$_REQUEST['maxkw'];
			$cab->MaxWeight=$_REQUEST['maxweight'];
			$cab->InstallationDate=$_REQUEST['installationdate'];
			$cab->width=$_REQUEST['width'];
			$cab->depth=$_REQUEST['depth'];
			$cab->offset=$_REQUEST['offset'];
			$cab->direction=$_REQUEST['direction'];

$rows = $dc->rows; #number of rows
$cols = $dc->cols; #number of cols
$div = $dc->ppd; #tile size in pixels
$start_row = $dc->start_row;
$start_col = $dc->start_col;

$len = strlen($cab->Location);
if ($len == 4) {
 $yref = substr($cab->Location,0,2);
} else {
 $yref = substr($location,0,1);
}
$xref = substr($cab->Location, -2);
$xgrid = $xref - $start_col + 1;

$ygrid = 1;
$i = $start_row;
while($i != $yref) {
 $i++;
 $ygrid++;
}
$refx = $xgrid; #grid ref x
$refy = $ygrid; #grid ref y
$width = $cab->width; #in mm
$depth = $cab->depth; #in mm
$offset = $cab->offset; #for offset racks
$mmpd = 600; #mm per tile
$dir = $cab->direction; #direction of rack;
if ($dir == 'N') {
 $x1 = ($refx+1)*$div-$offset/$mmpd*$div;
 $y1 = ($refy+0)*$div;
 $x2 = $x1-($width/$mmpd*$div);
 $y2 = $y1+($depth/$mmpd*$div);
 $xy = $y1+($depth*.2/$mmpd*$div);}
if ($dir == 'S') {
 $x1 = ($refx+0)*$div+$offset/$mmpd*$div;
 $y1 = ($refy+1)*$div;
 $x2 = $x1+($width/$mmpd*$div);
 $y2 = $y1-($depth/$mmpd*$div);
 $xy = $y1-($depth*.2/$mmpd*$div);}
if ($dir == 'E') {
 $x1 = ($refx+1)*$div;
 $y1 = ($refy+0)*$div-$offset/$mmpd*$div;
 $y2 = $y1+($width/$mmpd*$div);
 $x2 = $x1-($depth/$mmpd*$div);
 $xy = $x1-($depth*.2/$mmpd*$div);}
if ($dir == 'W') {
 $x1 = ($refx+0)*$div;
 $y1 = ($refy+0)*$div+$offset/$mmpd*$div;
 $y2 = $y1+($width/$mmpd*$div);
 $x2 = $x1+($depth/$mmpd*$div);
 $xy = $x1+($depth*.2/$mmpd*$div);}

			$cab->MapX1=$x1;
			$cab->MapX2=$x2;
			$cab->MapY1=$y1;
			$cab->MapY2=$y2;
			$cab->MapXY=$xy;
			$cab->UpdateCabinet($facDB);
		}elseif($_REQUEST['action']=='Create'){
			$cab->DataCenterID=$_REQUEST['datacenterid'];
			$cab->Location=$_REQUEST['location'];
			$cab->AssignedTo=$_REQUEST['assignedto'];
			$cab->CabinetHeight=$_REQUEST['cabinetheight'];
			$cab->Model=$_REQUEST['model'];
			$cab->MaxKW=$_REQUEST['maxkw'];
			$cab->MaxWeight=$_REQUEST['maxweight'];
			$cab->InstallationDate=$_REQUEST['installationdate'];
			$cab->width=$_REQUEST['width'];
			$cab->depth=$_REQUEST['depth'];
			$cab->offset=$_REQUEST['offset'];
			$cab->direction=$_REQUEST['direction'];
			$cab->CreateCabinet($facDB);
		}
	}

	if($cab->CabinetID >0){
		$cab->GetCabinet($facDB);
	}else{
		$cab->CabinetID=null;
		$cab->DataCenterID=null;
		$cab->Location=null;
		$cab->CabinetHeight=null;
		$cab->Model=null;
		$cab->MaxKW=null;
		$cab->MaxWeight=null;
		$cab->InstallationDate=date('m/d/Y');
		$cab->width=600;
		$cab->depth=900;
		$cab->offset=0;
		$cab->direction="N";
	}

	$deptList=$dept->GetDepartmentList($facDB);
	$cabList=$cab->ListCabinets($facDB);
?>
<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN' 'http://www.w3.org/TR/html4/loose.dtd'>
<html>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=windows-1252'>
  <meta http-equiv='X-UA-Compatible' content='IE=edge'>
  <title>Facilities Cabinet Maintenance</title>
  <link rel='stylesheet' href='css/inventory.css' type='text/css'>
  <!--[if lt IE 9]>
  <link rel='stylesheet'  href='css/ie.css' type='text/css'>
  <![endif]-->
  <script type='text/javascript' src='scripts/jquery.min.js'></script>
</head>
<body>
<div id='header'></div>
<div class='page'>
<?php
	include( 'sidebar.inc.php' );
?>
<div class='main'>
<h2><?php echo $config->ParameterArray['OrgName']; ?></h2>
<h3>Data Center Cabinet Inventory</h3>
<div class='center'><div>
<form action='<?php echo $_SERVER['PHP_SELF']; ?>' method='POST'>
<div class='table'>
<div>
   <div>Cabinet</div>
   <div><select name='cabinetid' onChange='form.submit()'>
   <option value='0'>New Cabinet</option>
<?php
	foreach($cabList as $cabRow){
		echo '<option value=\''.$cabRow->CabinetID.'\'';
		if($cabRow->CabinetID == $cab->CabinetID){
			echo ' selected';
		}
		echo '>'.$cabRow->Location.'</option>\n';
	}
?>
   </select></div>
</div>
<div>
   <div>Data Center</div>
   <div><?php echo $cab->GetDCSelectList($facDB); ?></div>
</div>
<div>
   <div>Location</div>
   <div><input type='text' name='location' size='8' value='<?php echo $cab->Location; ?>'></div>
</div>
<div>
  <div>Assigned To:</div>
  <div><select name='assignedto'>
    <option value='0'>General Use</option>
<?php
	foreach($deptList as $deptRow){
		echo '<option value=\''.$deptRow->DeptID.'\'';
		if($deptRow->DeptID == $cab->AssignedTo){echo ' selected=\'selected\'';}
		echo '>'.$deptRow->Name.'</option>\n';
	}
?>
  </select>
  </div>
</div>
<div>
   <div>Cabinet Height (U)</div>
   <div><input type='text' name='cabinetheight' size='4' value='<?php echo $cab->CabinetHeight; ?>'></div>
</div>
<div>
   <div>Model</div>
   <div><input type='text' name='model' size='30' value='<?php echo $cab->Model; ?>'></div>
</div>
<div>
   <div>Maximum kW</div>
   <div><input type='text' name='maxkw' size='30' value='<?php echo $cab->MaxKW; ?>'></div>
</div>
<div>
   <div>Maximum Weight</div>
   <div><input type='text' name='maxweight' size='30' value='<?php echo $cab->MaxWeight; ?>'></div>
</div>
<div>
   <div>Date of Installation</div>
   <div><input type='text' name='installationdate' size='15' value='<?php echo date('m/d/Y', strtotime($cab->InstallationDate)); ?>'></div>
</div>
<div>
   <div>Width</div>
   <div><input type='text' name='width' size='15' value='<?php echo $cab->width; ?>'></div>
</div>
<div>
   <div>Depth</div>
   <div><input type='text' name='depth' size='15' value='<?php echo $cab->depth; ?>'></div>
</div>
<div>
   <div>Offset</div>
   <div><input type='text' name='offset' size='15' value='<?php echo $cab->offset; ?>'></div>
</div>
<div>
   <div>Direction</div>
   <div><input type='text' name='direction' size='15' value='<?php echo $cab->direction; ?>'></div>
</div>
<?php
	if($user->WriteAccess){
		echo '<div class=\'caption\'>';
		if($cab->CabinetID >0){
			echo '   <input type=\'submit\' name=\'action\' value=\'Update\'>';
		}else{
			echo '   <input type=\'submit\' name=\'action\' value=\'Create\'>';
		}
		echo '</div>';		
	}
?>
</div> <!-- END div.table -->
</form>
</div></div>
<?php if($cab->CabinetID >0){
		echo '<a href=\'cabnavigator.php?cabinetid='.$cab->CabinetID.'\'>[ Return to Navigator ]</a>'; 
	}else{ 
		echo '<a href="index.php">[ Return to Main Menu ]</a>';
	}
?>
</div><!-- END div.main -->
</div><!-- END div.page -->
</body>
</html>
