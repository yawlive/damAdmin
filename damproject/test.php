<?php
include("connect.php");
if (!isset($con)) {
    die("Error: \$con is not set.");
} else {
    echo "Connection is set.";
}

?>
