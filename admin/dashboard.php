<?php 
require __DIR__ . '/../includes/init.php'; 
require_admin(); 

// 1. Tính doanh thu với đơn đã hoàn tất 
$sql_revenue = "SELECT SUM(total) AS doanh_thu FROM orders WHERE status = 'completed'"; 
$stmt_revenue = $pdo->query($sql_revenue); 
$revenue = $stmt_revenue->fetchColumn(); 

// Trường hợp chưa có sản phẩm nào được bán 
if ($revenue == null) { 
    $revenue = 0; 
} 

// 2. Đếm dựa trên trạng thái đơn 
$sql_status = "SELECT status, COUNT(*) AS count FROM orders GROUP BY status"; 
$stmt_status = $pdo->query($sql_status); 
$order_stats = $stmt_status->fetchAll(); 

// 3. Lấy 5 sản phẩm có số lượng thấp nhất 
$sql_low_stock = "SELECT name, stock FROM products ORDER BY stock ASC LIMIT 5"; 
$stmt_low_stock = $pdo->query($sql_low_stock); 
$low_stock_products = $stmt_low_stock->fetchAll(); 

$page_title = "Tổng quan quản trị"; 
require __DIR__ . '/../includes/header.php'; 
?> 

<main class="container"> 
    <h2>Tổng quan quản trị</h2> 

    <!-- Doanh thu --> 
    <div> 
        <h3>Doanh thu (Các đơn hoàn tất)</h3> 
        <p class="price" style="font-size: 16px;"><?= format_price($revenue) ?></p> 
    </div> 

    <!-- Phần số đơn theo trạng thái --> 
    <div> 
        <h3>Số đơn theo trạng thái</h3> 
        <ul> 
            <?php foreach ($order_stats as $row): ?> 
                <li> 
                    Trạng thái <strong><?= e($row['status']) ?></strong> : <?= $row['count'] ?> đơn 
                </li> 
            <?php endforeach; ?> 
        </ul> 
    </div> 

    <!-- Phần sản phẩm sắp hết hàng --> 
    <h3>5 Sản phẩm sắp hết hàng</h3> 
    <table class="cart-table"> 
        <thead> 
            <tr> 
                <th>Tên sản phẩm</th> 
                <th>Tồn kho còn lại</th> 
            </tr> 
        </thead> 
        <tbody> 
            <?php foreach ($low_stock_products as $product): ?> 
                <tr> 
                    <td><?= e($product['name']) ?></td> 
                    <td><strong class="error"><?= e($product['stock']) ?></strong></td> 
                </tr> 
            <?php endforeach; ?> 
        </tbody> 
    </table> 
</main> 

<?php require __DIR__ . '/../includes/footer.php'; ?>