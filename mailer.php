
<?php
require_once 'config.php';

function sendEmail($to, $subject, $body, $isHTML = true) {
    // Basic PHP mail function - you can replace with PHPMailer for better functionality
    $headers = "MIME-Version: 1.0" . "\r\n";
    
    if ($isHTML) {
        $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
    }
    
    $headers .= 'From: noreply@omkarshaktikendra.com' . "\r\n";
    $headers .= 'Reply-To: pandit@omkarshaktikendra.com' . "\r\n";
    
    return mail($to, $subject, $body, $headers);
}

function sendContactNotification($data) {
    $subject = "New Contact Form Submission - " . $data['subject'];
    $body = "
    <h3>New Contact Form Submission</h3>
    <p><strong>Name:</strong> {$data['full_name']}</p>
    <p><strong>Email:</strong> {$data['email']}</p>
    <p><strong>Phone:</strong> {$data['phone']}</p>
    <p><strong>Subject:</strong> {$data['subject']}</p>
    <p><strong>Message:</strong></p>
    <p>{$data['message']}</p>
    <p><strong>Submitted at:</strong> " . date('Y-m-d H:i:s') . "</p>
    ";
    
    return sendEmail('pandit@omkarshaktikendra.com', $subject, $body);
}

function sendAppointmentNotification($data) {
    $subject = "New Appointment Booking";
    $body = "
    <h3>New Appointment Booking</h3>
    <p><strong>Name:</strong> {$data['full_name']}</p>
    <p><strong>Email:</strong> {$data['email']}</p>
    <p><strong>Phone:</strong> {$data['phone']}</p>
    <p><strong>Date:</strong> {$data['date']}</p>
    <p><strong>Time:</strong> {$data['time_slot']}</p>
    <p><strong>Service:</strong> {$data['service_title']}</p>
    <p><strong>Concerns:</strong></p>
    <p>{$data['concerns']}</p>
    <p><strong>Booked at:</strong> " . date('Y-m-d H:i:s') . "</p>
    ";
    
    return sendEmail('pandit@omkarshaktikendra.com', $subject, $body);
}
?>
