<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");
$email=$_GET['email'];
$RestaurantID = $_GET['RestaurantID'];

$sql = "SELECT 
            r.*, 
            CASE 
                WHEN l.email IS NOT NULL THEN 1
                ELSE 0
            END AS liked
        FROM
            restaurants r
        LEFT JOIN 
            likes l
        ON 
            r.RestaurantID = l.RestaurantID AND l.email = '$email'
        WHERE 
            r.RestaurantID = '$RestaurantID'";
$result = $con->query($sql);

while($row = $result->fetch_assoc()) {
    $restaurant[] = $row;
}

echo json_encode($restaurant);
?>
