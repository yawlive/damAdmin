<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");

$sql = "SELECT DISTINCT RegionName FROM Restaurants";
$result = $con->query($sql);
$data = [];

while($row = $result->fetch_assoc()) {
    $data[] = $row['RegionName'];
}

echo json_encode($data);
?>

