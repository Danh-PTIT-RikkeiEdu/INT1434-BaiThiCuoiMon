<?php
require __DIR__ . '/includes/init.php';

// Xóa thông tin đăng nhập và làm trống giỏ hàng
unset($_SESSION['user']);
unset($_SESSION['cart']);
$_SESSION['cart'] = [];
session_regenerate_id(true);

set_flash('success', 'Bạn đã đăng xuất.');
redirect('index.php');
