

#import "LineLayout.h"


#define ITEM_SIZE 40

@implementation LineLayout

#define ACTIVE_DISTANCE 20
#define ZOOM_FACTOR 1

-(id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(20, 20.0, 100, 20.0);//上下边距
        self.minimumLineSpacing = 10.0;//行间
        self.minimumInteritemSpacing = 10;
    }
    return self;
}

//当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息
// 一般FlowLayout的话这里不需要重新计算，都是在bounds发生变化再重新计算，不然会有性能损耗，自定义布局一般都是返回YES
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//布局属性
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    //取父类的UICollectionViewLayoutAttributes
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    
    
    //可视rect
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;

    //设置item的缩放
    for (UICollectionViewLayoutAttributes* attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;//item到中心点的距离
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;//距离除以有效距离得到标准化距离
            //距离小于有效距离才生效
            if (ABS(distance) < ACTIVE_DISTANCE) {
                CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));//缩放率范围1~1.3,与标准距离负相关
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);//x,y轴方向变换
                attributes.zIndex = 1;
            }
        }
    }
    
    return array;
}

//对齐到网格
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //proposedContentOffset是没有对齐到网格时本来应该停下的位置

    //计算出实际中心位置
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);

    //取当前屏幕中的UICollectionViewLayoutAttributes
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];

    //对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }

    //返回调整好的point
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end
