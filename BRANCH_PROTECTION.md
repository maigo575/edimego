# ブランチプロテクション設定ガイド

## 概要
GitHubリポジトリでブランチプロテクションを設定することで、CIが成功するまでマージを防ぐことができます。

## 設定手順

### 1. GitHubリポジトリの設定画面にアクセス
1. GitHubリポジトリのページに移動
2. 「Settings」タブをクリック
3. 左サイドバーの「Branches」をクリック

### 2. ブランチプロテクションルールの追加
1. 「Add rule」ボタンをクリック
2. 以下の設定を行う：

#### Branch name pattern
- `main` または `master` を入力（デフォルトブランチに合わせる）

#### Protect matching branches
以下のチェックボックスを有効にする：

- ✅ **Require a pull request before merging**
  - プルリクエスト必須
  - 「Require approvals」を1以上に設定（推奨）

- ✅ **Require status checks to pass before merging**
  - ステータスチェック必須
  - 「Require branches to be up to date before merging」もチェック
  - 検索ボックスで「test」と入力し、CIジョブを選択

- ✅ **Require conversation resolution before merging**
  - 会話の解決必須

- ✅ **Require signed commits**
  - 署名されたコミット必須（オプション）

- ✅ **Require linear history**
  - 線形履歴必須（オプション）

- ✅ **Include administrators**
  - 管理者も含める（推奨）

### 3. 設定の保存
「Create」ボタンをクリックして設定を保存

## 設定後の動作
- プルリクエストが作成されると、自動でCIが実行される
- CIが成功するまでマージボタンが無効化される
- 管理者でもCIが成功するまでマージできない（設定による）

## 注意事項
- この設定はGitHubリポジトリの設定で行う必要があります
- ローカルファイルでは設定できません
- 設定後は、すべてのマージがプルリクエスト経由で行われる必要があります
