<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include("connect.php");


$email = $_GET['email'];
$RestaurantID = (int)$_GET['RestaurantID'];
$liked = $_GET['liked'] == '0';


if ($liked) {
    $query = "INSERT INTO likes (email, RestaurantID) VALUES ('$email', '$RestaurantID')";
} else {
    $query = "DELETE FROM likes WHERE email = '$email' AND RestaurantID = '$RestaurantID'";
}

if (mysqli_query($con, $query)) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'error' => mysqli_error($con)]);
}

mysqli_close($con);
?>
