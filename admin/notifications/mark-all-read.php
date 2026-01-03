<?php
require_once '../../config.php';
require_once '../../auth.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Only POST method allowed');
}

$admin = validateToken();

try {
    $stmt = $pdo->prepare("UPDATE notifications SET is_read = 1 WHERE is_read = 0");
    $stmt->execute();

    sendResponse([
        'success' => true,
        'message' => 'All notifications marked as read'
    ]);

} catch (Exception $e) {
    sendError('Failed to mark all notifications as read');
}
?>
