<?php
// Kết nối cơ sở dữ liệu bằng PDO. Sau tệp này, biến $pdo dùng được ở mọi trang.

define('DB_HOST', 'localhost:3306');
define('DB_USER', 'root');
define('DB_PASS', '');

// Hỗ trợ tự động nhận diện cơ sở dữ liệu booksStory hoặc minishop
$pdo = null;
$connectedDb = null;
$possibleDatabases = ['books_story'];

foreach ($possibleDatabases as $dbName) {
    try {
        $pdo = new PDO(
            'mysql:host=' . DB_HOST . ';dbname=' . $dbName . ';charset=utf8mb4',
            DB_USER,
            DB_PASS,
            [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
            ]
        );
        $connectedDb = $dbName;
        break;
    } catch (PDOException $e) {
        // Tiếp tục thử database kế tiếp
    }
}

if ($pdo !== null) {
    define('DB_NAME', $connectedDb);
} else {
    http_response_code(500);
    if (defined('APP_DEBUG') && APP_DEBUG) {
        exit('Lỗi kết nối CSDL: Không thể kết nối tới cơ sở dữ liệu (đã thử: ' . implode(', ', $possibleDatabases) . '). Vui lòng kiểm tra MySQL trong XAMPP.');
    } else {
        exit('Hệ thống đang bận, vui lòng thử lại sau.');
    }
}
