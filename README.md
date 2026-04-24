# GreatTrader

《大作手 / The Great Trader》MVP 单页交易原型仓库。

## 在线访问

- GitHub 仓库：`https://github.com/KO2048/GreatTrader2048`
- GitHub Pages：`https://ko2048.github.io/GreatTrader2048/`

Pages 根入口会跳转到当前主页面：

- [`demo/the-great-trader-mvp-v5.html`](./demo/the-great-trader-mvp-v5.html)

## 本地 BTCUSDT 永续验证

如果你要验证 Binance `BTCUSDT` 永续合约最新成交价，请直接双击：

- [`launch-binance-live.command`](./launch-binance-live.command)

推荐这样使用的原因：

- 启动器会自动开启本地 HTTP 服务
- 启动默认浏览器并打开验证页
- 页面优先使用 Binance `BTCUSDT` USDT 本位永续 WebSocket，失败时自动降级为永续 REST

不推荐直接用 `file://` 或 Codex IAB 预览这个验证页，因为这些环境可能会影响网络连接结果。

## 项目内容

- `demo/the-great-trader-mvp-v5.html`
  当前主 MVP 页面，已作为 GitHub Pages 正式入口目标
- `demo/binance-btc-live.html`
  BTCUSDT 永续最新成交价验证页
- `launch-binance-live.command`
  Mac 双击启动入口
- `scripts/serve_local.py`
  本地静态服务脚本
- `demo/the-great-trader (1)-backup-original.html`
  早期原始备份页
- `demo/the-great-trader-mvp-v3.html`
- `demo/the-great-trader-mvp-v4.html`
- `demo/the-great-trader-mvp-v5.html`
  最新迭代版本
- `PRD/`
  产品文档与交易系统 PRD

## 当前状态

- 本项目为纯静态 HTML/CSS/JavaScript 原型
- 默认单资产 BTC
- 使用 GitHub Pages 从 `main` 分支根目录发布
- 根目录 `index.html` 作为 Pages 入口页
- 本地验证 Binance `BTCUSDT` 永续最新成交价时，推荐使用 `launch-binance-live.command` 而不是 `file://` 直接打开
