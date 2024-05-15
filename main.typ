
// ←これで始まる行はコメントなのでPDFでは表示されない

// テンプレートの呼び出し
#import "./uec_exp_a.typ": uec_exp_a, title, description, table_figure
#import "./logos.typ": Typst, LaTeX

// 図表
#import "@preview/cetz:0.2.2"
// 単位
#import "@preview/metro:0.2.0": *

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

#figure()[
```typ
// これは数式の右側に (1) のスタイルで番号をつけるというの意味
#set math.equation(numbering: "(1)")

$ // $$ で囲むと数式表示モードになる
T = 2 pi sqrt(
  h/g  (1 + (2r^2) / (5h^2))
) times (1+ (theta^2) / 16 )
$
```
]

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

== 表の描画

テンプレートに付属している `table_figure` 関数を使うことで簡単に表を描画することができる。

#grid(
  columns: (1fr, 1fr),
  figure()[
  ```typst
  #table_figure(
    caption: [
      振子の長さと周期の関係
    ],
    columns: 2,
    table.header(
      $h#unit("/cm")$, $T#unit("/s")$,
    ),
    $78.0$, $1.5$,
    $50.0$, $1.2$,
    $36.0$, $1.1$,
  ) #label("振子の長さと周期の関係の表")
  ```
  ],
  [#table_figure(
    caption: [
      振子の長さと周期の関係
    ],
    columns: 2,
    table.header(
      $h#unit("/cm")$, $T#unit("/s")$,
    ),
    $78.0$, $1.5$,
    $50.0$, $1.2$,
    $36.0$, $1.1$,
  ) #label("振子の長さと周期の関係の表")]
)

== グラフの描画

`cetz` パッケージを使うことで、シンプルなグラフであれば #Typst 単体で描画することができる。少々複雑なコードになってしまうが、自由に描画できるのでプログラミング経験者にはおすすめだ。もちろん、画像ファイルを読み込むのでも全く問題ないだろう。具体的なコードについては、`main.typ` ファイルを参照されたい。

#let 点のデータ = csv("data/dummy_data.csv")
#let 傾き = 0.0388715

// 重力加速度のグラフ
#let gravity-graph = (
  name: str, 
  x-min: float, 
  x-max: float, 
  x-tick-step: float,
  y-min: float,
  y-max: float,
  y-tick-step: float,
  size-width: float,
  size-height: float,
  x-label: content,
  y-label: content,
  slope: float, // 傾き
  caption: content,
  data
) => [
  #figure(
    cetz.canvas({
      import cetz.plot
      import cetz.draw: *

      let draw-point(pos, text, color, anchor) = {
          circle(pos, radius: 0.1, fill: color, stroke: none)
          content((), block(inset: 0.3em)[#text], anchor: anchor)
      }

      // 上と右の目盛りは非表示
      set-style(
        top: (
          tick: (
            stroke: 0pt,
          ),
        ),
        right: (
          tick: (
            stroke: 0pt,
          ),
        )
      )
      
      plot.plot(
        size: (size-width, size-height), 
        x-min: x-min,
        x-max: x-max,
        y-min: y-min,
        y-max: y-max,
        x-tick-step: x-tick-step,
        y-tick-step: y-tick-step,
        x-label: x-label,
        y-label: y-label,
        {
          // 線のために配列を追加
          plot.add(
            (
              (0, 0), // start point
              (x-max, x-max * slope) // end point
            )
          )
        }
      )

      // 点のプロット
      for ar in data.map(ar => ar.map(v => float(v))) {
        let x = (ar.at(0) - x-min) / (x-max - x-min) * size-width
        let y = (ar.at(1) - y-min) / (y-max - y-min) * size-height

        draw-point((x, y), "", blue, "east")
      }

    }),
    caption: caption,
  ) #label(str(name))
]

#gravity-graph(
  name: "重力加速度のグラフ",
  x-min: 20.0,
  x-max: 80.0,
  x-tick-step: 10,
  y-min: 1.0,
  y-max: 3.5,
  y-tick-step: 0.5,
  size-width: 8,
  size-height: 5,
  x-label: $h#unit("/cm")$,
  y-label: $overline(T)^2#unit("/s^2")$,
  caption: [
    振子の長さ $h$ と1周期の平均時間の二乗 $overline(T)^2$ の関係
  ],
  slope: 傾き,
  点のデータ
)

ちなみに、 #Typst では CSV からデータを読み込んで加工、表示することが可能であるため、Excel等から出力したデータをそのまま使うこともできる。@重力加速度のグラフ の例では、CSV を読み込んで使用している。

#figure(
  [
```typst
#let 点のデータ = csv("data/dummy_data.csv")
#let 傾き = 0.0388715

// 途中略

#gravity-graph(
  name: "重力加速度のグラフ",
  x-min: 20.0,
  x-max: 80.0,
  x-tick-step: 10,
  y-min: 1.0,
  y-max: 3.5,
  y-tick-step: 0.5,
  size-width: 8,
  size-height: 5,
  x-label: $h#unit("/cm")$,
  y-label: $overline(T)^2#unit("/s^2")$,
  caption: [
    振子の長さ $h$ と1周期の平均時間の二乗 $overline(T)^2$ の関係
  ],
  slope: 傾き,
  点のデータ
)
```
  ]
)

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
