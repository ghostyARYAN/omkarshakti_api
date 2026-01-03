
<?php
require_once '../config.php';
require_once '../mailer.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Only POST method allowed');
}

$input = json_decode(file_get_contents('php://input'), true);

validateInput($input, ['full_name', 'email', 'subject', 'message']);

try {
    $stmt = $pdo->prepare("
        INSERT INTO contacts (full_name, email, phone, subject, message) 
        VALUES (?, ?, ?, ?, ?)
    ");
    
    $stmt->execute([
        $input['full_name'],
        $input['email'],
        $input['phone'] ?? '',
        $input['subject'],
        $input['message']
    ]);
    
    // Send notification email
    sendContactNotification($input);
    
    // Create an in-app notification for admin dashboard
    try {
        $contactId = $pdo->lastInsertId();
        $notifStmt = $pdo->prepare("INSERT INTO notifications (title, body, url) VALUES (?, ?, ?)");
        $title = 'New message from ' . ($input['full_name'] ?? 'Guest');
        $body = substr(($input['message'] ?? ''), 0, 200);
        $url = '/admin/contacts.php?id=' . $contactId;
        $notifStmt->execute([$title, $body, $url]);
    } catch (Exception $e) {
        // ignore notification failures
    }
    
    sendResponse([
        'success' => true,
        'message' => 'Your message has been sent successfully'
    ]);
    
} catch (Exception $e) {
    sendError('Failed to submit contact form');
}
?>
