<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include("connect.php");

$email=$_GET['email'];


    $stmt = $con->prepare("SELECT r.*  FROM restaurants r 
                            join likes on r.RestaurantID=likes.RestaurantID
                            WHERE likes.email=? ");

    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    $restaurants = [];

    while ($row = $result->fetch_assoc()) {
        $restaurants[] = $row;
    }

    echo json_encode($restaurants);
    $stmt->close();



$con->close();
?>

