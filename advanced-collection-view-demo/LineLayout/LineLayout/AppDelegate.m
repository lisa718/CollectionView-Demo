

#import "AppDelegate.h"

#import "ViewController.h"
#import "LineLayout.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    LineLayout* lineLayout = [[LineLayout alloc] init];
//    UICollectionViewFlowLayout * lineLayout = [UICollectionViewFlowLayout new];
//    lineLayout.itemSize = CGSizeMake(40, 40);
//    lineLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    lineLayout.sectionInset = UIEdgeInsetsMake(100, 0.0, 100, 0.0);//上下边距
//    lineLayout.minimumLineSpacing = 50.0;//行间距
    self.viewController = [[ViewController alloc] initWithCollectionViewLayout:lineLayout];
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
