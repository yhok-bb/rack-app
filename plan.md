# Rackスペシャリストへの道

## 現在の実装レベル

✅ **理解できていること**
- Rackアプリの基本仕様 `call(env)` → `[status, headers, body]`
- HTTPリクエストの基本的な解析
- 環境変数の基本概念

⚠️ **Rackスペシャリストとして必要な理解**
- Rack仕様の完全理解と実装
- ミドルウェアの仕組みと実装
- 実際のRackエコシステムとの互換性

## Rackスペシャリストへの学習ステップ

### Step 1: Rack仕様の完全理解
- [ ] **Rack SPEC完全準拠**
  - 必須環境変数の完全実装
  - bodyの正しい実装（each可能、close可能）
  - ヘッダーの正しい実装
  - エラーハンドリングの仕様準拠
- [ ] **環境変数の深い理解**
  - CGI環境変数の完全実装
  - Rack独自環境変数の実装
  - セキュリティ関連の環境変数

### Step 2: ミドルウェアの完全理解
- [ ] **ミドルウェアパターンの実装**
  - 基本的なミドルウェアチェーン
  - 実際に使えるミドルウェアの作成
  - 有名ミドルウェアの動作理解
- [ ] **標準ミドルウェアの実装**
  - Rack::CommonLogger
  - Rack::ShowExceptions
  - Rack::Static
  - Rack::BodyParser

### Step 3: 実際のRackエコシステムとの互換性
- [ ] **Railsアプリでの動作確認**
  - 簡単なRailsアプリの起動
  - Action Packとの連携
  - セッション管理
- [ ] **Sinatraアプリでの動作確認**
  - 基本的なSinatraアプリの起動
  - ルーティングの動作確認
- [ ] **Rackベースのgemとの互換性**
  - Rack::Test での動作確認
  - 既存ミドルウェアとの連携

### Step 4: 高度なRack理解
- [ ] **Rack::Hijack の実装**
  - WebSocketライクな双方向通信
  - ストリーミングレスポンス
- [ ] **Rack::Builder の理解と実装**
  - config.ruファイルの完全対応
  - 複雑なミドルウェアスタックの構築
- [ ] **パフォーマンスの理解**
  - 既存サーバーとの比較
  - メモリ使用量の最適化
  - スループットの改善

### Step 5: Rackエコシステムへの貢献
- [ ] **独自ミドルウェアの開発**
  - 実用的なミドルウェアの作成
  - gemとしての公開
- [ ] **Rack仕様の深い理解**
  - 仕様の曖昧な部分の理解
  - 実装の違いの把握
- [ ] **コミュニティへの貢献**
  - 既存実装との違いの文書化
  - 学習リソースの作成

## 優先して学ぶべきRack概念

### 1. 環境変数の完全理解
```ruby
# 現在実装済み
env["REQUEST_METHOD"] # GET, POST, etc.
env["PATH_INFO"]      # /hello

# 必須実装
env["QUERY_STRING"]   # ?param=value
env["CONTENT_TYPE"]   # リクエストの Content-Type
env["CONTENT_LENGTH"] # リクエストボディの長さ
env["HTTP_*"]         # HTTPヘッダー
env["rack.input"]     # リクエストボディ
env["rack.errors"]    # エラー出力
```

### 2. ミドルウェアパターン
```ruby
class LoggingMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    puts "Request: #{env['REQUEST_METHOD']} #{env['PATH_INFO']}"
    @app.call(env)
  end
end
```

### 3. 正しいBodyの実装
```ruby
# 現在: 配列で返している（基本的には正しい）
["<h1>Hello</h1>"]

# より正確な実装
class Body
  def each
    yield "<h1>Hello</h1>"
  end
  
  def close
    # cleanup if needed
  end
end
```

## 1週間集中Rackスペシャリストプラン

### Day 1-2: Rack仕様完全準拠 (平日夜2-3時間) ✅ **完了**
**目標**: 現在の実装をRack仕様に完全準拠させる
- [x] 環境変数の完全実装
  - [x] `REQUEST_METHOD`, `PATH_INFO`, `QUERY_STRING`
  - [x] `SERVER_NAME`, `SERVER_PROTOCOL`
  - [x] `rack.input`, `rack.errors`, `rack.url_scheme`
- [x] HTTPリクエストパーサーの改善
  - [x] URI.parseを使ったPATH_INFOとQUERY_STRINGの分離
  - [x] プロトコルバージョンの正確な抽出
- [x] 基本的なテスト作成
  - [x] rack.inputの動作確認テスト

### Day 3-4: ミドルウェアの実装 (平日夜2-3時間) ✅ **完了**
**目標**: ミドルウェアパターンを完全理解
- [x] 基本的なミドルウェアチェーンの実装
  - [x] SimpleMiddleware で基本パターン理解
  - [x] ミドルウェアチェーンの入れ子構造理解
- [x] 実用的なミドルウェアを3つ作成
  - [x] LoggerMiddleware（アクセスログ + 処理時間計測）
  - [x] ShowExceptionsMiddleware（エラーハンドリング）
  - [x] StaticMiddleware（静的ファイル配信 + Content-Type判定）
- [x] config.ru対応
  - [x] use/run メソッドの実装
  - [x] ミドルウェアスタックの構築
  - [x] rackup との互換性確認

### Day 5-6: 実際のアプリでテスト (休日4-6時間)
**目標**: 実際のRackアプリで動作確認
- [ ] 簡単なSinatraアプリの起動
- [ ] 基本的なRailsアプリの起動
- [ ] 既存ミドルウェアとの連携確認
- [ ] パフォーマンステスト

### Day 7: まとめと発表準備 (休日3-4時間)
**目標**: 成果をまとめて発表可能な状態に
- [ ] コードの整理とドキュメント作成
- [ ] ブログ記事の作成
- [ ] 発表資料の作成
- [ ] デモの準備

## 学習リソース（厳選）

### 必読ドキュメント
- Rack SPEC (github.com/rack/rack/blob/main/SPEC.rdoc) - Day 1で読む
- PumaのRack実装部分 - Day 2で参考にする

### 実践的な学習方法
1. **毎日コミット**: 進捗を見える化
2. **小さく始める**: 一つずつ確実に実装
3. **実際に動かす**: 理論だけでなく実践重視

## 1週間後の到達目標

🎯 **1週間でRackスペシャリストに**
- ✅ Rack仕様に完全準拠したサーバー
- ✅ 基本的なミドルウェアを実装できる
- ✅ 実際のRackアプリを動作させられる
- ✅ 技術ブログで発表できるレベル

## 成功のポイント

- **集中**: 1週間はRackに集中
- **実践**: 必ず実際のアプリで動作確認
- **記録**: 学んだことをすぐに記録
- **完璧を求めない**: 80%の完成度で次に進む

---

## Step 1 総評

### やったこと
- Rack仕様書を読みながら必須環境変数を理解
- HTTPリクエストの解析方法を改善（URI.parseの活用）
- 環境変数を8個実装（REQUEST_METHOD, PATH_INFO, QUERY_STRING, SERVER_NAME, SERVER_PROTOCOL, rack.input, rack.errors, rack.url_scheme）
- rack.inputのテスト用エンドポイント作成で動作確認

### 学んだこと
- Rack仕様の環境変数の役割と設定方法
- IOオブジェクト（$stderr, StringIO）がなぜ必要かの理解
- 標準ライブラリ（URI.parse）を使う判断基準
- SCRIPT_NAMEとPATH_INFOの関係性
- 仕様書の読み方とエラーからの学習方法

### 感想
- 実際のRackサーバーと同じアプローチで実装できた
- 次のミドルウェア実装への準備ができた

---

## Step 3-4 総評

### やったこと
- ミドルウェアの基本パターン（initialize + call）を理解
- 3つの実用的なミドルウェアを実装（Logger、ShowExceptions、Static）
- ミドルウェアチェーンの入れ子構造を完全理解
- config.ruのuse/runメソッドを実装
- rackupとの互換性を確認
- 自作サーバーとrackupの違いを理解

### 学んだこと
- ミドルウェアパターンの設計思想（再利用性、組み合わせ自由）
- ミドルウェアチェーンの構築順序とreverse の必要性
- config.ruの魔法の仕組み（use で記録、run で構築）
- Content-Type判定やエラーハンドリングの実装方法
- 複数のRackサーバーが存在することの理解

### 感想
- 入れ子地獄から config.ru の美しさを実感
- ミドルウェアの組み合わせ自由度に驚いた
- 2つのRackサーバー（自作 + rackup）を持てた
- Rails 4年目でも知らなかったRackの深い部分を理解できた