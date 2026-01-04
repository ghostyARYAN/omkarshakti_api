
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

validateInput($input, ['title', 'slug', 'excerpt', 'content']);

try {
    // featured_image and is_featured are optional
    // validateInput($input, ['title', 'slug', 'excerpt', 'content']); // Duplicate validation removed

    $stmt = $pdo->prepare("
        INSERT INTO blogs (title, slug, excerpt, content, author, featured_image, is_published, is_featured) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ");
    
    $stmt->execute([
        $input['title'],
        $input['slug'],
        $input['excerpt'],
        $input['content'],
        $input['author'],
        $input['featured_image'] ?? null,
        $input['is_published'] ? 1 : 0,
        $input['is_featured'] ? 1 : 0
    ]);
    
    $blogId = $pdo->lastInsertId();
    
    sendResponse([
        'success' => true,
        'message' => 'Blog post created successfully',
        'id' => $blogId
    ]);
    
} catch (Exception $e) {
    sendError('Failed to create blog post: ' . $e->getMessage());
}
?>
