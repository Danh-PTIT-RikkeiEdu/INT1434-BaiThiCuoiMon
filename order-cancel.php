<?php
require __DIR__ . '/includes/init.php';
require_login();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect('orders.php');
}

csrf_verify();

$orderId = (int) ($_POST['order_id'] ?? 0);
$returnUrl = $_POST['redirect'] ?? 'orders.php';

// Kiểm tra đơn hàng có tồn tại không
$stmt = $pdo->prepare('SELECT * FROM orders WHERE id = ?');
$stmt->execute([$orderId]);
$order = $stmt->fetch();

if (!$order) {
    set_flash('error', 'Đơn hàng không tồn tại.');
    redirect('orders.php');
}

// Chỉ chủ đơn hàng hoặc quản trị viên mới có quyền hủy
if ($order['user_id'] !== current_user()['id'] && !is_admin()) {
    set_flash('error', 'Bạn không có quyền hủy đơn hàng này.');
    redirect('orders.php');
}

// Chỉ hủy được khi đơn hàng đang ở trạng thái 'pending' (chờ xử lý)
if ($order['status'] !== 'pending') {
    set_flash('error', 'Chỉ có thể hủy đơn hàng đang ở trạng thái Chờ xử lý.');
    redirect($returnUrl);
}

try {
    $pdo->beginTransaction();

    // 1. Hoàn lại số lượng tồn kho cho các sản phẩm trong đơn hàng
    $stmtItems = $pdo->prepare('SELECT product_id, quantity FROM order_items WHERE order_id = ?');
    $stmtItems->execute([$orderId]);
    $items = $stmtItems->fetchAll();

    $restoreStock = $pdo->prepare('UPDATE products SET stock = stock + ? WHERE id = ?');
    foreach ($items as $item) {
        if (!empty($item['product_id'])) {
            $restoreStock->execute([$item['quantity'], $item['product_id']]);
        }
    }

    // 2. Cập nhật trạng thái đơn hàng sang 'cancelled'
    $updateStmt = $pdo->prepare("UPDATE orders SET status = 'cancelled' WHERE id = ?");
    $updateStmt->execute([$orderId]);

    $pdo->commit();
    set_flash('success', 'Đã hủy đơn hàng #' . $orderId . ' thành công.');
} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    set_flash('error', 'Có lỗi xảy ra khi hủy đơn hàng. Vui lòng thử lại.');
}

redirect($returnUrl);
