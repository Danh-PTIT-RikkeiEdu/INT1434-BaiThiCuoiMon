<?php
require __DIR__ . '/includes/init.php';
require_login(); 

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $current_password = $_POST['current_password'] ?? '';
    $new_password = $_POST['new_password'] ?? '';
    $confirm_password = $_POST['confirm_password'] ?? '';

    // Kiểm tra độ dài và 2 mật khẩu mới không khớp nhau
    if (mb_strlen($new_password) < 6) {
        $errors['new_password'] = 'Mật khẩu mới phải có ít nhất 6 ký tự.';
    } elseif ($new_password !== $confirm_password) {
        $errors['confirm_password'] = 'Nhập lại mật khẩu mới không khớp.';
    }

    // Vào csld ktra
    if (empty($errors)) {
        $user_id = $_SESSION['user']['id'];
        
        $stmt = $pdo->prepare("SELECT password_hash FROM users WHERE id = ?");
        $stmt->execute([$user_id]);
        $user = $stmt->fetch();

        // Hash mã nhập vào và so sánh với mã đã hash trong csld (hash = băm)
        if ($user && password_verify($current_password, $user['password_hash'])) {
            
            $new_hash = password_hash($new_password, PASSWORD_DEFAULT);
            $stmt_update = $pdo->prepare("UPDATE users SET password_hash = ? WHERE id = ?");
            $stmt_update->execute([$new_hash, $user_id]);

            set_flash('success', 'Đổi mật khẩu thành công!');
            redirect(url('index.php'));
            
        } else {
            $errors['current_password'] = 'Mật khẩu hiện tại không đúng.';
        }
    }
}

$page_title = 'Đổi mật khẩu';
require __DIR__ . '/includes/header.php';
?>

<main class="container">
    <h2>Đổi mật khẩu</h2>

    <form action="" method="post" class="form">
        <input type="hidden" name="csrf_token" value="<?= csrf_token() ?>">
        
        <p>
            <label for="current_password">Mật khẩu hiện tại</label><br>
            <input type="password" id="current_password" name="current_password" required>
            <span class="error"><?= e($errors['current_password'] ?? '') ?></span>
        </p>
        
        <p>
            <label for="new_password">Mật khẩu mới</label><br>
            <input type="password" id="new_password" name="new_password" required minlength="6">
            <span class="error"><?= e($errors['new_password'] ?? '') ?></span>
        </p>
        
        <p>
            <label for="confirm_password">Nhập lại mật khẩu mới</label><br>
            <input type="password" id="confirm_password" name="confirm_password" required minlength="6">
            <span class="error"><?= e($errors['confirm_password'] ?? '') ?></span>
        </p>
        
        <p>
            <button type="submit" class="btn btn-accent">Đổi mật khẩu</button>
        </p>
    </form>
</main>

<?php require __DIR__ . '/includes/footer.php'; ?>