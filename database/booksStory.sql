-- BooksStory: cấu trúc bảng và dữ liệu mẫu
-- Chạy trong phpMyAdmin sau khi đã chọn cơ sở dữ liệu booksStory (hoặc minishop)

SET NAMES utf8mb4;

DROP TABLE IF EXISTS order_items, orders, products, categories, users;

CREATE TABLE categories (
    id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE products (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_id INT UNSIGNED NOT NULL,
    name        VARCHAR(200) NOT NULL,
    price       INT UNSIGNED NOT NULL,
    description TEXT,
    image       VARCHAR(255) NOT NULL DEFAULT 'images/DacNhanTam.jpg',
    stock       INT UNSIGNED NOT NULL DEFAULT 0,
    created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE users (
    id            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fullname      VARCHAR(100) NOT NULL,
    email         VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone         VARCHAR(15)  NOT NULL,
    address       VARCHAR(255) NOT NULL DEFAULT '',
    role          ENUM('customer', 'admin') NOT NULL DEFAULT 'customer',
    created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE orders (
    id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id    INT UNSIGNED NOT NULL,
    fullname   VARCHAR(100) NOT NULL,
    phone      VARCHAR(15)  NOT NULL,
    address    VARCHAR(255) NOT NULL,
    note       VARCHAR(500) NOT NULL DEFAULT '',
    total      INT UNSIGNED NOT NULL,
    status     ENUM('pending', 'shipping', 'completed', 'cancelled') NOT NULL DEFAULT 'pending',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE order_items (
    id           INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id     INT UNSIGNED NOT NULL,
    product_id   INT UNSIGNED NOT NULL,
    product_name VARCHAR(200) NOT NULL,
    price        INT UNSIGNED NOT NULL,
    quantity     INT UNSIGNED NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (id),
    FOREIGN KEY (product_id) REFERENCES products (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO categories (id, name) VALUES
    (1, 'Kỹ năng & Giao tiếp'),
    (2, 'Văn học & Lịch sử kinh điển'),
    (3, 'Triết học & Tâm lý - Tư tưởng'),
    (4, 'Khoa học & Giáo dục');

INSERT INTO products (category_id, name, price, description, image, stock) VALUES
    (1, 'Đắc Nhân Tâm', 86000,
     'Tác phẩm kinh điển về nghệ thuật ứng xử, giao tiếp và thu phục lòng người của Dale Carnegie nhưng thật sự thì khó mà đọng lại gì và cũng khó có thể áp dụng được trong cuộc sống đời thường.',
     'images/DacNhanTam.jpg', 25),
    (1, 'Đừng Bao Giờ Chia Đôi Lợi Ích Trong Mọi Cuộc Đàm Phán', 145000,
     'Kỹ năng thương thuyết đỉnh cao thực chiến từ cựu chuyên gia đàm phán con tin FBI Chris Voss mang đến 1 góc nhìn mới mẻ độc đáo và mở mang đầu óc.',
     'images/DungBaoGioChiaDoiLoiIch.jpg', 18),
    (1, 'Thao Túng Tâm Lý', 119000,
     'Cẩm nang nhận diện các mối quan hệ độc hại, thức tỉnh và chữa lành những tổn thương tiềm ẩn.',
     'images/ThaoTungTamLy.jpg', 15),
    (1, 'Nếu Biết Trăm Năm Là Hữu Hạn', 95000,
     'Những tản văn sâu sắc về chiêm nghiệm cuộc sống, gia đình và giá trị thực sự của sự trưởng thành. Giúp bạn trau chuốt văn chương của chính mình.',
     'images/NeuBietTramNamLaHuuHan.jpg', 30),

    (2, 'Đồi Gió Hú', 115000,
     'Kiệt tác văn học kinh điển của Emily Bronte kể về câu chuyện tình yêu mãnh liệt đầy bi kịch trên đồng nội hoang vu. Mới đọc cảm giác hơi chán nhưng tầm tới cuối chương 3 bạn sẽ bị cuốn theo nó.',
     'images/DoiGioHu.jpg', 12),
    (2, 'Thép Đã Tôi Thế Đấy', 105000,
     'Biểu tượng văn học về ý chí kiên định, lý tưởng sống cao đẹp và tinh thần vượt khó của thanh niên.',
     'images/ThepDaToiTheDay.jpg', 20),
    (2, 'Nỗi Buồn Chiến Tranh', 110000,
     'Tiểu thuyết của nhà văn Bảo Ninh khắc họa góc nhìn nội tâm sâu sắc, bi tráng về hiện thực chiến tranh. Mặc dù cuốn sách gây rất nhiều tranh cãi.',
     'images/NoiBuonChienTranh.jpg', 14),
    (2, 'Sapiens: Lược Sử Loài Người', 189000,
     'Khái quát toàn bộ tiến trình lịch sử, quá trình tiến hóa và biến đổi xã hội của loài người từ thời tiền sử.',
     'images/LuocSuLoaiNguoi.jpg', 22),

    (3, 'Đời Ong', 98000,
     'Khảo luận triết học đoạt giải Nobel của Maurice Maeterlinck phân tích xã hội loài ong và ẩn dụ con người.',
     'images/DoiOng.jpg', 16),
    (3, 'Hiện Tượng Con Người', 165000,
     'Công trình triết học và nhân học tiêu biểu của Teilhard de Chardin về vị trí con người trong vũ trụ.',
     'images/HienTuongConNguoi.jpg', 10),
    (3, 'Thiên Tài Bên Trái Kẻ Điên Bên Phải', 135000,
     'Nếu bạn là người muốn có thêm góc nhìn khác với hiện tại thì cuốn sách này thật sự dành cho bạn. Và bạn cũng nên có 1 trí tưởng tượng cao.',
     'images/ThienTaiBenPhaiKeDienBenTrai.jpg', 25),
    (3, 'Yêu (Being in Love)', 108000,
     'Tác phẩm chiêm nghiệm của Osho về tình yêu trong tỉnh thức, sự tự do và gắn kết bằng niềm tin.',
     'images/Yeu.jpg', 17);


