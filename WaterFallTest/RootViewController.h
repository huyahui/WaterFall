//
//  RootViewController.h
//  WaterFallTest
//


#import <UIKit/UIKit.h>
#import "UICollectionViewWaterfallLayout.h"
@interface RootViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterfallLayout>
@property (strong, nonatomic) UICollectionView *collectionView;

@end
