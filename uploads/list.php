<?php
require_once '../config.php';
require_once '../auth.php';

// Allow GET to list files
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    sendError('Only GET allowed');
}

$admin = validateToken();

$target = $_GET['target'] ?? null;
if (!$target) sendError('Target folder is required');

$allowed = ['blogmedia', 'servicemedia'];
if (!in_array($target, $allowed)) sendError('Invalid target folder');

$uploadsDir = rtrim(UPLOADS_DIR, '/') . '/' . $target;
if (!is_dir($uploadsDir)) {
    // Return empty list if dir doesn't exist
    sendResponse(['success' => true, 'data' => []]);
}

$files = array_values(array_filter(scandir($uploadsDir), function($f) use ($uploadsDir) {
    return is_file($uploadsDir . '/' . $f) && $f[0] !== '.';
}));

$baseUrl = defined('API_BASE_URL') ? rtrim(API_BASE_URL, '/') : '';
// Fallback to request-derived host if API_BASE_URL isn't configured
if (empty($baseUrl)) {
    $scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
    $host = $_SERVER['HTTP_HOST'] ?? '';
    $baseUrl = $scheme . '://' . $host;
}

$result = [];
foreach ($files as $f) {
    $fileUrl = $baseUrl . '/uploads/' . $target . '/' . $f;
    $result[] = [
        'filename' => $f,
        // full absolute URL for direct client usage
        'path' => $fileUrl,
        'url' => $fileUrl
    ];
}

sendResponse(['success' => true, 'data' => $result]);

?>
