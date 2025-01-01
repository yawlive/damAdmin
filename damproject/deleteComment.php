<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');
include 'connect.php';

$commentid = $_GET['CommentID'];


    $query = "DELETE FROM comments WHERE CommentID = ?";
    $stmt = $con->prepare($query);
    $stmt->bind_param("i", $commentid);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to delete"]);
    }


?>

