<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");

$restaurantID = intval($_GET['RestaurantID']);

    // Fetch menu items
    $result = $con->query("SELECT MenuID, Item, Price, Description FROM menu WHERE RestaurantID = $restaurantID");

    if ($result->num_rows > 0) {
        $menu = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode($menu);
    } else {
        echo json_encode(["message" => "No menu items found"]);
    }

$con->close();

?>
