# architecture_app

https://codewithandrea.com/articles/flutter-project-structure/#feature-first-layers-inside-features

## CODE WITH ANDREAを参考にアーキテクチャを学ぶ

このアーキテクチャは4つの異なるレイヤーで構成されており、それぞれがアプリに必要なコンポーネントを含んでいる：

presentation：ウィジェット、ステート、コントローラー
application：サービス
domain：モデル
data：リポジトリ、データソース、DTO（データ転送オブジェクト）
もちろん、1ページのアプリを作るだけなら、すべてのファイルを1つのフォルダに入れて、それで終わりです。😎

しかし、ページを増やし、さまざまなデータモデルを扱うようになると、すべてのファイルを一貫性のある方法で整理するにはどうすればよいでしょうか？

実際には、フィーチャーファーストかレイヤーファーストのアプローチがよく使われます。

そこで、この2つの規約をさらに詳しく調べ、そのトレードオフについて学びましょう。

## Feature-first (layers inside features)

機能優先のアプローチでは、アプリに新しい機能を追加するたびに新しいフォルダを作成する必要があります。そしてそのフォルダーの中に、レイヤーそのものをサブフォルダーとして追加します。

```
‣ lib
  ‣ src
    ‣ features
      ‣ feature1
        ‣ presentation
        ‣ application
        ‣ domain
        ‣ data
      ‣ feature2
        ‣ presentation
        ‣ application
        ‣ domain
        ‣ data
```

あるフィーチャーに属するすべてのファイルを、レイヤーごとに簡単に見ることができるからだ。

レイヤーファーストアプローチと比較して、いくつかの利点があります：

新しいフィーチャーを追加したり、既存のフィーチャーを修正したりするときは、1つのフォルダに集中できる。
機能を削除したい場合、削除するフォルダは1つだけ（対応するテストフォルダを含めると2つ）。
つまり、機能優先のアプローチの圧勝ということになる！🙌

## フィーチャーファーストとは、UIのことではない！
UIに注目すると、機能をアプリの1ページや1画面と考えがちだ。

私自身、今度のFlutterコースでeコマースアプリを作るときにこの間違いを犯しました。

そして私が行き着いたのは、こんな感じのプロジェクト構造だった：

```
lib
  ‣ src
    ‣ features
      ‣ account
      ‣ admin
      ‣ checkout
      ‣ leave_review_page
      ‣ orders_list
      ‣ product_page
      ‣ products_list
      ‣ shopping_cart
      ‣ sign_in
```

上記の機能はすべて、eコマースアプリの実際の画面を表しています。

しかし、その中にプレゼンテーション、アプリケーション、ドメイン、データレイヤーを配置することになったとき、いくつかのモデルやリポジトリが複数のページ（product_pageやproduct_listなど）で共有されていたため、問題が発生した。

その結果、サービス、モデル、リポジトリ用にトップレベルのフォルダを作ることになった：

```
 lib
  ‣ src
    ‣ features
      ‣ account
      ‣ admin
      ‣ checkout
      ‣ leave_review_page
      ‣ orders_list
      ‣ product_page
      ‣ products_list
      ‣ shopping_cart
      ‣ sign_in
    ‣ models <-- should this go here?
    ‣ repositories <-- should this go here?
    ‣ services <-- should this go here?
```