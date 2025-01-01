<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");

$restaurantid = $_POST[restaurantid];
$email=$_POST['email'];
$comment =$_POST['comment'];
$review=$_POST['review'];

$stmt = $con->prepare("INSERT INTO comments (email, RestaurantID, CommentText, Review, CommentDate) VALUES (?, ?, ?, ?, NOW())");
$stmt->bind_param("siss", $email, $restaurantid, $comment, $review);
$stmt->execute();
?>