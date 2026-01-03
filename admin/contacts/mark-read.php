
<?php
require_once '../../config.php';
require_once '../../auth.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Only POST method allowed');
}

$admin = validateToken();
$input = json_decode(file_get_contents('php://input'), true);

validateInput($input, ['id']);

try {
    $stmt = $pdo->prepare("UPDATE contacts SET is_read = 1 WHERE id = ?");
    $stmt->execute([$input['id']]);
    
    sendResponse([
        'success' => true,
        'message' => 'Contact marked as read'
    ]);
    
} catch (Exception $e) {
    sendError('Failed to mark contact as read');
}
?>
