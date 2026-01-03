<?php
require_once '../config.php';
require_once '../auth.php';

// Only allow POST multipart uploads
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Only POST method allowed');
}

$admin = validateToken();

// target folder: expected 'blogmedia' or 'servicemedia'
$target = $_POST['target'] ?? $_GET['target'] ?? null;
if (!$target) sendError('Target folder is required');

$allowed = ['blogmedia', 'servicemedia'];
if (!in_array($target, $allowed)) sendError('Invalid target folder');

if (!isset($_FILES['file'])) {
    sendError('File is required');
}

// Use canonical uploads directory from config to avoid nested api/uploads/uploads paths
// Build the intended uploads directory and defensively normalize duplicate 'uploads' segments
$uploadsDir = rtrim(UPLOADS_DIR, '/') . '/' . $target;
// Defensive normalization: if the path accidentally contains repeated '/uploads/uploads', collapse them.
while (strpos($uploadsDir, '/uploads/uploads') !== false) {
    $uploadsDir = str_replace('/uploads/uploads', '/uploads', $uploadsDir);
}
// Resolve realpath when possible for clearer diagnostics (may return false if path doesn't exist yet)
$realUploadsDir = realpath($uploadsDir) ?: $uploadsDir;
if (!is_dir($uploadsDir)) {
    if (!mkdir($uploadsDir, 0755, true)) {
        sendError('Failed to create upload directory');
    }
}

$file = $_FILES['file'];
if ($file['error'] !== UPLOAD_ERR_OK) {
    sendError('File upload error code: ' . $file['error']);
}

$originalName = basename($file['name']);
$ext = pathinfo($originalName, PATHINFO_EXTENSION);
$safeBase = preg_replace('/[^a-z0-9\-_.]/i', '_', pathinfo($originalName, PATHINFO_FILENAME));
$newName = $safeBase . '_' . time() . '_' . bin2hex(random_bytes(4)) . ($ext ? '.' . $ext : '');
// Destination file path
$dest = rtrim($uploadsDir, '/') . '/' . $newName;

$moved = move_uploaded_file($file['tmp_name'], $dest);
if (!$moved) {
    // Provide debugging info to help identify path mismatches on host
    sendError('Failed to move uploaded file to destination: ' . $dest);
}

// Use configured canonical API base URL to build absolute file URL.
$baseUrl = defined('API_BASE_URL') ? rtrim(API_BASE_URL, '/') : '';
// Fallback to request-derived host if API_BASE_URL isn't configured (unlikely)
if (empty($baseUrl)) {
    $scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
    $host = $_SERVER['HTTP_HOST'] ?? '';
    $baseUrl = $scheme . '://' . $host;
}
$fileUrl = $baseUrl . '/uploads/' . $target . '/' . $newName;

sendResponse([
    'success' => true,
    // legacy clients may rely on 'path' - provide it as full URL as well
    'path' => $fileUrl,
    // explicit field for clarity
    'url' => $fileUrl,
    'filename' => $newName,
    // Diagnostics: where the file was written on disk
    'uploads_dir' => $realUploadsDir,
    'dest' => $dest,
]);

?>
