<?php
require __DIR__ . '/includes/init.php';
require_login();

$id = (int) ($_GET['id'] ?? 0);

$stmt = $pdo->prepare('SELECT * FROM orders WHERE id = ?');
$stmt->execute([$id]);
$order = $stmt->fetch();

// Chỉ chủ đơn hàng hoặc quản trị viên được xem.
// Đơn không tồn tại và đơn của người khác đều trả về 404 như nhau.
if (!$order || ($order['user_id'] !== current_user()['id'] && !is_admin())) {
    http_response_code(404);
    $pageTitle = 'Không tìm thấy đơn hàng';
    require __DIR__ . '/includes/header.php';
    echo '<h2>Không tìm thấy đơn hàng</h2>';
    require __DIR__ . '/includes/footer.php';
    exit;
}

$stmt = $pdo->prepare(
    'SELECT product_name, price, quantity FROM order_items WHERE order_id = ? ORDER BY id'
);
$stmt->execute([$id]);
$items = $stmt->fetchAll();

$pageTitle = 'Đơn hàng #' . $order['id'];
require __DIR__ . '/includes/header.php';
?>
<h2>Đơn hàng #<?= $order['id'] ?></h2>

<table>
    <tbody>
        <tr>
            <th>Ngày đặt</th>
            <td><?= date('d/m/Y H:i', strtotime($order['created_at'])) ?></td>
        </tr>
        <tr>
            <th>Trạng thái</th>
            <td>
                <strong><?= e(order_status_label($order['status'])) ?></strong>
                <?php if ($order['status'] === 'pending'): ?>
                    <span style="color: #666; font-size: 0.9rem; margin-left: 8px;">(Đang chờ xử lý - Bạn có thể hủy đơn nếu muốn)</span>
                <?php endif; ?>
            </td>
        </tr>
        <tr>
            <th>Người nhận</th>
            <td><?= e($order['fullname']) ?> - <?= e($order['phone']) ?></td>
        </tr>
        <tr>
            <th>Địa chỉ</th>
            <td><?= e($order['address']) ?></td>
        </tr>
        <tr>
            <th>Ghi chú</th>
            <td><?= nl2br(e($order['note'])) ?></td>
        </tr>
    </tbody>
</table>

<h3>Sản phẩm</h3>
<table>
    <thead>
        <tr>
            <th>Sản phẩm</th>
            <th>Đơn giá</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($items as $item): ?>
            <tr>
                <td><?= e($item['product_name']) ?></td>
                <td><?= format_price($item['price']) ?></td>
                <td><?= $item['quantity'] ?></td>
                <td><?= format_price($item['price'] * $item['quantity']) ?></td>
            </tr>
        <?php endforeach; ?>
    </tbody>
    <tfoot>
        <tr>
            <th colspan="3">Tổng cộng</th>
            <th><?= format_price($order['total']) ?></th>
        </tr>
    </tfoot>
</table>

<p class="cart-actions">
    <a href="<?= url(is_admin() ? 'admin/orders.php' : 'orders.php') ?>" class="btn">&laquo; Danh sách đơn hàng</a>
    <?php if ($order['status'] === 'pending'): ?>
        <form action="<?= url('order-cancel.php') ?>" method="post" class="inline-form"
              onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #<?= $order['id'] ?> không?');">
            <?= csrf_field() ?>
            <input type="hidden" name="order_id" value="<?= $order['id'] ?>">
            <input type="hidden" name="redirect" value="order-detail.php?id=<?= $order['id'] ?>">
            <button type="submit" class="btn btn-danger">Hủy đơn hàng</button>
        </form>
    <?php endif; ?>
</p>
<?php require __DIR__ . '/includes/footer.php'; ?>
