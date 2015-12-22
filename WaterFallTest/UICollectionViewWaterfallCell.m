//
//  UICollectionViewWaterfallCell.m
//  WaterFallTest
//



#import "UICollectionViewWaterfallCell.h"

@implementation UICollectionViewWaterfallCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (EGOImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[EGOImageView alloc]init];
        _imageView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (void)layoutSubviews
{
    _imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

@end
