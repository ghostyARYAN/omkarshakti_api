
<?php
require_once '../config.php';
require_once '../auth.php';

$admin = validateToken();

try {
    $stmt = $pdo->prepare("SELECT * FROM blogs ORDER BY created_at DESC");
    $stmt->execute();
    $blogs = $stmt->fetchAll();
    
    sendResponse([
        'success' => true,
        'data' => $blogs
    ]);
    
} catch (Exception $e) {
    sendError('Failed to fetch blog posts');
}
?>
