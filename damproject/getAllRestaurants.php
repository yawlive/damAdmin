<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include("connect.php");



    $stmt = $con->prepare("SELECT r.* ,COALESCE(ROUND(AVG(comments.Review), 2), 0) as rating FROM restaurants r 
                           left join comments on r.RestaurantID=comments.RestaurantID
                        group by RestaurantID;  ");

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
