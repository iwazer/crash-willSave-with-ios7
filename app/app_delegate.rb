class AppDelegate
  include CDQ

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    cdq.setup

    foo = Foo.create(name: "name1")
    cdq.save #<= Crash iOS7
    p foo

    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'crash-will-save-with-ios7'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    true
  end
end
