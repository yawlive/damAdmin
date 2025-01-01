<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");

$result = $con->query("SELECT  comments.* ,users.username , restaurants.RestaurantName FROM comments , users , restaurants where users.email=comments.email and comments.RestaurantID=restaurants.RestaurantID");

if ($result->num_rows > 0) {
    $comments = $result->fetch_all(MYSQLI_ASSOC);
    echo json_encode($comments);
} else {
    echo json_encode(["message" => "No reviews on restaurant yet be first"]);
}

$con->close();
?>
