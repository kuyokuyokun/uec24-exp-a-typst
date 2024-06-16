// 単位の表示に使う
#import "@preview/metro:0.2.0": *

// 自然なパターンの表示に使う
#import "@preview/modpattern:0.1.0": modpattern


// フォント名
#let font_gothic = ("Hiragino Kaku Gothic ProN", "Yu Gothic", "Noto Sans CJK JP")
#let font_serif = ("YuMincho", "Yu Mincho", "Noto Serif CJK JP")

// テンプレート本体
#let uec_exp_a(content) = {
  // 見出しのフォントはゴシック体
  let font_heading = font_gothic

  // 本文のフォントはセリフ体
  let font_body = font_serif

  // フォントサイズ
  let font_size = 10pt

  // 用紙サイズ
  let paper_type = "a4"

  // 本文のサイズ
  // 210mm, 297mm は A4 のサイズ
  let margin_x = ((210mm - 165mm) / 2)
  let margin_y = ((297mm - 225mm) / 2)

  // 字下げのサイズ
  let indent_size = 1em

  // フォント設定
  // 本文フォント
  set text(lang: "ja", font: font_body, size: font_size)
  
  // 見出しの設定
  set heading(numbering: "1.1")
  show heading: it => [
    #set text(
      font: font_heading, 
      size: font_size, 
      spacing: 1em, // 一文字分あける 
      weight: "regular", // 太字にしない
      
    )
    // 上下に余白を追加
    #pad(
      top: 0.75em,
      bottom: 0.75em,
    )[
        #if it.numbering != none {
          counter(heading).display(
              it.numbering
          )
        }
      #box(it.body)
    ]

    // 一時的な対処: https://zenn.dev/mkpoli/articles/34a5ea47468979
    #par(text(size: 0pt, ""))
  ]

  // 一字下げする
  set par(justify: true, first-line-indent: indent_size)

  // 表の設定
  set table(
    align: horizon,
    stroke: (x, y) => {
      if y == 0 {
        // 頭のセルのみtopとbottomの枠線を表示する
        (
          top: stroke(),
          bottom: stroke()
        )
      } else if y > 1 {
        // 3つ目以降のセルはtopの枠線の細さを0に上書きする
        // それによって、最後のセルのみbottomの枠線が表示される
        (
          top: 0pt,
          bottom: stroke()
        )
      }
    },
  )

  // ページ設定
  set page(
    paper: paper_type,
    margin: (
      x: margin_x,
      y: margin_y
    ),
    footer: context [
      #set align(center)
      #counter(page).display(
        "1",
      )
    ]
  )

  // 引用の設定
  set bibliography(
    title: text("参考文献"),
    style: "american-physics-society"
  )

  // 単位の表示設定
  metro-setup(
    per-mode: "symbol", 
    exponent-mode: "scientific",
  )

  // 表示
  content
}



// タイトルの表示
#let title(font_size: 12pt, content) = {
  // 中央寄せする
  set align(center)
  set text(size: font_size, font: font_gothic, weight: "bold")

  content

  // 左寄せに戻す
  set align(left)
}

// 説明文
#let description(content) = {
  // 中央寄せ
  set align(center)
  set text(size: 10pt, font: font_gothic, weight: "regular") 
  
  $content$

  // 左寄せに戻す
  set align(left)
}

// 表の表示
#let table_figure = (caption: figure.caption, columns: int, ..data) => {
  figure(
    table(
      columns: columns,
      ..data
    ), 
    // キャプションはうにつける
    caption: figure.caption(
      position: top, 
      caption,
    ),
  )
}

// 斜めの線のパターン
/// 右上に斜めの線を引くパターン
#let north_east_pattern = (gap: (5pt, 5pt)) => modpattern(gap)[
  #place(line(start: (0%, 100%), end: (100%, 0%)))
]

/// 右下に斜めの線を引くパターン
#let south_east_pattern = (gap: (5pt, 5pt)) => modpattern(gap)[
  #place(line(start: (0%, 0%), end: (100%, 100%)))
]