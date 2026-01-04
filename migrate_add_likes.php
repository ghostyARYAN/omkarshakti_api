<?php
require_once 'config.php';

try {
    // Check if column exists
    $check = $pdo->query("SHOW COLUMNS FROM blogs LIKE 'likes_count'");
    if ($check->rowCount() == 0) {
        $sql = "ALTER TABLE blogs ADD COLUMN likes_count INT DEFAULT 0";
        $pdo->exec($sql);
        echo json_encode(['success' => true, 'message' => 'likes_count column added successfully']);
    } else {
        echo json_encode(['success' => true, 'message' => 'likes_count column already exists']);
    }
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
}
?>
