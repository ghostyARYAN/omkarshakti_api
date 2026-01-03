
<?php
require_once '../config.php';
require_once '../auth.php';

$admin = validateToken();

try {
    $stmt = $pdo->prepare("SELECT * FROM contacts ORDER BY created_at DESC");
    $stmt->execute();
    $contacts = $stmt->fetchAll();
    
    sendResponse([
        'success' => true,
        'data' => $contacts
    ]);
    
} catch (Exception $e) {
    sendError('Failed to fetch contacts');
}
?>
