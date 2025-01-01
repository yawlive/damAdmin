<?php
header('Access-Control-Allow-Origin: *');  // Allow all domains
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');  // Allow methods
header('Access-Control-Allow-Headers: Content-Type');  // Allow headers


require("connect.php") ;
$data = [];
$sql="SELECT * FROM `restaurants`";
$result =$con->query($sql);
while($row =$result->fetch_assoc()){
    $data[]= $row ;
}
echo json_encode($data);
?>