-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 07, 2026 lúc 02:06 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `books_story`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Kỹ năng & Giao tiếp'),
(2, 'Văn học & Lịch sử kinh điển'),
(3, 'Triết học & Tâm lý - Tư tưởng'),
(4, 'Khoa học & Giáo dục');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(255) NOT NULL,
  `note` varchar(500) NOT NULL DEFAULT '',
  `total` int(10) UNSIGNED NOT NULL,
  `status` enum('pending','shipping','completed','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `fullname`, `phone`, `address`, `note`, `total`, `status`, `created_at`) VALUES
(1, 1, 'aa', '0123412341', 'ádfoasjnkdfopweq', '', 110000, 'pending', '2026-11-07 19:57:05'),
(2, 1, 'aa', '0123412341', 'qưerqwerwqerwq', '', 339000, 'completed', '2026-11-07 19:57:38'),
(3, 1, 'aa', '0123412341', 'ưqerwqerwqer', '', 348000, 'completed', '2026-11-07 19:57:51'),
(4, 3, 'bb', '0123412342', '23141234rwqr', '', 86000, 'shipping', '2026-11-07 19:58:43'),
(5, 3, 'bb', '0123412342', '123421342343214', '', 105000, 'shipping', '2026-11-07 19:58:55'),
(6, 3, 'bb', '0123412342', '2134123421341234', '', 145000, 'cancelled', '2026-11-07 19:59:09');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_items`
--

CREATE TABLE `order_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_name` varchar(200) NOT NULL,
  `price` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `product_name`, `price`, `quantity`) VALUES
(1, 1, 7, 'Nỗi Buồn Chiến Tranh', 110000, 1),
(2, 2, 5, 'Đồi Gió Hú', 115000, 1),
(3, 2, 6, 'Thép Đã Tôi Thế Đấy', 105000, 1),
(4, 2, 3, 'Thao Túng Tâm Lý', 119000, 1),
(5, 3, 12, 'Yêu (Being in Love)', 108000, 1),
(6, 3, 4, 'Nếu Biết Trăm Năm Là Hữu Hạn', 95000, 1),
(7, 3, 2, 'Đừng Bao Giờ Chia Đôi Lợi Ích Trong Mọi Cuộc Đàm Phán', 145000, 1),
(8, 4, 1, 'Đắc Nhân Tâm', 86000, 1),
(9, 5, 6, 'Thép Đã Tôi Thế Đấy', 105000, 1),
(10, 6, 2, 'Đừng Bao Giờ Chia Đôi Lợi Ích Trong Mọi Cuộc Đàm Phán', 145000, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(200) NOT NULL,
  `price` int(10) UNSIGNED NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) NOT NULL DEFAULT 'images/DacNhanTam.jpg',
  `stock` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `price`, `description`, `image`, `stock`, `created_at`) VALUES
(1, 1, 'Đắc Nhân Tâm', 86000, 'Tác phẩm kinh điển về nghệ thuật ứng xử, giao tiếp và thu phục lòng người của Dale Carnegie nhưng thật sự thì khó mà đọng lại gì và cũng khó có thể áp dụng được trong cuộc sống đời thường.', 'images/DacNhanTam.jpg', 24, '2026-11-07 19:50:27'),
(2, 1, 'Đừng Bao Giờ Chia Đôi Lợi Ích Trong Mọi Cuộc Đàm Phán', 145000, 'Kỹ năng thương thuyết đỉnh cao thực chiến từ cựu chuyên gia đàm phán con tin FBI Chris Voss mang đến 1 góc nhìn mới mẻ độc đáo và mở mang đầu óc.', 'images/DungBaoGioChiaDoiLoiIch.jpg', 17, '2026-11-07 19:50:27'),
(3, 1, 'Thao Túng Tâm Lý', 119000, 'Cẩm nang nhận diện các mối quan hệ độc hại, thức tỉnh và chữa lành những tổn thương tiềm ẩn.', 'images/ThaoTungTamLy.jpg', 14, '2026-11-07 19:50:27'),
(4, 1, 'Nếu Biết Trăm Năm Là Hữu Hạn', 95000, 'Những tản văn sâu sắc về chiêm nghiệm cuộc sống, gia đình và giá trị thực sự của sự trưởng thành. Giúp bạn trau chuốt văn chương của chính mình.', 'images/NeuBietTramNamLaHuuHan.jpg', 29, '2026-11-07 19:50:27'),
(5, 2, 'Đồi Gió Hú', 115000, 'Kiệt tác văn học kinh điển của Emily Bronte kể về câu chuyện tình yêu mãnh liệt đầy bi kịch trên đồng nội hoang vu. Mới đọc cảm giác hơi chán nhưng tầm tới cuối chương 3 bạn sẽ bị cuốn theo nó.', 'images/DoiGioHu.jpg', 11, '2026-11-07 19:50:27'),
(6, 2, 'Thép Đã Tôi Thế Đấy', 105000, 'Biểu tượng văn học về ý chí kiên định, lý tưởng sống cao đẹp và tinh thần vượt khó của thanh niên.', 'images/ThepDaToiTheDay.jpg', 18, '2026-11-07 19:50:27'),
(7, 2, 'Nỗi Buồn Chiến Tranh', 110000, 'Tiểu thuyết của nhà văn Bảo Ninh khắc họa góc nhìn nội tâm sâu sắc, bi tráng về hiện thực chiến tranh. Mặc dù cuốn sách gây rất nhiều tranh cãi.', 'images/NoiBuonChienTranh.jpg', 13, '2026-11-07 19:50:27'),
(8, 2, 'Sapiens: Lược Sử Loài Người', 189000, 'Khái quát toàn bộ tiến trình lịch sử, quá trình tiến hóa và biến đổi xã hội của loài người từ thời tiền sử.', 'images/LuocSuLoaiNguoi.jpg', 22, '2026-11-07 19:50:27'),
(9, 3, 'Đời Ong', 98000, 'Khảo luận triết học đoạt giải Nobel của Maurice Maeterlinck phân tích xã hội loài ong và ẩn dụ con người.', 'images/DoiOng.jpg', 16, '2026-11-07 19:50:27'),
(10, 3, 'Hiện Tượng Con Người', 165000, 'Công trình triết học và nhân học tiêu biểu của Teilhard de Chardin về vị trí con người trong vũ trụ.', 'images/HienTuongConNguoi.jpg', 10, '2026-11-07 19:50:27'),
(11, 3, 'Thiên Tài Bên Trái Kẻ Điên Bên Phải', 135000, 'Nếu bạn là người muốn có thêm góc nhìn khác với hiện tại thì cuốn sách này thật sự dành cho bạn. Và bạn cũng nên có 1 trí tưởng tượng cao.', 'images/ThienTaiBenPhaiKeDienBenTrai.jpg', 25, '2026-11-07 19:50:27'),
(12, 3, 'Yêu (Being in Love)', 108000, 'Tác phẩm chiêm nghiệm của Osho về tình yêu trong tỉnh thức, sự tự do và gắn kết bằng niềm tin.', 'images/Yeu.jpg', 16, '2026-11-07 19:50:27'),
(13, 4, 'Boya HSK', 200000, '', 'uploads/eb7c3b01d5e18ef3.jpg', 10, '2026-11-07 20:01:14');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(255) NOT NULL DEFAULT '',
  `role` enum('customer','admin') NOT NULL DEFAULT 'customer',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `password_hash`, `phone`, `address`, `role`, `created_at`) VALUES
(1, 'aa', 'a@a.a', '$2y$10$ghPiFI80LLcD1T4kbiGSluRw4Sg.jDmxLrhnwDEc9M8td1qqydsFu', '0123412341', '', 'customer', '2026-11-07 19:54:27'),
(2, 'admin', 'admin@a.a', '$2y$10$wXsOeyEvnnmHB58qvSTVrOrrJ/hMcuRu03xhT1.CwebA31NIlceNy', '0123412342', '', 'admin', '2026-11-07 19:54:58'),
(3, 'bb', 'b@b.b', '$2y$10$LlvneEJr5o0GQPXNtbvxYux6i4/kcR0rdBkIztx0d.sbnZjvFSXoi', '0123412342', '', 'customer', '2026-11-07 19:55:19');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
