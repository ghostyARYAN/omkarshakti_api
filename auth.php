
<?php
require_once 'config.php';

function validateToken() {
    $headers = getallheaders();
    
    if (!isset($headers['Authorization'])) {
        sendError('Authorization header missing', 401);
    }
    
    $auth_header = $headers['Authorization'];
    if (!preg_match('/Bearer\s+(.*)$/i', $auth_header, $matches)) {
        sendError('Invalid authorization format', 401);
    }
    
    $token = $matches[1];
    
    global $pdo;
    $stmt = $pdo->prepare("SELECT id, email FROM admin_users WHERE token = ?");
    $stmt->execute([$token]);
    $admin = $stmt->fetch();
    
    if (!$admin) {
        sendError('Invalid or expired token', 401);
    }
    
    return $admin;
}

function generateToken($length = 64) {
    return bin2hex(random_bytes($length / 2));
}
?>
