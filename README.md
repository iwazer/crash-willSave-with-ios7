cdqからCoreDataいモデルのwillSaveをオーバーライドして保存前に更新日を自動設定するなどの処理をするとRubyMotion3でiOS7の場合に違うフィールドに格納しようとして落ちます。

RubyMotion2ではiOS7でも落ちませんし、RubyMotion3でもiOS8では落ちません( ˘ω˘)

- [モデル](https://github.com/iwazer/crash-willSave-with-ios7/blob/master/app/models/foo.rb)
- [スキーマ](https://github.com/iwazer/crash-willSave-with-ios7/blob/master/schemas/0001_initial.rb)
- [問題の箇所](https://github.com/iwazer/crash-willSave-with-ios7/blob/master/app/app_delegate.rb#L8)
