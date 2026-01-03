
<?php
require_once '../config.php';

if (!isset($_GET['slug'])) {
    sendError('Service slug is required');
}

$slug = $_GET['slug'];

try {
    // Get service details
    $stmt = $pdo->prepare("SELECT * FROM services WHERE slug = ? AND is_active = 1");
    $stmt->execute([$slug]);
    $service = $stmt->fetch();
    
    if (!$service) {
        sendError('Service not found', 404);
    }
    
    // Get benefits for this service
    $stmt = $pdo->prepare("SELECT * FROM benefits WHERE service_id = ? ORDER BY created_at");
    $stmt->execute([$service['id']]);
    $benefits = $stmt->fetchAll();
    
    $service['benefits'] = $benefits;
    
    sendResponse([
        'success' => true,
        'data' => $service
    ]);
    
} catch (Exception $e) {
    sendError('Failed to fetch service details');
}
?>
