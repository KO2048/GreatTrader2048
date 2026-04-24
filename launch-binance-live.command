#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
HOST="127.0.0.1"
PORT="8765"
URL="http://${HOST}:${PORT}/demo/binance-btc-live.html"
PID_FILE="/tmp/greattrader-binance-live.pid"
LOG_FILE="/tmp/greattrader-binance-live.log"

check_url() {
  curl -fsS --max-time 2 "$URL" >/dev/null 2>&1
}

cleanup_stale_pid() {
  if [[ ! -f "$PID_FILE" ]]; then
    return
  fi

  local pid
  pid="$(cat "$PID_FILE" 2>/dev/null || true)"
  if [[ -z "${pid}" ]] || ! kill -0 "$pid" 2>/dev/null; then
    rm -f "$PID_FILE"
  fi
}

echo "GreatTrader BTCUSDT 永续价格启动器"
echo "正在准备本地页面..."

if ! command -v python3 >/dev/null 2>&1; then
  echo "未找到 python3，无法启动本地服务。"
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "未找到 curl，无法检测本地服务状态。"
  exit 1
fi

if ! command -v open >/dev/null 2>&1; then
  echo "未找到 open 命令，无法自动打开浏览器。"
  exit 1
fi

cleanup_stale_pid

if check_url; then
  echo "检测到本地服务已可用，正在打开页面..."
  open "$URL"
  exit 0
fi

if lsof -nP -iTCP:"$PORT" -sTCP:LISTEN >/dev/null 2>&1; then
  echo "端口 $PORT 已被其他程序占用，且当前地址没有返回验证页。"
  echo "请关闭占用端口的程序后重试，或联系 Codex 更换端口。"
  exit 1
fi

cd "$ROOT_DIR"
nohup python3 "$ROOT_DIR/scripts/serve_local.py" --host "$HOST" --port "$PORT" >"$LOG_FILE" 2>&1 &
SERVER_PID="$!"
echo "$SERVER_PID" > "$PID_FILE"

for _ in {1..20}; do
  if check_url; then
    echo "本地服务已启动，正在打开页面..."
    open "$URL"
    exit 0
  fi
  sleep 0.5
done

echo "本地服务启动失败。"
echo "日志位置: $LOG_FILE"
if [[ -f "$LOG_FILE" ]]; then
  echo "最近日志:"
  tail -n 20 "$LOG_FILE"
fi
exit 1
