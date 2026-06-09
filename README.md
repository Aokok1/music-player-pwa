# 🎵 音乐播放器 PWA

纯前端音乐播放器，可安装到手机，支持离线。

## ✨ 功能
- 🔍 搜索 Jamendo 免费音乐
- 🎧 在线播放
- 💾 下载缓存（IndexedDB存储，关浏览器也能听）
- 📱 PWA安装（像原生App一样放桌面）
- 🏷️ 分类浏览：摇滚/流行/电子/爵士等
- 🌐 离线可用（Service Worker缓存）

## 🚀 使用方法

### 方法1：手机直接访问（推荐）

1. 把这3个文件上传到任意Web服务器：
   - `index.html`
   - `manifest.json`  
   - `sw.js`

2. 确保用 **HTTPS** 访问（PWA安装需要HTTPS）

3. 手机浏览器打开 → 会自动弹出「添加到主屏幕」

### 方法2：电脑本地测试

```bash
# Python启动（需要HTTPS可以用 ngrok）
cd E:\MusicPlayerPWA
python -m http.server 8080

# 然后用手机浏览器访问 http://你的电脑IP:8080
```

### 方法3：免费部署到GitHub Pages

1. 创建GitHub仓库
2. 上传3个文件
3. 开启GitHub Pages → 手机访问即可

## 📂 文件说明

| 文件 | 用途 |
|------|------|
| index.html | 主页面（包含全部UI和逻辑） |
| manifest.json | PWA配置文件 |
| sw.js | Service Worker（离线缓存） |

## 🎵 数据存储

- 下载的音乐存储在浏览器 **IndexedDB** 中
- 即使清浏览器缓存也不会丢失（除非清除站点数据）
- 每首歌约3-10MB

## ⚠️ 注意

- 需要HTTPS才能安装为PWA（GitHub Pages自动提供）
- Jamendo API免费，无需注册
