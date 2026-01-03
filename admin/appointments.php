
<?php
require_once '../config.php';
require_once '../auth.php';

$admin = validateToken();

try {
    $stmt = $pdo->prepare("
        SELECT a.*, s.title as service_title 
        FROM appointments a 
        LEFT JOIN services s ON a.service_id = s.id 
        ORDER BY a.created_at DESC
    ");
    $stmt->execute();
    $appointments = $stmt->fetchAll();
    
    sendResponse([
        'success' => true,
        'data' => $appointments
    ]);
    
} catch (Exception $e) {
    sendError('Failed to fetch appointments');
}
?>
