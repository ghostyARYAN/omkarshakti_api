<?php
require_once '../config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Method not allowed', 405);
}

$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['id'])) {
    sendError('Blog ID is required');
}

$blogId = $data['id'];

try {
    // Increment likes_count
    $sql = "UPDATE blogs SET likes_count = likes_count + 1 WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([':id' => $blogId]);

    if ($stmt->rowCount() > 0) {
        // Fetch new count
        $stmt = $pdo->prepare("SELECT likes_count FROM blogs WHERE id = :id");
        $stmt->execute([':id' => $blogId]);
        $result = $stmt->fetch();
        
        sendResponse([
            'success' => true,
            'likes_count' => $result['likes_count']
        ]);
    } else {
        sendError('Blog not found');
    }

} catch (PDOException $e) {
    sendError('Database error: ' . $e->getMessage(), 500);
}
?>
