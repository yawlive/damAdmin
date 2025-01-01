<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");


$restaurantName = $_POST['RestaurantName'];
$phone = $_POST['Phone'];
$description = $_POST['Description'];
$imageURL = $_POST['ImageURL'];
$regionName = $_POST['RegionName'];
$categoryName = $_POST['CategoryName'];
$openingTime = $_POST['OpeningTime'];
$closingTime = $_POST['ClosingTime'];
$location = $_POST['Location'];
$priceRange = (int)$_POST['priceRange'];

$sql = "INSERT INTO Restaurants (
            RestaurantName, 
            Phone, 
            Description, 
            ImageURL, 
            RegionName, 
            CategoryName, 
            OpeningTime, 
            ClosingTime, 
            Location, 
            priceRange
        ) 
        VALUES (
            '$restaurantName', 
            '$phone', 
            '$description', 
            '$imageURL', 
            '$regionName', 
            '$categoryName', 
            '$openingTime', 
            '$closingTime', 
            '$location', 
            $priceRange
        )";

if ($con->query($sql) === TRUE) {
    echo json_encode(["message" => "Restaurant added successfully"]);
} else {
    echo json_encode(["message" => "Error: " . $con->error]);
}
?>
