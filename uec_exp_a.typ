// フォント名
#let font_gothic = "Hiragino Kaku Gothic Pro"
#let font_serif = "YuMincho"


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

  // 表示
  content
}



// タイトルの表示
#let title(font_size: 12pt, content) = {
  // 中央寄せする
  set align(center)
  set text(size: font_size, font: font_gothic, weight: "regular")

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