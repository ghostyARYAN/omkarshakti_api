
<?php
require_once '../../config.php';
require_once '../../auth.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Only POST method allowed');
}

$admin = validateToken();
$input = json_decode(file_get_contents('php://input'), true);

validateInput($input, ['title', 'description', 'price', 'duration']);

try {
    $stmt = $pdo->prepare("
        INSERT INTO services (title, description, detailed_description, price, duration, is_active, slug) 
        VALUES (?, ?, ?, ?, ?, ?, ?)
    ");
    
    // Generate slug from title
    $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $input['title'])));
    
    $stmt->execute([
        $input['title'],
        $input['description'],
        $input['detailed_description'] ?? '',
        $input['price'],
        $input['duration'],
        $input['is_active'] ? 1 : 0,
        $slug
    ]);
    
    $serviceId = $pdo->lastInsertId();
    
    sendResponse([
        'success' => true,
        'message' => 'Service created successfully',
        'id' => $serviceId
    ]);
    
} catch (Exception $e) {
    sendError('Failed to create service: ' . $e->getMessage());
}
?>
