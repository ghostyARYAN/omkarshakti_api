
<?php
require_once '../config.php';
require_once '../mailer.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Only POST method allowed');
}

$input = json_decode(file_get_contents('php://input'), true);

validateInput($input, ['service_id', 'full_name', 'email', 'phone', 'date', 'time_slot']);

try {
    // Check if the slot is available
    $stmt = $pdo->prepare("SELECT id FROM appointment_slots WHERE date = ? AND time_slot = ? AND is_available = 1");
    $stmt->execute([$input['date'], $input['time_slot']]);
    
    if (!$stmt->fetch()) {
        sendError('Selected time slot is not available');
    }
    
    // Check if service exists
    $stmt = $pdo->prepare("SELECT title FROM services WHERE id = ? AND is_active = 1");
    $stmt->execute([$input['service_id']]);
    $service = $stmt->fetch();
    
    if (!$service) {
        sendError('Invalid service selected');
    }
    
    // Book the appointment
    $stmt = $pdo->prepare("
        INSERT INTO appointments (service_id, full_name, email, phone, date, time_slot, concerns) 
        VALUES (?, ?, ?, ?, ?, ?, ?)
    ");
    
    $stmt->execute([
        $input['service_id'],
        $input['full_name'],
        $input['email'],
        $input['phone'],
        $input['date'],
        $input['time_slot'],
        $input['concerns'] ?? ''
    ]);
    
    $appointment_id = $pdo->lastInsertId();
    
    // Mark the slot as unavailable
    $stmt = $pdo->prepare("UPDATE appointment_slots SET is_available = 0 WHERE date = ? AND time_slot = ?");
    $stmt->execute([$input['date'], $input['time_slot']]);
    
    // Send notification email
    $emailData = array_merge($input, ['service_title' => $service['title']]);
    sendAppointmentNotification($emailData);
    
    // Create an in-app notification for admin dashboard
    try {
        $notifStmt = $pdo->prepare("INSERT INTO notifications (title, body, url) VALUES (?, ?, ?)");
        $title = 'New appointment from ' . ($input['full_name'] ?? 'Unknown');
        $body = sprintf("%s booked %s on %s at %s", ($input['full_name'] ?? ''), $service['title'], $input['date'], $input['time_slot']);
        // Optional admin URL to jump to appointment list/detail in admin UI
        $url = '/admin/appointments.php?id=' . $appointment_id;
        $notifStmt->execute([$title, $body, $url]);
    } catch (Exception $e) {
        // Don't fail booking if notification insert fails; just continue
    }
    
    sendResponse([
        'success' => true,
        'message' => 'Appointment booked successfully',
        'appointment_id' => $appointment_id
    ]);
    
} catch (Exception $e) {
    sendError('Failed to book appointment');
}
?>
