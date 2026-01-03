
<?php
require_once '../config.php';

if (!isset($_GET['slug'])) {
    sendError('Service slug is required');
}

$slug = $_GET['slug'];

try {
    // Get service ID from slug
    $stmt = $pdo->prepare("SELECT id FROM services WHERE slug = ? AND is_active = 1");
    $stmt->execute([$slug]);
    $service = $stmt->fetch();
    
    if (!$service) {
        sendError('Service not found', 404);
    }
    
    // Get benefits
    $stmt = $pdo->prepare("SELECT * FROM benefits WHERE service_id = ? ORDER BY created_at");
    $stmt->execute([$service['id']]);
    $benefits = $stmt->fetchAll();
    
    sendResponse([
        'success' => true,
        'data' => $benefits
    ]);
    
} catch (Exception $e) {
    sendError('Failed to fetch benefits');
}
?>
