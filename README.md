## 現象

cdqからCoreDataのモデルのwillSaveをオーバーライドして保存前に更新日を自動設定するなどの処理をするとRubyMotion3でiOS7の場合に違うフィールドに格納しようとして落ちます。

RubyMotion2ではiOS7でも落ちませんし、RubyMotion3でもiOS8では落ちません( ˘ω˘)

- [モデル](https://github.com/iwazer/crash-willSave-with-ios7/blob/master/app/models/foo.rb)
- [スキーマ](https://github.com/iwazer/crash-willSave-with-ios7/blob/master/schemas/0001_initial.rb)
- [問題の箇所](https://github.com/iwazer/crash-willSave-with-ios7/blob/master/app/app_delegate.rb#L8)

## 再現手順

```
git clone git@github.com:iwazer/crash-willSave-with-ios7.git
cd crash-willSave-with-ios7
bundle install
rake device_name="iPhone 5s"
```

これで、iPhone 5sでiOS 7.0で動く場合落ちます。（実機で再現するのもiPhone 5sのiOS 7.1でした）

再現手順書こうとして、新たな事実が分かりました。
`target=7.1`を指定してiPhone 4sで起動したら動きます。

## ログ

[クラッシュログ](https://github.com/iwazer/crash-willSave-with-ios7/blob/master/crash_log.txt)

### コンソール

```
> rake device_name="iPhone 5s"                                            master [f447ecc] modified
Generating Data Model crash-will-save-with-ios7
   Loading schemas/0001_initial.rb
   Writing resources/crash-will-save-with-ios7.xcdatamodeld/0001 initial.xcdatamodel/contents
     Build ./build/iPhoneSimulator-7.0-Development
     Build /Users/e-iwazawa/.rvm/gems/ruby-2.0.0-p598/gems/motion-yaml-1.4/lib/YAMLKit
     Build /Users/e-iwazawa/.rvm/gems/ruby-2.0.0-p598/gems/cdq-0.1.11/lib/../vendor/cdq/ext
      Link ./build/iPhoneSimulator-7.0-Development/crash-will-save-with-ios7.app/crash-will-save-with-ios7
   Compile ./resources/crash-will-save-with-ios7.xcdatamodeld
    Create ./build/iPhoneSimulator-7.0-Development/crash-will-save-with-ios7.app/Info.plist
      Copy ./resources/crash-will-save-with-ios7.momd
      Copy ./resources/crash-will-save-with-ios7.momd/0001 initial.mom
      Copy ./resources/crash-will-save-with-ios7.momd/0001 initial.omo
      Copy ./resources/crash-will-save-with-ios7.momd/VersionInfo.plist
    Create ./build/iPhoneSimulator-7.0-Development/crash-will-save-with-ios7.app.dSYM
  Simulate ./build/iPhoneSimulator-7.0-Development/crash-will-save-with-ios7.app
2015-01-09 19:07:59.793 crash-will-save-with-ios7[46833:80b] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Unacceptable type of value for attribute: property = "name"; desired type = NSString; given type = Time; value = 2015-01-09 10:07:59 +0000.'
*** First throw call stack:
(
	0   CoreFoundation                      0x000000010237a795 __exceptionPreprocess + 165
	1   libobjc.A.dylib                     0x00000001002b5991 objc_exception_throw + 43
	2   CoreData                            0x0000000101d6f25a _PFManagedObject_coerceValueForKeyWithDescription + 2666
	3   CoreData                            0x0000000101d74d7d _sharedIMPL_setPvfk_core + 93
	4   crash-will-save-with-ios7           0x000000010002c1ad __unnamed_288 + 125
	5   crash-will-save-with-ios7           0x000000010017c958 rb_vm_dispatch + 6280
	6   crash-will-save-with-ios7           0x000000010001ca73 vm_dispatch + 1347
	7   crash-will-save-with-ios7           0x0000000100061c5f rb_scope__willSave__ + 223
	8   crash-will-save-with-ios7           0x0000000100061c7d __unnamed_7 + 13
	9   CoreData                            0x0000000101d4943c -[NSManagedObjectContext(_NSInternalAdditions) _validateObjects:forOperation:error:exhaustive:forSave:] + 3516
	10  CoreData                            0x0000000101d48529 -[NSManagedObjectContext(_NSInternalAdditions) _validateChangesForSave:] + 137
	11  CoreData                            0x0000000101d482d0 -[NSManagedObjectContext(_NSInternalChangeProcessing) _prepareForPushChanges:] + 208
	12  CoreData                            0x0000000101d461c4 -[NSManagedObjectContext save:] + 260
	13  crash-will-save-with-ios7           0x000000010002e0f3 __unnamed_307 + 131
	14  crash-will-save-with-ios7           0x000000010017c958 rb_vm_dispatch + 6280
	15  crash-will-save-with-ios7           0x000000010001ca73 vm_dispatch + 1347
	16  crash-will-save-with-ios7           0x0000000100028361 rb_scope__save:__block__2 + 97
	17  crash-will-save-with-ios7           0x000000010017e050 _ZL13vm_block_evalP7RoxorVMP11rb_vm_blockP13objc_selectormiPKm + 1024
	18  crash-will-save-with-ios7           0x000000010017c7c2 rb_vm_dispatch + 5874
	19  crash-will-save-with-ios7           0x000000010001ca73 vm_dispatch + 1347
	20  crash-will-save-with-ios7           0x000000010002993b rb_scope__with_error_object:__ + 347
	21  crash-will-save-with-ios7           0x000000010017cd8c rb_vm_dispatch + 7356
	22  crash-will-save-with-ios7           0x000000010001ca73 vm_dispatch + 1347
	23  crash-will-save-with-ios7           0x000000010002827f rb_scope__save:__block__1 + 255
	24  crash-will-save-with-ios7           0x000000010017e050 _ZL13vm_block_evalP7RoxorVMP11rb_vm_blockP13objc_selectormiPKm + 1024
	25  crash-will-save-with-ios7           0x000000010002e27c __unnamed_368 + 44
	26  CoreData                            0x0000000101d64cdb developerSubmittedBlockToNSManagedObjectContextPerform + 107
	27  CoreData                            0x0000000101d64c24 -[NSManagedObjectContext performBlockAndWait:] + 132
	28  crash-will-save-with-ios7           0x000000010002e240 __unnamed_314 + 128
	29  crash-will-save-with-ios7           0x000000010017c958 rb_vm_dispatch + 6280
	30  crash-will-save-with-ios7           0x000000010001ca73 vm_dispatch + 1347
	31  crash-will-save-with-ios7           0x0000000100027a5f rb_scope__save:__block__ + 911
	32  crash-will-save-with-ios7           0x000000010017e050 _ZL13vm_block_evalP7RoxorVMP11rb_vm_blockP13objc_selectormiPKm + 1024
	33  crash-will-save-with-ios7           0x000000010017e3b0 rb_vm_yield_args + 64
	34  crash-will-save-with-ios7           0x000000010017177f rb_yield + 47
	35  crash-will-save-with-ios7           0x00000001000689e4 rary_each + 68
	36  crash-will-save-with-ios7           0x000000010017cd8c rb_vm_dispatch + 7356
	37  crash-will-save-with-ios7           0x000000010001ca73 vm_dispatch + 1347
	38  crash-will-save-with-ios7           0x000000010002767e rb_scope__save:__ + 510
	39  crash-will-save-with-ios7           0x000000010017cd8c rb_vm_dispatch + 7356
	40  crash-will-save-with-ios7           0x000000010001ca73 vm_dispatch + 1347
	41  crash-will-save-with-ios7           0x000000010003df0e rb_scope__save:__ + 174
	42  crash-will-save-with-ios7           0x000000010017cd8c rb_vm_dispatch + 7356
	43  crash-will-save-with-ios7           0x000000010001ca73 vm_dispatch + 1347
	44  crash-will-save-with-ios7           0x00000001000628c4 rb_scope__application:didFinishLaunchingWithOptions:__ + 596
	45  crash-will-save-with-ios7           0x0000000100062f4d __unnamed_8 + 61
	46  UIKit                               0x000000010072e95c -[UIApplication _handleDelegateCallbacksWithOptions:isSuspended:restoreState:] + 264
	47  UIKit                               0x000000010072f014 -[UIApplication _callInitializationDelegatesForURL:payload:suspended:] + 1269
	48  UIKit                               0x0000000100732be8 -[UIApplication _runWithURL:payload:launchOrientation:statusBarStyle:statusBarHidden:] + 660
	49  UIKit                               0x0000000100743aab -[UIApplication handleEvent:withNewEvent:] + 3092
	50  UIKit                               0x0000000100743f1e -[UIApplication sendEvent:] + 79
	51  UIKit                               0x00000001007342be _UIApplicationHandleEvent + 618
	52  GraphicsServices                    0x0000000104146bb6 _PurpleEventCallback + 762
	53  GraphicsServices                    0x000000010414667d PurpleEventCallback + 35
	54  CoreFoundation                      0x00000001022fc819 __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE1_PERFORM_FUNCTION__ + 41
	55  CoreFoundation                      0x00000001022fc5ee __CFRunLoopDoSource1 + 478
	56  CoreFoundation                      0x0000000102325ab3 __CFRunLoopRun + 1939
	57  CoreFoundation                      0x0000000102324f33 CFRunLoopRunSpecific + 467
	58  UIKit                               0x00000001007324bd -[UIApplication _run] + 609
	59  UIKit                               0x0000000100734043 UIApplicationMain + 1010
	60  crash-will-save-with-ios7           0x0000000100024515 main + 117
	61  libdyld.dylib                       0x00000001036bf5fd start + 1
)
libc++abi.dylib: terminating with uncaught exception of type NSException
(main)> 
================================================================================
The application terminated. A crash report file may have been generated by the
system, use `rake crashlog' to open it. Use `rake debug=1' to restart the app
in the debugger.
================================================================================
```

