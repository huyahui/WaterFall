//
//  RootViewController.m
//  WaterFallTest
//


#import <UIKit/UIKit.h>

@class UICollectionViewWaterfallLayout;
@protocol UICollectionViewDelegateWaterfallLayout <UICollectionViewDelegate>
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface UICollectionViewWaterfallLayout : UICollectionViewLayout
@property (nonatomic, weak) id<UICollectionViewDelegateWaterfallLayout> delegate;
@property (nonatomic, assign) NSUInteger columnCount; // 列数
@property (nonatomic, assign) CGFloat itemWidth; // item的宽度
@property (nonatomic, assign) UIEdgeInsets sectionInset; // 每个section的边框间距
@end
