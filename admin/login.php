
<?php
require_once '../config.php';
require_once '../auth.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Only POST method allowed');
}

$input = json_decode(file_get_contents('php://input'), true);

validateInput($input, ['email', 'password']);

try {
    $stmt = $pdo->prepare("SELECT id, email, password FROM admin_users WHERE email = ?");
    $stmt->execute([$input['email']]);
    $admin = $stmt->fetch();
    
    if (!$admin || !password_verify($input['password'], $admin['password'])) {
        sendError('Invalid credentials', 401);
    }
    
    // Generate new token
    $token = generateToken();
    
    // Update token in database
    $stmt = $pdo->prepare("UPDATE admin_users SET token = ? WHERE id = ?");
    $stmt->execute([$token, $admin['id']]);
    
    sendResponse([
        'success' => true,
        'message' => 'Login successful',
        'token' => $token,
        'admin' => [
            'id' => $admin['id'],
            'email' => $admin['email']
        ]
    ]);
    
} catch (Exception $e) {
    sendError('Login failed');
}
?>
