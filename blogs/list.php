<?php
require_once '../config.php';

$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 10;
$offset = ($page - 1) * $limit;

try {
    // Get total count
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM blogs WHERE is_published = 1");
    $stmt->execute();
    $total = $stmt->fetchColumn();

    // Validate $limit and $offset before using them directly
    $limit = max(1, min($limit, 100));  // Prevent overly large limits
    $offset = max(0, $offset);          // Ensure non-negative

    // Now inject them directly into the query (safe since they're sanitized)
    $stmt = $pdo->prepare("
        SELECT id, title, slug, featured_image, author, excerpt, created_at, is_featured 
        FROM blogs 
        WHERE is_published = 1 
        ORDER BY is_featured DESC, created_at DESC 
        LIMIT $limit OFFSET $offset
    ");
    $stmt->execute();
    $blogs = $stmt->fetchAll(PDO::FETCH_ASSOC);

    sendResponse([
        'success' => true,
        'data' => $blogs,
        'pagination' => [
            'current_page' => $page,
            'total_pages' => ceil($total / $limit),
            'total_items' => $total,
            'per_page' => $limit
        ]
    ]);

} catch (Exception $e) {
    sendError('Failed to fetch blogs: ' . $e->getMessage());
}
?>
