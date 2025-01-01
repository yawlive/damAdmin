<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");

$region = $_GET['region'];
$category = $_GET['category'];

$stmt = $con->prepare("SELECT * FROM restaurants WHERE lower(RegionName) = lower(?) AND lower(CategoryName) = lower(?)");
$stmt->bind_param("ss", $region, $category);
$stmt->execute();
$result = $stmt->get_result();

$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data);
?>
