<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");

$region=$_GET['region'];

$sql = "delete from restaurants where RegionName='$region'";
$result = $con->query($sql);

?>
