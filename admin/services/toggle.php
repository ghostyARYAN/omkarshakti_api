
<?php
require_once '../../config.php';
require_once '../../auth.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Only POST method allowed');
}

$admin = validateToken();
$input = json_decode(file_get_contents('php://input'), true);

validateInput($input, ['id', 'is_active']);

try {
    $stmt = $pdo->prepare("UPDATE services SET is_active = ? WHERE id = ?");
    $stmt->execute([$input['is_active'], $input['id']]);
    
    sendResponse([
        'success' => true,
        'message' => 'Service status updated successfully'
    ]);
    
} catch (Exception $e) {
    sendError('Failed to update service status');
}
?>
