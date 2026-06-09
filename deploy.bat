@echo off
chcp 65001 >nul
cd /d "E:\Claude code\project\music-player-pwa"

echo === 🎵 音乐播放器 - 部署到GitHub Pages ===
echo.

REM --- Step 0: Clean old git ---
if exist .git (
  rmdir /s /q .git
)

REM --- Step 1: Get token ---
if "%GITHUB_TOKEN%"=="" (
  echo 粘贴你的GitHub token (classic, 勾选repo权限):
  set /p GITHUB_TOKEN="> "
)
echo.

REM --- Step 2: Get repo name ---
set REPO_NAME=music-player-pwa
set GITHUB_USER=Aokok1

echo 仓库: %GITHUB_USER%/%REPO_NAME%
echo.

REM --- Step 3: Create repo via API ---
echo 创建GitHub仓库...
curl -s -X POST -H "Authorization: token %GITHUB_TOKEN%" ^
  "https://api.github.com/user/repos" ^
  -d "{\"name\":\"%REPO_NAME%\",\"description\":\"PWA music player - Jamendo API\",\"private\":false,\"auto_init\":false}" > nul 2>&1
echo 仓库创建完成

REM --- Step 4: Push ---
git init
git checkout -b main
git add index.html manifest.json sw.js README.md
git commit -m "Initial: PWA music player"
git remote add origin "https://%GITHUB_TOKEN%@github.com/%GITHUB_USER%/%REPO_NAME%.git"
git push -u origin main

echo.
echo === Step 5: 开启GitHub Pages ===
curl -s -X POST -H "Authorization: token %GITHUB_TOKEN%" ^
  -H "Accept: application/vnd.github+json" ^
  "https://api.github.com/repos/%GITHUB_USER%/%REPO_NAME%/pages" ^
  -d "{\"source\":{\"branch\":\"main\",\"path\":\"/\"}}" > nul 2>&1

echo.
echo ══════════════════════════════════════════
echo  ✅ 完成!
echo.
echo  手机访问:
echo  https://%GITHUB_USER%.github.io/%REPO_NAME%/
echo.
echo  等1-2分钟生效，然后:
echo  浏览器菜单 → "添加到主屏幕"
echo ══════════════════════════════════════════
pause
