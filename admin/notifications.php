<?php
require_once '../config.php';
require_once '../auth.php';

$admin = validateToken();

try {
    $stmt = $pdo->prepare("SELECT * FROM notifications ORDER BY created_at DESC");
    $stmt->execute();
    $items = $stmt->fetchAll();

    sendResponse([
        'success' => true,
        'data' => $items
    ]);

} catch (Exception $e) {
    sendError('Failed to fetch notifications');
}
?>
