
<?php
require_once '../../config.php';
require_once '../../auth.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Only POST method allowed');
}

$admin = validateToken();
$input = json_decode(file_get_contents('php://input'), true);

validateInput($input, ['id', 'title', 'description', 'price', 'duration']);

try {
    $stmt = $pdo->prepare("
        UPDATE services 
        SET title = ?, description = ?, detailed_description = ?, price = ?, duration = ?, is_active = ?
        WHERE id = ?
    ");
    
    $stmt->execute([
        $input['title'],
        $input['description'],
        $input['detailed_description'] ?? '',
        $input['price'],
        $input['duration'],
        $input['is_active'] ? 1 : 0,
        $input['id']
    ]);
    
    sendResponse([
        'success' => true,
        'message' => 'Service updated successfully'
    ]);
    
} catch (Exception $e) {
    sendError('Failed to update service: ' . $e->getMessage());
}
?>
