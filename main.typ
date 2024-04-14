
// ←これで始まる行はコメントなのでPDFでは表示されない

// テンプレートの呼び出し
#import "./uec_exp_a.typ": uec_exp_a, title, description
#import "./logos.typ": Typst, LaTeX

// ロゴの置き換え
#show "LaTeX": name => LaTeX

// テンプレートを使う
#show: uec_exp_a


// タイトル
#title("レポートのためのテンプレート - Typst版")

// 名前など
#description(
"
電気通信大学 Ⅳ 類 Typstを使おうプログラム
2400123 電通太郎
2024 年 0 月 0 日作成
2024 年 1 月 32 日更新
"
)

// ここから本文

= 目的

長年 LaTeX @latex を用いたレポート執筆が主流であった。しかし、新たな組版システム #Typst の登場により LaTeX に代わる新たな選択肢の一つとなった。今回は、 #Typst を用いたレポートの例を示す。


= Typstの記法

LaTeXと同様に #Typst でもさまざまな表示が可能である。LaTeXでは非常に複雑な記法を用いるが、 #Typst は Markdown に似た比較的簡易的な記法で表記できる。LaTeXで見出しを表示するには ```tex \section{見出し}``` や ```tex \subsection{小見出し}``` で表すが、 #Typst ではそれぞれMarkdownのように `= 見出し` や ` == 小見出し` と表すことができる。この章の見出しでは `= Typstの記法` と表記しており、```typ #set heading(numbering: "1.1")``` と書くことで左側に勝手に番号を振ってくれる。他にもさまざまな記法が存在するが、詳細については多くの解説記事がインターネット上に存在するので、そちらを参照してほしい。


また、数式を表したい場合は```typ $x$``` のように記述すると $x$ と表示される。中に式を含めることも可能で、```typ $2 + 3 = 5$``` とすれば $2 + 3 = 5$ と表示される。一部の記号は ```typ $1 + 2 times 3$``` ($1 + 2 times 3$) のように、記号の名前で表す必要がある。

数式は行中に表示する代わりに複数行に分けて書くこともできる。例えば以下のように記述することで、

```typ
// これは数式の右側に (1) のスタイルで番号をつけるというの意味
#set math.equation(numbering: "(1)")

$ // $$ で囲むと数式表示モードになる
T = 2 pi sqrt(
  h/g  (1 + (2r^2) / (5h^2))
) times (1+ (theta^2) / 16 )
$
```

以下のように表示される。

// これは数式の右側に (1) のスタイルで番号をつけるよの意味
#set math.equation(numbering: "(1)")

$ // $$ で囲むと数式表示モードになる
T = 2 pi sqrt(
  h/g  (1 + (2r^2) / (5h^2))
) times (1+ (theta^2) / 16 )
$

途中で現れた ```typ sqrt``` は根号 (#underline[sq]uare #underline[r]oo#underline[t] から) を意味する記号だが、これの代わりにユニコードである ```typst √``` を用いることも可能である。```typ √4 = 2``` と記述すると、$√4 = 2$ と表示される。

このように、LaTeXと比較して記法や数式の記述方法も非常に簡単であることがわかると思う。記法の他にもメリットが存在するため、#Typst を使ってみたいと思った人のために紹介しよう。



= Typst のインストール
== macOS

macOS を使っているユーザーであれば、Homebrew @homebrew を用いてコマンド一つでインストールすることが可能である。

```bash
brew install typst
```

== Windows

Windows ユーザーも `winget` コマンドを使ってインストールができる。

```bash
winget install --id Typst.Typst
```

== VSCode 拡張機能

VSCode の拡張機能も存在し、これを利用することでより効率的に執筆を行うことができる。


// 引用の読み込み
#bibliography("citing.bib")
