
<?php
require_once '../../config.php';
require_once '../../auth.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Only POST method allowed');
}

$admin = validateToken();
$input = json_decode(file_get_contents('php://input'), true);

// Hardcode author
$input['author'] = "Aacharya Kirtan Prasad Supkar";

validateInput($input, ['id', 'title', 'slug', 'excerpt', 'content']);

try {
    // Update featured_image and is_featured if provided
    $stmt = $pdo->prepare("
        UPDATE blogs 
        SET title = ?, slug = ?, excerpt = ?, content = ?, author = ?, featured_image = ?, is_published = ?, is_featured = ?, updated_at = NOW()
        WHERE id = ?
    ");
    
    $stmt->execute([
        $input['title'],
        $input['slug'],
        $input['excerpt'],
        $input['content'],
        $input['author'],
        $input['featured_image'] ?? null,
        $input['is_published'] ? 1 : 0,
        $input['is_featured'] ? 1 : 0,
        $input['id']
    ]);
    
    sendResponse([
        'success' => true,
        'message' => 'Blog post updated successfully'
    ]);
    
} catch (Exception $e) {
    sendError('Failed to update blog post: ' . $e->getMessage());
}
?>
