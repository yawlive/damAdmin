<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');
include 'connect.php';

    $restaurantId = $_GET['RestaurantId'];


    if (!empty($restaurantId)) {
        $query = "DELETE FROM Restaurants WHERE RestaurantID = ?";
        $stmt = $con->prepare($query);
        $stmt->bind_param("i", $restaurantId);

        if ($stmt->execute()) {
            echo json_encode(["status" => "success"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Failed to delete"]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "No id provided"]);
    }

?>
