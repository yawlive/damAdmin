<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];
    $field = $_POST['field'];
    $value = $_POST['value'];

    $allowedFields = ['RestaurantName', 'Phone', 'Description', 'ImageURL', 'Region', 'Category'];

    if (!in_array($field, $allowedFields)) {
        echo "Invalid field";
        exit;
    }
    
    $sql = "UPDATE Restaurants SET $field = ? WHERE RestaurantID = ?";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("si", $value, $id);

    if ($stmt->execute()) {
        echo "Success";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();
}
?>
