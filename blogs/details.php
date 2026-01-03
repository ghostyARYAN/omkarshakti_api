
<?php
require_once '../config.php';

if (!isset($_GET['slug'])) {
    sendError('Blog slug is required');
}

$slug = $_GET['slug'];

try {
    // Get blog details
    $stmt = $pdo->prepare("SELECT * FROM blogs WHERE slug = ? AND is_published = 1");
    $stmt->execute([$slug]);
    $blog = $stmt->fetch();
    
    if (!$blog) {
        sendError('Blog not found', 404);
    }
    
    // Get approved comments
    $stmt = $pdo->prepare("
        SELECT user_name, comment, created_at 
        FROM comments 
        WHERE blog_id = ? AND is_approved = 1 
        ORDER BY created_at DESC
    ");
    $stmt->execute([$blog['id']]);
    $comments = $stmt->fetchAll();
    
    $blog['comments'] = $comments;
    
    sendResponse([
        'success' => true,
        'data' => $blog
    ]);
    
} catch (Exception $e) {
    sendError('Failed to fetch blog details');
}
?>
