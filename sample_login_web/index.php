<?php
session_start();
if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <?php include "nav_auth.php"; ?>
    <h2>Welcome, <?php echo $_SESSION['username']; ?>!</h2>
    <p>This is your home page.</p>
</body>
</html>
