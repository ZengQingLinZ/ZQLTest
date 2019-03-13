//
//  CourseCardFlowLayout.m
//  TestDEMO
//
//  Created by 曾清林 on 2019/1/25.
//  Copyright © 2019 曾清林. All rights reserved.
//

#import "CourseCardFlowLayout.h"

@implementation CourseCardFlowLayout
    
- (instancetype)init
    {
        self = [super init];
        if (self) {
            self.ActiveDistance = 400;
            self.ScaleFactor = 0.7;
        }
        return self;
    }
    
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    // 目标区域中包含的cell
    NSArray *attriArray = [super layoutAttributesForElementsInRect:targetRect];
    
    // collectionView落在屏幕中点的x坐标
    CGFloat horizontalCenterX = proposedContentOffset.x + (self.collectionView.bounds.size.width / 2.0);
    
    CGFloat offsetAdjustment = CGFLOAT_MAX;
    for (UICollectionViewLayoutAttributes *layoutAttributes in attriArray) {
        CGFloat itemHorizontalCenterX = layoutAttributes.center.x;
        // 找出离中心点最近的
        if(fabs(itemHorizontalCenterX-horizontalCenterX) < fabs(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenterX-horizontalCenterX;
        }
    }
    
    //返回collectionView最终停留的位置
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}
    
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
    
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for(UICollectionViewLayoutAttributes *attributes in array) {
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        CGFloat normalizedDistance = fabs(distance/self.ActiveDistance);
        CGFloat zoom = 1 - self.ScaleFactor * normalizedDistance;
        attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
        
       //attributes.frame = CGRectMake(attributes.frame.origin.x, fabs(distance * self.ScaleFactor), attributes.frame.size.width, attributes.frame.size.height);
    }
    return array;
}
    
    
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    // 滑动放大缩小  需要实时刷新layout
    return YES;
}
    
    
    // 防止报错 先复制attributes
- (nullable NSMutableArray<__kindof UICollectionViewLayoutAttributes *> *)getCopyOfAttributes:(NSArray<__kindof UICollectionViewLayoutAttributes *>*)attributes{
    NSMutableArray<UICollectionViewLayoutAttributes *> *arr = [[NSMutableArray<UICollectionViewLayoutAttributes *> alloc]init];
    //    self.attributes = attributes;
    if (attributes) {
        for(UICollectionViewLayoutAttributes *attribute in attributes) {
            [arr addObject:attribute.copy];
        }
        return arr;
    }
    return nil;
}
    @end
