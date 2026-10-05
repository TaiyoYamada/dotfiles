---
name: study
description: 学習ノート（study-artifact リポジトリ、530 本超）を CLI で引く・書く。「前に調べた」「以前まとめた」「ノートにある」と言われたとき、また実装や調査で新しく分かったことを残したいときに使う。数学・最適化・量子計算・量子情報・人工知能・コンピュータ・ソフトウェア開発・研究手法が入っている。どのディレクトリからでも使える。
---

# 学習ノート (study)

`study` は、どのリポジトリで作業していても叩ける CLI。ノート本体は
`~/Developer/me/study-artifact/notes/` にあり、公開先は https://study-notes-3po.pages.dev。

**どのコマンドも `--json` を付けると機械可読な形で返る。読み取りは常に `--json` を使う。**

## 引く

```bash
study search <語> [<語>...] --json     # 語を並べると AND。まずこれ
study search <語> --tag <タグ> --json
study cat <slug> --json                # 本文を丸ごと読む
study list [階層] --json               # どんな分野があるか
```

`search` の結果には `slug` が入っている。本文が要るときは、その slug を `cat` に渡す。
`slug` は日本語で、`数学/線形代数/固有値・固有ベクトル` のような形をしている。

## 書く

```bash
study add "<タイトル>" --tag <タグ,タグ> --json          # notes/_inbox に入る
study add "<タイトル>" --in <階層> --tag <タグ> --json   # 階層を指定する
study append <slug> "<本文>" --json                      # 既にあるノートに足す
study append <slug> "<本文>" --section <見出し> --json
```

- **階層が分からなければ `--in` を付けない。** `notes/_inbox` に入り、公開はされない。
  適当な階層を当てずっぽうで指定するより、未整理のまま置くほうがよい。
- `add` の応答に `similar` が入る。**近いノートが既にあるなら、新しく立てずに
  `append` を使う。** 同じことを二度書かないため。
- 本文を長く書くなら標準入力から流す: `study add "題" --json < file.md`
- 呼び出し元が git リポジトリなら、`origin: owner/repo@branch` が自動で記録される。

## 整える

```bash
study done <slug> --json                 # status を 執筆済 にする
study move <元> <先> --json              # 移動と [[...]] の張り替えを同時に
study orphans [階層] --json              # 孤立したノートと、リンクを足すべき場所
```

## 本文の書き方

ノートは Markdown。次はこのサイト固有の記法なので、書くときは合わせる。

- ノート間リンクは `[[数学/線形代数/固有値・固有ベクトル|固有値]]`。**参照先が実在しないと
  ビルドが止まる。** slug は `study search` で確かめてから書く
- 数式は `$...$` と `$$...$$`（ビルド時に MathML になる）
- 注記は `> [!note] 見出し`（note / tip / important / warning / caution / todo / question）

## してはいけないこと

- **`study sync` を勝手に実行しない。** git push まで走り、CI を通って公開される。
  実行してよいか必ず人に尋ねる。
- `notes/` の Markdown を Prettier などで整形しない。本文は書いたとおりに保つ。
- ノートのファイルを直接 `mv` しない。リンクが切れる。`study move` を使う。

## 使いどころ

- 調べ物を始める前に `study search` を引く。既に自分でまとめている可能性がある
- 実装中に非自明なことが分かったら `study add` で残す。分類は後回しでよい
- 「あのとき調べた」と言われたら、記憶ではなく `study search` で確かめる
