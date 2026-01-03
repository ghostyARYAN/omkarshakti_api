
<?php
require_once '../config.php';

try {
    $stmt = $pdo->prepare("SELECT id, title, slug, description, icon, image, price, duration FROM services WHERE is_active = 1 ORDER BY created_at DESC");
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
