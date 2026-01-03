
<?php
require_once '../config.php';
require_once '../auth.php';

$admin = validateToken();

try {
    $stmt = $pdo->prepare("SELECT * FROM services ORDER BY created_at DESC");
    $stmt->execute();
    $services = $stmt->fetchAll();
    
    sendResponse([
        'success' => true,
        'data' => $services
    ]);
    
} catch (Exception $e) {
    sendError('Failed to fetch services');
}
?>
