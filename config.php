
<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json; charset=utf-8");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

// Database configuration
define('DB_HOST', 'localhost');
define('DB_NAME', 'u298766445_omkarshaktidb');
define('DB_USER', 'u298766445_omkarshaktidb');
define('DB_PASS', 'j^9IfmX?YEA');

// Local Development Configuration
// define('DB_HOST', 'localhost');
// define('DB_NAME', 'astrology_db');
// define('DB_USER', 'root');
// define('DB_PASS', '');

// JWT Secret (change this in production)
define('JWT_SECRET', 'your_secret_key_change_in_production');

// Canonical API base URL used to build absolute URLs for uploads/media.
// Set this to your public API host (no trailing slash).
define('API_BASE_URL', 'https://api.omkarshakti.com');

// Filesystem directory where uploaded media are stored (no trailing slash).
// The API may be served from the project root (i.e. __DIR__ is document root)
// or from an `api/` subfolder. Try common locations and pick the first
// existing one. If none exist yet, prefer `__DIR__/uploads` so uploads end up
// under the same document root as the API (matching URLs like /uploads/...).
// Prefer `public_html/uploads` when present (Hostinger typical layout), then
// prefer project-root `uploads/`, then `__DIR__/uploads`.
$candidatePublicHtml = realpath(__DIR__ . '/public_html/uploads'); // if public_html is sibling and api is root
$candidateRoot = realpath(__DIR__ . '/../uploads'); // if api/ sits inside project
$candidateDoc = realpath(__DIR__ . '/uploads');    // if api/ IS the document root
if ($candidatePublicHtml && is_dir($candidatePublicHtml)) {
    $uploadsDirResolved = $candidatePublicHtml;
} elseif ($candidateRoot && is_dir($candidateRoot)) {
    $uploadsDirResolved = $candidateRoot;
} elseif ($candidateDoc && is_dir($candidateDoc)) {
    $uploadsDirResolved = $candidateDoc;
} else {
    // Neither exists yet; default to the document-root uploads folder
    $uploadsDirResolved = __DIR__ . '/public_html/uploads';
}
define('UPLOADS_DIR', rtrim($uploadsDirResolved, '/'));

// Database connection
try {
    // Ensure the connection uses utf8mb4 so we can store and return Unicode (Hindi, emojis, etc.)
    $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4";
    $pdo = new PDO($dsn, DB_USER, DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        // Don't emulate prepares so native prepares are used where possible
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);
    // Ensure connection collation is utf8mb4
    $pdo->exec("SET NAMES 'utf8mb4' COLLATE 'utf8mb4_unicode_ci'");
    // Force database and critical tables to utf8mb4 so Hindi text isn't corrupted
    $pdo->exec("ALTER DATABASE " . DB_NAME . " CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
    $pdo->exec("ALTER TABLE blogs CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
    $pdo->exec("ALTER TABLE comments CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
    
    } catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection failed'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

// Helper functions
function sendResponse($data, $status = 200) {
    http_response_code($status);
    // Encode Unicode characters correctly (avoid returning escaped \uXXXX sequences)
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function sendError($message, $status = 400) {
    http_response_code($status);
    echo json_encode(['error' => $message], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function validateInput($data, $required_fields) {
    foreach ($required_fields as $field) {
        // Ensure the field exists. We accept numeric 0 and boolean false as
        // valid values. The previous implementation treated the string "0"
        // as empty which caused valid toggles to fail validation.
        if (!isset($data[$field])) {
            sendError("Field '$field' is required");
        }

        $value = $data[$field];
        if (is_string($value)) {
            if (trim($value) === '') {
                sendError("Field '$field' is required");
            }
        } elseif ($value === null) {
            sendError("Field '$field' is required");
        }
        // numeric 0 or boolean false are valid and will pass validation.
    }
}

function createSlug($text) {
    // Allow UTF-8 characters (Hindi etc) in slugs by using Unicode-aware regex
    $text = mb_strtolower($text, 'UTF-8');
    // Keep Unicode word characters and hyphens; strip only special symbols
    $text = preg_replace('/[^\p{L}\p{N}\s\-]/u', '', $text);
    $text = preg_replace('/[\s\-]+/', '-', $text);
    return trim($text, '-');
}
?>
