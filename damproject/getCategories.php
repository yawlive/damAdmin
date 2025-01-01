<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");

$region = $_GET['region'];
$sql = "SELECT DISTINCT CategoryName FROM Restaurants WHERE RegionName='$region'";
$result = $con->query($sql);
$data = [];

while($row = $result->fetch_assoc()) {
    $data[] = $row['CategoryName'];
}

echo json_encode($data);
?>
