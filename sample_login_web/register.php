<?php
include 'db.php';
session_start();

$success_message = '';
$error_message = '';

if (isset($_SESSION['username'])) {
    header("Location: index.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT); // Hash the password

    $stmt = $conn->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
    $stmt->bind_param("ss", $username, $password);
    
    if ($stmt->execute()) {
        $success_message = "Registration successful!";
    } else {
        $error_message = "Error: " . $stmt->error;
    }
    $stmt->close();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="styles.css">
    <script src="notify.js" defer></script>
</head>
<body>
<?php include 'nav.php'; ?>
    <h2>Register</h2>
    
    <?php if ($success_message): ?>
        <div class="notification success">
            <?php echo $success_message; ?>
        </div>
    <?php endif; ?>

    <?php if ($error_message): ?>
        <div class="notification error">
            <?php echo $error_message; ?>
        </div>
    <?php endif; ?>

    <form action="" method="POST">
        <input type="text" name="username" required placeholder="Username">
        <input type="password" name="password" required placeholder="Password">
        <button type="submit">Register</button>
    </form>
    <p>Already have an account? <a href="login.php">Login here</a></p>
</body>
</html>
