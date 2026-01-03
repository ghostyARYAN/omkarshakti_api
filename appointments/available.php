
<?php
require_once '../config.php';

if (!isset($_GET['date'])) {
    sendError('Date parameter is required');
}

$date = $_GET['date'];

try {
    $stmt = $pdo->prepare("SELECT time_slot FROM appointment_slots WHERE date = ? AND is_available = 1 ORDER BY time_slot");
    $stmt->execute([$date]);
    $slots = $stmt->fetchAll(PDO::FETCH_COLUMN);
    
    sendResponse([
        'success' => true,
        'data' => $slots
    ]);
    
} catch (Exception $e) {
    sendError('Failed to fetch available slots');
}
?>
