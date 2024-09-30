<?php
session_start();
if (isset($_SESSION['username'])) {
    header("Location: index.php");
    exit();
}
include 'db.php';

$error_message = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $stmt = $conn->prepare("SELECT * FROM users WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        if (password_verify($password, $user['password'])) {
            $_SESSION['username'] = $username;
            header("Location: index.php");
            exit();
        } else {
            $error_message = "Invalid credentials.";
        }
    } else {
        $error_message = "Invalid credentials.";
    }
    $stmt->close();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="styles.css">
    <script src="notify.js" defer></script>
</head>
<body>
    <?php include 'nav.php'; ?> 
    <h2>Login</h2>

    <?php if ($error_message): ?>
        <div class="notification error">
            <?php echo $error_message; ?>
        </div>
    <?php endif; ?>

    <form action="" method="POST">
        <input type="text" name="username" required placeholder="Username">
        <input type="password" name="password" required placeholder="Password">
        <button type="submit">Login</button>
    </form>
    <p>Don't have an account? <a href="register.php">Register here</a></p>
</body>
</html>
