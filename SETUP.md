# Setup Guide — README v2

## 📂 Cấu trúc file

Sau khi xong, repo `yoonjae26/yoonjae26` của bạn sẽ trông như sau:

```
yoonjae26/
├── README.md
├── assets/
│   ├── banner.svg          ← hero banner
│   └── now.svg              ← "what's on the bench" card
└── .github/
    ├── scripts/
    │   └── update-readme.js ← script cập nhật dynamic content
    └── workflows/
        └── update-readme.yml ← workflow chạy mỗi 24h
```

## 🚀 Cách deploy (3 bước)

### 1. Upload files

Trong repo `yoonjae26/yoonjae26`:

| File trong package này | → | Đường dẫn trong repo |
|---|---|---|
| `README.md` | → | `README.md` |
| `banner.svg` | → | `assets/banner.svg` |
| `now.svg` | → | `assets/now.svg` |
| `update-readme.yml` | → | `.github/workflows/update-readme.yml` |
| `update-readme.js` | → | `.github/scripts/update-readme.js` |

### 2. Bật Discussions

1. Vào repo → **Settings** → scroll xuống **Features** → tick **Discussions**
2. Trong tab Discussions, tạo 4 categories:
   - **Guestbook** (announcement type)
   - **Ideas** (open-ended discussion)
   - **Q&A** (question/answer)
   - **Hall of the Curious** (announcement) ← cho easter egg

### 3. Chạy workflow lần đầu

1. Vào tab **Actions** trong repo
2. Chọn workflow "Update README"
3. Click **Run workflow** → chờ ~30 giây
4. Section "The Archive" sẽ được điền tự động với 5 hoạt động gần nhất

Sau bước này, mỗi ngày 00:00 UTC workflow sẽ tự refresh.

## 🎨 Tuỳ chỉnh `now.svg`

File `assets/now.svg` là phần "What's on the bench this week". Để cập nhật:

1. Mở `assets/now.svg`
2. Tìm 3 cột: `READING` / `BUILDING` / `LISTENING`
3. Sửa 2 dòng text trong mỗi cột (line 1 + line 2 italic)
4. Commit — README sẽ tự cập nhật

Có thể bạn muốn update file này mỗi tuần để giữ profile "alive".

## 🥚 Easter egg

Trong section "🎮 Find the easter egg", hint nói "Count carefully" trong workshop. 

Đáp án ẩn trong project № 1 (Go2): câu **"───► 12 joints"** trong sơ đồ ASCII. Số **12** là key — quadruped Go2 thật sự có 12 joints (3 mỗi chân × 4 chân).

Người tìm ra sẽ open issue → bạn có thể tự tay welcome họ vào "Hall of the Curious" để tăng engagement.

## 🔧 Troubleshooting

**Banner không hiển thị?** → Kiểm tra `assets/banner.svg` đã được commit chưa. SVG load từ relative path (`./assets/banner.svg`), không phụ thuộc CDN nào nên không bao giờ 404.

**Workflow fail?** → Vào Actions → click run failed → đọc log. Thường do permissions: vào Settings → Actions → General → Workflow permissions → tick "Read and write".

**Muốn workflow chạy thường xuyên hơn?** → Sửa cron trong `.github/workflows/update-readme.yml`:
- `'0 */6 * * *'` = mỗi 6 giờ
- `'0 0,12 * * *'` = 2 lần/ngày
