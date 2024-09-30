<?php
$host = 'localhost'; 
$user = 'khael'; // input  Your db username
$pass = 'test'; // input Your db password
$dbname = 'users'; // input Your db name

// Create connection
$conn = new mysqli($host, $user, $pass, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>

