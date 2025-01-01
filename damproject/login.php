<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");
include("connect.php");
$email = $_POST['email'];
$Password = $_POST['password'];


$sql = $con->prepare("select * FROM users WHERE email = ? ");
$sql->bind_param("s", $email );
$sql->execute();
$result = $sql->get_result();

if ($result->num_rows > 0) {

    $user = $result->fetch_assoc();
    $storedhash =$user['password'];


    if (password_verify($Password ,$storedhash )) {
        
        unset($user['password']);

        echo json_encode(["status" => "success", "user" => $user]);

    }else {echo json_encode(["status" => "error" , "message" => "wrong password"]);}
       
} else {
    
    echo json_encode(["status" => "error", "message" => "Invalid email"]);
}

$con->close();
?>
