<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");

$sql = "SELECT count(distinct RegionName) as regions , count(RestaurantID) as rests FROM Restaurants";
$result = $con->query($sql);

if ($result) {
    $data = $result->fetch_assoc();
    echo json_encode($data);
} else {
    echo json_encode(["message" => "Error: " . $con->error]);
}

$con->close();
?>