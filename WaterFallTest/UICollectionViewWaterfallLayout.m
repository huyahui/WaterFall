//
//  RootViewController.m
//  WaterFallTest



#import "UICollectionViewWaterfallLayout.h"

@interface UICollectionViewWaterfallLayout()
@property (nonatomic, assign) NSInteger itemCount; //item的个数
@property (nonatomic, assign) CGFloat interitemSpacing;  //每行每列的间隔
@property (nonatomic, strong) NSMutableArray *columnHeights;  // 每一列的总高度
@property (nonatomic, strong) NSMutableArray *itemAttributes;  // 每个item的attributes
@end

@implementation UICollectionViewWaterfallLayout

#pragma mark - Accessors
- (void)setColumnCount:(NSUInteger)columnCount
{
    if (_columnCount != columnCount) {
        _columnCount = columnCount;
        [self invalidateLayout];
    }
}

- (void)setItemWidth:(CGFloat)itemWidth
{
    if (_itemWidth != itemWidth) {
        _itemWidth = itemWidth;
        [self invalidateLayout];
    }
}

- (void)setSectionInset:(UIEdgeInsets)sectionInset
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_sectionInset, sectionInset)) {
        _sectionInset = sectionInset;
        [self invalidateLayout];
    }
}

#pragma mark - Init
- (void)commonInit
{
    _columnCount = 2;
    _itemWidth = 145.0f;
    _sectionInset = UIEdgeInsetsZero;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Life cycle
- (void)dealloc
{
    [_columnHeights removeAllObjects];
    _columnHeights = nil;

    [_itemAttributes removeAllObjects];
    _itemAttributes = nil;
}

#pragma mark - Methods to Override
- (void)prepareLayout
{
    [super prepareLayout];
    NSLog(@"fan test 5");
    //配置每个item的属性,添加属性数组中
    _itemCount = [[self collectionView] numberOfItemsInSection:0];

    NSAssert(_columnCount > 1, @"columnCount for UICollectionViewWaterfallLayout should be greater than 1.");
    CGFloat width = self.collectionView.frame.size.width - _sectionInset.left - _sectionInset.right; //设置总的宽度
    _interitemSpacing = floorf((width - _columnCount * _itemWidth) / (_columnCount - 1)); //设置item之间的间距
    _itemAttributes = [NSMutableArray arrayWithCapacity:_itemCount]; //设置每个item的属性
    _columnHeights = [NSMutableArray arrayWithCapacity:_columnCount]; //根据列数 配置_columnHeights 每列的高度
    
    for (NSInteger idx = 0; idx < _columnCount; idx++) {
        //存储每列距离上边界的高度值
        [_columnHeights addObject:@(_sectionInset.top)];
    }

    // Item will be put into shortest column.
    for (NSInteger idx = 0; idx < _itemCount; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        //获取item的高度
        CGFloat itemHeight = [self.delegate collectionView:self.collectionView
                                                    layout:self
                                  heightForItemAtIndexPath:indexPath];
        //获取最短的列的索引
        NSUInteger columnIndex = [self shortestColumnIndex];
        //获取x轴上的偏移量
        CGFloat xOffset = _sectionInset.left + (_itemWidth + _interitemSpacing) * columnIndex;
        //获取y轴上的偏移量
        CGFloat yOffset = [(_columnHeights[columnIndex]) floatValue];

        //针对于每个indexPath上的item配置属性
        UICollectionViewLayoutAttributes *attributes =
        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(xOffset, yOffset, self.itemWidth, itemHeight);
        
        [_itemAttributes addObject:attributes];
        _columnHeights[columnIndex] = @(yOffset + itemHeight + _interitemSpacing);
    }
    
}
//循环collectionView的大小
- (CGSize)collectionViewContentSize
{
    NSLog(@"fan test 4");
    if (self.itemCount == 0) {
        return CGSizeZero;
    }

    CGSize contentSize = self.collectionView.frame.size;
    //?
    NSUInteger columnIndex = [self longestColumnIndex];
    CGFloat height = [self.columnHeights[columnIndex] floatValue];
    contentSize.height = height - self.interitemSpacing + self.sectionInset.bottom;
    return contentSize;
}
//读取item的每个属性配置
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    return self.itemAttributes[path.item];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"fan test 3");
    return self.itemAttributes;
//    return [self.itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
//        //判断两个矩形区域是否交叉,是否重叠
//        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
//    }]];
}
//当collectionView的bounds发生改变时,是否需要重新计算item的大小
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

#pragma mark - Private Methods
// Find out shortest column.
- (NSUInteger)shortestColumnIndex
{
    NSLog(@"xxxxxxxxx test  = %@", self.columnHeights);
    __block NSUInteger index = 0;
    __block CGFloat shortestHeight = MAXFLOAT;

    [self.columnHeights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height < shortestHeight) {
            shortestHeight = height;
            index = idx;
        }
    }];
    return index;
}

// Find out longest column.
- (NSUInteger)longestColumnIndex
{
    NSLog(@"fan test 1");
     NSUInteger index = 0;
     CGFloat longestHeight = 0;

    for (int i = 0; i < self.columnHeights.count; i++) {
        CGFloat height = [self.columnHeights[i] floatValue];
        if (height > longestHeight) {
            longestHeight = height;
            index = i;
        }
    }

    return index;
}

@end
