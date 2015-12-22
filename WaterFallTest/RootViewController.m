//
//  RootViewController.m
//  WaterFallTest
//

#import "RootViewController.h"
#import "UICollectionViewWaterfallCell.h"
#import "DetailViewController.h"

#define CELL_WIDTH 145
#define CELL_IDENTIFIER @"WaterfallCell"

@interface RootViewController ()
@property (nonatomic, strong) NSMutableArray *cellHeights;
@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation RootViewController

#pragma mark - Accessors
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewWaterfallLayout *layout = [[UICollectionViewWaterfallLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.delegate = self;
        
//        UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor blackColor];
        [_collectionView registerClass:[UICollectionViewWaterfallCell class]
            forCellWithReuseIdentifier:CELL_IDENTIFIER];
    }
    return _collectionView;
}

//- (NSMutableArray *)cellHeights
//{
//    if (!_cellHeights) {
//        _cellHeights = [NSMutableArray arrayWithCapacity:CELL_COUNT];
//        for (NSInteger i = 0; i < CELL_COUNT; i++) {
//            _cellHeights[i] = @(arc4random()%100*2+100);
//        }
//    }
//    return _cellHeights;
//}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.collectionView];
    self.title = @"WaterFallFlow";
    
    _images = [[NSMutableArray alloc]initWithObjects:
               @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=319964baa964034f0fcdc5069bfb7831/060828381f30e924c2fb36564e086e061d95f77e.jpg",
               @"http://b.hiphotos.baidu.com/image/w%3D2048/sign=f8539502b119ebc4c0787199b61ecefc/6f061d950a7b0208fa96958660d9f2d3572cc87e.jpg",
               @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=fdaa6e1799504fc2a25fb705d1e5e611/d058ccbf6c81800acb5c6b11b33533fa828b4770.jpg",
               @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=a2abd2c080025aafd33279cbcfd5aa64/8601a18b87d6277fed97a6382a381f30e924fc2d.jpg",
               @"http://a.hiphotos.baidu.com/image/w%3D2048/sign=99df4a68b119ebc4c0787199b61ecefc/6f061d950a7b02089b1a4aec60d9f2d3562cc8e8.jpg",
               @"http://f.hiphotos.baidu.com/image/w%3D2048/sign=67cecb3b6f224f4a579974133dcf9152/3bf33a87e950352a136998155143fbf2b2118ba7.jpg",
               @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=319964baa964034f0fcdc5069bfb7831/060828381f30e924c2fb36564e086e061d95f77e.jpg",
               @"http://b.hiphotos.baidu.com/image/w%3D2048/sign=f8539502b119ebc4c0787199b61ecefc/6f061d950a7b0208fa96958660d9f2d3572cc87e.jpg",
               @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=fdaa6e1799504fc2a25fb705d1e5e611/d058ccbf6c81800acb5c6b11b33533fa828b4770.jpg",
               @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=a2abd2c080025aafd33279cbcfd5aa64/8601a18b87d6277fed97a6382a381f30e924fc2d.jpg",
               @"http://a.hiphotos.baidu.com/image/w%3D2048/sign=99df4a68b119ebc4c0787199b61ecefc/6f061d950a7b02089b1a4aec60d9f2d3562cc8e8.jpg",
               @"http://f.hiphotos.baidu.com/image/w%3D2048/sign=67cecb3b6f224f4a579974133dcf9152/3bf33a87e950352a136998155143fbf2b2118ba7.jpg",
               @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=319964baa964034f0fcdc5069bfb7831/060828381f30e924c2fb36564e086e061d95f77e.jpg",
               @"http://b.hiphotos.baidu.com/image/w%3D2048/sign=f8539502b119ebc4c0787199b61ecefc/6f061d950a7b0208fa96958660d9f2d3572cc87e.jpg",
               @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=fdaa6e1799504fc2a25fb705d1e5e611/d058ccbf6c81800acb5c6b11b33533fa828b4770.jpg",
               @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=a2abd2c080025aafd33279cbcfd5aa64/8601a18b87d6277fed97a6382a381f30e924fc2d.jpg",
               @"http://a.hiphotos.baidu.com/image/w%3D2048/sign=99df4a68b119ebc4c0787199b61ecefc/6f061d950a7b02089b1a4aec60d9f2d3562cc8e8.jpg",
               @"http://f.hiphotos.baidu.com/image/w%3D2048/sign=67cecb3b6f224f4a579974133dcf9152/3bf33a87e950352a136998155143fbf2b2118ba7.jpg",
               @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=319964baa964034f0fcdc5069bfb7831/060828381f30e924c2fb36564e086e061d95f77e.jpg",
               @"http://b.hiphotos.baidu.com/image/w%3D2048/sign=f8539502b119ebc4c0787199b61ecefc/6f061d950a7b0208fa96958660d9f2d3572cc87e.jpg",
               @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=fdaa6e1799504fc2a25fb705d1e5e611/d058ccbf6c81800acb5c6b11b33533fa828b4770.jpg",
               @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=a2abd2c080025aafd33279cbcfd5aa64/8601a18b87d6277fed97a6382a381f30e924fc2d.jpg",
               @"http://a.hiphotos.baidu.com/image/w%3D2048/sign=99df4a68b119ebc4c0787199b61ecefc/6f061d950a7b02089b1a4aec60d9f2d3562cc8e8.jpg",
               @"http://f.hiphotos.baidu.com/image/w%3D2048/sign=67cecb3b6f224f4a579974133dcf9152/3bf33a87e950352a136998155143fbf2b2118ba7.jpg",
               @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=319964baa964034f0fcdc5069bfb7831/060828381f30e924c2fb36564e086e061d95f77e.jpg",
               @"http://b.hiphotos.baidu.com/image/w%3D2048/sign=f8539502b119ebc4c0787199b61ecefc/6f061d950a7b0208fa96958660d9f2d3572cc87e.jpg",
               @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=fdaa6e1799504fc2a25fb705d1e5e611/d058ccbf6c81800acb5c6b11b33533fa828b4770.jpg",
               @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=a2abd2c080025aafd33279cbcfd5aa64/8601a18b87d6277fed97a6382a381f30e924fc2d.jpg",
               @"http://a.hiphotos.baidu.com/image/w%3D2048/sign=99df4a68b119ebc4c0787199b61ecefc/6f061d950a7b02089b1a4aec60d9f2d3562cc8e8.jpg",
               @"http://f.hiphotos.baidu.com/image/w%3D2048/sign=67cecb3b6f224f4a579974133dcf9152/3bf33a87e950352a136998155143fbf2b2118ba7.jpg",nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateLayout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation
                                            duration:duration];
    [self updateLayout];
}

- (void)updateLayout
{
    UICollectionViewWaterfallLayout *layout =
    (UICollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = (self.collectionView.bounds.size.width-layout.sectionInset.left-layout.sectionInset.right) / CELL_WIDTH;
    layout.itemWidth = CELL_WIDTH;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _images.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewWaterfallCell *cell =
    (UICollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    cell.imageView.imageURL = [NSURL URLWithString:[_images objectAtIndex:indexPath.row]];
//    cell.displayString = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"-------------%ld",indexPath.item);
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    detailVC.imageStr = (self.images)[indexPath.item];
}

#pragma mark - UICollectionViewWaterfallLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return arc4random() % 200 + 100;
}

@end
