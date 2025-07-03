# 小説エディター　「ながら書き」

## サービス概要
音楽を聴きながら創作に没頭できる、小説執筆エディターです。

- 小説はクラウド（RailsアプリのDB）に保存・呼び出しができ、作品管理もスムーズ

## このサービスへの思い・作りたい理由
執筆中、私はよくBGMをかけながら物語の世界に没頭しようとします。でも現実には、調べたい用語が出てきたときにブラウザを切り替えたり、音楽の再生タブがどこかに消えたり、小説の保存ミスで消えてしまったりすることが多々ありました。

このサービスは、「一つの画面で創作を完結させたい」という切実な思いから生まれました。心を込めた文章がふとしたタイミングで失われると、自分の気持ちまで削られるような感覚になります。そんな「創作に集中したいのにできない」もどかしさをRailsを使って解消したいと考えました。

## ユーザー層について
- 小説・詩・エッセイなどを創作する趣味〜プロのライター
- 集中できる創作環境を求める人
- 執筆において気分転換や情報収集を自然に取り入れたい人

## サービスの利用イメージ
1. Railsアプリにログインし、作品を新規作成
2. 好きなBGMを画面内で再生しながら執筆開始
3. 入力内容はAjax経由で自動保存（Rails + Turbo）
4. 書きかけの作品はダッシュボードから呼び出して続きを執筆

→ ユーザーはページ移動や切り替えによるストレスなく創作に集中できます。

## ユーザーの獲得について
- 創作系SNS（X、pixiv、noteなど）へのプロモーション
- Ruby on Railsのコミュニティからフィードバックを受ける
- 無料プランを用意し、創作活動者に広く体験してもらう

## サービスの差別化ポイント・推しポイント
### 類似サービスとの違い
- 小説エディタ＋音楽プレイヤー＋検索をRailsで一画面に統合した設計は珍しい
- 単なる機能提供でなく、創作する人の気持ちに寄り添う体験設計が特徴

### 推しポイント
- YouTubeなどを背景音楽として活用できるRails×JS構成

## 機能候補
### MVPリリース時（最低限実装したい機能）
- 小説エディター（Turbo Frames + Stimulusを活用）
- 音楽再生機能（YouTube iframe埋め込み）
- 小説保存・呼び出し（Rails + PostgreSQL）

### 本リリース以降に実装したい機能
- ユーザー登録とログイン（Devise使用予定）
- 作品ごとのフォルダ・シリーズ・タグ管理
- 執筆進捗の可視化（ワード数、執筆時間）
- プレイリスト作成と保存（ユーザー単位で管理）

## 機能の実装方針予定
本サービスはRuby on Railsを使用して開発します。

### 技術スタック（予定）
- **フレームワーク**: Ruby on Rails（バージョン 7.x系）
- **言語**: Ruby 3.2系
- **データベース**: PostgreSQL
- **フロントエンド**: Turbo, Stimulus, JavaScript, HTML/CSS
- **認証・認可**: Devise, Omniauth
- **デプロイサーバー**: Render または Heroku
- **CI/CD**: GitHub Actions
- **その他使用予定Gem**:
    - Kaminari（ページネーション）
    - RSpec（テスト）
    - FactoryBot（テストデータ）
    - RuboCop（静的解析）
    - dotenv-rails（環境変数管理）
    - ActiveStorage（画像アップロード）
    - その他必要に応じて追加

今後、要件や開発状況に応じて技術スタックやGemは適宜見直します。

画面遷移図
https://www.figma.com/board/v4gZFkpuKrby5rZ4gY23VH/%E7%84%A1%E9%A1%8C?node-id=0-1&t=d1h1lQdpqAUuEqLC-1

## 開発環境のセットアップ
1. リポジトリのクローン
```bash
git clone https://github.com/maigo575/edimego.git
cd edimego
```

2. 環境変数の設定
```bash
cp .env.example .env
```

3. Dockerコンテナの起動
```bash
docker-compose up -d
```

4. データベースのセットアップ
```bash
docker-compose exec web rails db:create db:migrate
```

5. アプリケーションの起動
```bash
docker-compose exec web rails server -b '0.0.0.0'
```

## テストの実行
```bash
docker-compose exec web rails test
```

## デプロイ
```bash
kamal setup
kamal deploy
```

## ライセンス
MIT License

## 開発環境セットアップ手順（Docker利用）

1. リポジトリをクローン
   ```
   git clone <YOUR_REPO_URL>
   cd <YOUR_REPO_NAME>
   ```

2. Dockerイメージのビルド＆起動
   ```
   docker-compose build
   docker-compose up
   ```

3. 別ターミナルでDB作成＆マイグレーション
   ```
   docker-compose run web rails db:create db:migrate
   ```

4. ブラウザで http://localhost:3000 にアクセス

---

## Devise導入（初回のみ）

1. Gemfileに`devise`を追加し、`bundle install`
2. `docker-compose run web rails generate devise:install`
3. `docker-compose run web rails generate devise User`
4. 必要に応じてUserモデルにカラム追加・マイグレーション
5. `docker-compose run web rails db:migrate`

---

## 作品編集API（PATCH/PUT /works/:id）

### エンドポイント
- PATCH /works/:id
- Content-Type: application/json
- 認証: ログイン済みセッション（Cookie）

### リクエスト例（JavaScript/fetch）
```js
fetch('/works/1', {
  method: 'PATCH',
  headers: {
    'Content-Type': 'application/json',
    'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
  },
  body: JSON.stringify({ work: { title: "新しいタイトル", body: "本文" } })
})
.then(res => res.json())
.then(data => console.log(data));
```

### レスポンス例
#### 成功時
```json
{
  "status": "ok",
  "work": {
    "id": 1,
    "title": "新しいタイトル",
    "body": "本文",
    ...
  }
}
```

#### バリデーションエラー時
```json
{
  "status": "error",
  "errors": ["タイトルを入力してください", "本文は1000文字以内で入力してください"]
}
```

### バリデーション
- タイトル: 必須
- 本文: 任意（または最大文字数制限など、モデルに準拠）

### 認証・権限
- ログイン済みユーザーのみ利用可能
- 自分の作品のみ編集可能（他人の作品は404/権限エラー）

---
