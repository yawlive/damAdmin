<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");
$region = $_GET['region'];

$stmt = $con->prepare("SELECT r.* , COALESCE(ROUND(AVG(comments.Review), 2), 0)  as rating FROM restaurants r left join comments on r.RestaurantID=comments.RestaurantID WHERE lower(r.RegionName) = lower(?) GROUP BY r.RestaurantID;");
$stmt->bind_param("s", $region);
$stmt->execute();
$result = $stmt->get_result();
$data = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    echo json_encode(["status" => "success", "data" => $data]);
} else {
    echo json_encode(["status" => "error" , "message" => "Region not available on our app yet "]);
}

$stmt->close();
$con->close();
?>