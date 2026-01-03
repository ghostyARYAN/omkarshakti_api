
<?php
require_once '../config.php';
require_once '../auth.php';

$admin = validateToken();

try {
    // Get dashboard statistics
    $stats = [];
    
    // Total services
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM services WHERE is_active = 1");
    $stmt->execute();
    $stats['total_services'] = $stmt->fetchColumn();
    
    // Total appointments
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM appointments");
    $stmt->execute();
    $stats['total_appointments'] = $stmt->fetchColumn();
    
    // Pending appointments
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM appointments WHERE status = 'pending'");
    $stmt->execute();
    $stats['pending_appointments'] = $stmt->fetchColumn();
    
    // Total blogs
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM blogs WHERE is_published = 1");
    $stmt->execute();
    $stats['total_blogs'] = $stmt->fetchColumn();
    
    // Unread contacts
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM contacts WHERE is_read = 0");
    $stmt->execute();
    $stats['unread_contacts'] = $stmt->fetchColumn();
    
    // Recent appointments
    $stmt = $pdo->prepare("
        SELECT a.*, s.title as service_title 
        FROM appointments a 
        JOIN services s ON a.service_id = s.id 
        ORDER BY a.created_at DESC 
        LIMIT 5
    ");
    $stmt->execute();
    $recent_appointments = $stmt->fetchAll();
    
    // Recent contacts
    $stmt = $pdo->prepare("SELECT * FROM contacts ORDER BY created_at DESC LIMIT 5");
    $stmt->execute();
    $recent_contacts = $stmt->fetchAll();
    
    sendResponse([
        'success' => true,
        'data' => [
            'stats' => $stats,
            'recent_appointments' => $recent_appointments,
            'recent_contacts' => $recent_contacts
        ]
    ]);
    
} catch (Exception $e) {
    sendError('Failed to fetch dashboard data');
}
?>
