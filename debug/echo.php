<?php
// Development-only endpoint to echo request headers and body for debugging.
// DO NOT leave enabled in production.
require_once '../config.php';

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    // allow preflight
    sendResponse(['ok' => true]);
}

$headers = function_exists('getallheaders') ? getallheaders() : [];
$serverAuth = isset($_SERVER['HTTP_AUTHORIZATION']) ? $_SERVER['HTTP_AUTHORIZATION'] : null;
$redirectAuth = isset($_SERVER['REDIRECT_HTTP_AUTHORIZATION']) ? $_SERVER['REDIRECT_HTTP_AUTHORIZATION'] : null;
$raw = file_get_contents('php://input');

sendResponse([
    'success' => true,
    'message' => 'debug echo',
    'headers' => $headers,
    'server_http_authorization' => $serverAuth,
    'redirect_http_authorization' => $redirectAuth,
    'raw_body' => $raw,
    'server_vars' => [
        'HTTP_AUTHORIZATION' => $serverAuth,
        'REDIRECT_HTTP_AUTHORIZATION' => $redirectAuth,
    ],
]);

?>