
<?php
require_once '../../config.php';
require_once '../../auth.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Only POST method allowed');
}

$admin = validateToken();
$input = json_decode(file_get_contents('php://input'), true);

validateInput($input, ['id', 'status']);

try {
    $stmt = $pdo->prepare("UPDATE appointments SET status = ? WHERE id = ?");
    $stmt->execute([$input['status'], $input['id']]);
    
    sendResponse([
        'success' => true,
        'message' => 'Appointment status updated successfully'
    ]);
    
} catch (Exception $e) {
    sendError('Failed to update appointment status');
}
?>
