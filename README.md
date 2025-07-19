# 自作Rackサーバー

## 概要

Rackの動作原理を深く理解するために、HTTPサーバーとミドルウェアシステムを一から実装したものです。

### 実装機能

- **Rack仕様完全準拠**
  - 8つの環境変数実装 (REQUEST_METHOD, PATH_INFO, QUERY_STRING等)
  - IOオブジェクト対応 (rack.input, rack.errors)
  
- **ミドルウェアシステム**
  - LoggerMiddleware (アクセスログ + レスポンス時間計測)
  - ShowExceptionsMiddleware (エラーハンドリング)
  - StaticMiddleware (静的ファイル配信 + Content-Type判定)
  
- **config.ru対応**
  - use/runメソッド実装
  - rackupとの互換性

## サーバー起動方法

### 1. 自作サーバー (rack_server.rb)

```bash
# アプリ直接起動
ruby rack_server.rb app.rb

# config.ru経由
ruby rack_server.rb config.ru
```

### 2. 標準Rackサーバー (rackup)

```bash
# config.ru経由
rackup config.ru

# ポート指定
rackup -p 4000 config.ru
```

## 動作確認

```bash
# サーバー起動後
curl http://localhost:3000/hello
curl http://localhost:3000/style.css
curl http://localhost:3000/input
```

## ファイル構成

```
├── rack_server.rb           # 自作HTTPサーバー
├── app.rb                   # サンプルRackアプリ
├── config.ru                # Rack設定ファイル
├── *Middleware.rb           # 各種ミドルウェア
└── public/                  # 静的ファイル
    ├── style.css
    └── test.html
```
