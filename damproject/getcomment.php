<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");

$restaurantID = intval($_GET['RestaurantID']);

// Fetch menu items
$result = $con->query("SELECT comments.* ,users.username FROM comments join users on users.email=comments.email WHERE RestaurantID = $restaurantID");

if ($result->num_rows > 0) {
    $comments = $result->fetch_all(MYSQLI_ASSOC);
    echo json_encode($comments);
} else {
    echo json_encode(["message" => "No reviews "]);
}

$con->close();

?>

