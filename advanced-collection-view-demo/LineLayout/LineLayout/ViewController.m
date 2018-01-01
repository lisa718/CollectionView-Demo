
#import "ViewController.h"
#import "Cell.h"

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.collectionView.backgroundColor = [UIColor greenColor];
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"MY_CELL"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return 30;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.item];
    return cell;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"---------");
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 7) {
        return NO;
    }
    return YES;
}


@end

