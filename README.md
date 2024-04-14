# UEC2024 基礎科学実験A レポート用 Typst テンプレート

`uec_exp_a.typ` がテンプレートファイルなので、`main.typ` を参考に書いてください。めちゃくちゃ説明用のコメントを入れています。

```typ
#import "./uec_exp_a.typ": uec_exp_a, title, description

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

= 目的 // これは見出し

長年 LaTeX @latex を用いたレポート執筆が主流であった。しかし、新たな組版システム #Typst の登場により LaTeX に代わる新たな選択肢の一つとなった。今回は、 #Typst を用いたレポートの例を示す。
```



