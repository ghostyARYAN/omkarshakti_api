
<?php
require_once '../../config.php';
require_once '../../auth.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Only POST method allowed');
}

$admin = validateToken();
$input = json_decode(file_get_contents('php://input'), true);

validateInput($input, ['id', 'is_published']);

try {
    $stmt = $pdo->prepare("UPDATE blogs SET is_published = ? WHERE id = ?");
    $stmt->execute([$input['is_published'], $input['id']]);
    
    sendResponse([
        'success' => true,
        'message' => 'Blog post status updated successfully'
    ]);
    
} catch (Exception $e) {
    sendError('Failed to update blog post status');
}
?>
