<?php
require __DIR__ . '/includes/init.php';
require_login();

// Chỉ lấy đơn của người đang đăng nhập
$stmt = $pdo->prepare(
    'SELECT id, total, status, created_at FROM orders WHERE user_id = ? ORDER BY id DESC'
);
$stmt->execute([current_user()['id']]);
$orders = $stmt->fetchAll();

$pageTitle = 'Đơn hàng của tôi';
require __DIR__ . '/includes/header.php';
?>
<h2>Đơn hàng của tôi</h2>

<?php if (!$orders): ?>
    <p>Bạn chưa có đơn hàng nào. <a href="<?= url('index.php') ?>">Xem sản phẩm</a></p>
<?php else: ?>
    <table>
        <thead>
            <tr>
                <th>Mã đơn</th>
                <th>Ngày đặt</th>
                <th>Tổng tiền</th>
                <th>Trạng thái</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($orders as $order): ?>
                <tr>
                    <td>#<?= $order['id'] ?></td>
                    <td><?= date('d/m/Y H:i', strtotime($order['created_at'])) ?></td>
                    <td><?= format_price($order['total']) ?></td>
                    <td><?= e(order_status_label($order['status'])) ?></td>
                    <td>
                        <a href="<?= url('order-detail.php?id=' . $order['id']) ?>" class="btn" style="padding: 4px 10px; font-size: 0.9rem;">Xem</a>
                        <?php if ($order['status'] === 'pending'): ?>
                            <form action="<?= url('order-cancel.php') ?>" method="post" class="inline-form"
                                  onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #<?= $order['id'] ?> không?');">
                                <?= csrf_field() ?>
                                <input type="hidden" name="order_id" value="<?= $order['id'] ?>">
                                <input type="hidden" name="redirect" value="orders.php">
                                <button type="submit" class="btn btn-danger" style="padding: 4px 10px; font-size: 0.9rem; margin-left: 4px;">Hủy đơn</button>
                            </form>
                        <?php endif; ?>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
<?php endif; ?>
<?php require __DIR__ . '/includes/footer.php'; ?>
