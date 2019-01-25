//
//  CourseCardView.m
//  TestDEMO
//
//  Created by 曾清林 on 2019/1/25.
//  Copyright © 2019 曾清林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "CourseCardView.h"
#import "CourseCardFlowLayout.h"
#import "UIView+Extension.h"
#import "CourseCardCell.h"

@interface CourseCardView()<UICollectionViewDelegate,UICollectionViewDataSource,CAAnimationDelegate>
    
    @end


@implementation CourseCardView
    
- (void)setModels:(NSArray *)models{
    _models = models;
    [self scrollToItem:0];
    if (models.count < 2) {
        self.collectionView.scrollEnabled = NO;
    }
}
    
- (instancetype)initWithFrame:(CGRect)frame
    {
        self = [super initWithFrame:frame];
        if (self) {
            self.collectionView = [self createCollectionView];
            [self addSubview:self.collectionView];
        }
        return self;
    }
    
- (UICollectionView *)createCollectionView{
    
    CourseCardFlowLayout *layout = [[CourseCardFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, FIT_SCREEN_WIDTH(107) * 2, 0, FIT_SCREEN_WIDTH(107) * 2);    layout.minimumLineSpacing = -FIT_SCREEN_WIDTH(40);
    
    layout.itemSize = CGSizeMake(FIT_SCREEN_WIDTH(107), FIT_SCREEN_HEIGHT(130));
    
    //    (width: FIT_SCREEN_WIDTH(107), height: FIT_SCREEN_HEIGHT(130))
    
    CGFloat xPadding = FIT_SCREEN_WIDTH(35);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(xPadding, FIT_SCREEN_HEIGHT((self.height-157)/2), SCREEN_WIDTH - xPadding * 2, FIT_SCREEN_HEIGHT(157)) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView setCollectionViewLayout:layout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"CourseCardCell" bundle:nil] forCellWithReuseIdentifier:@"CourseCardCell"];
    return collectionView;
}
    
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}
    
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CourseCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CourseCardCell" forIndexPath:indexPath];
    NSInteger index = indexPath.row;
    
    cell.imgView.backgroundColor = [UIColor greenColor];
    //[cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.models[index]]];
    cell.nameLabel.text = @"";
    return cell;
}
    
    
    
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    
    CGPoint pointInView = [self convertPoint:collectionView.center toView:collectionView];
    
    NSInteger centerIndex = [collectionView indexPathForItemAtPoint:pointInView].row?[collectionView indexPathForItemAtPoint:pointInView].row:0;
    
    if (index == centerIndex) { // 若点击的是中间位置的书，则选择完成
        CourseCardCell *cell = (CourseCardCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.models[index]]];
        cell.nameLabel.text = @"";
        
        CATransition *ca = [[CATransition alloc]init];
        ca.delegate = self;
        ca.type = @"pageCurl";
        ca.subtype = kCATransitionFromRight;
        ca.duration = 1;
        [ca setRemovedOnCompletion:NO];
        ca.fillMode = kCAFillModeRemoved;
        [cell.containerView.layer addAnimation:ca forKey:nil] ;
        
        self.selectedIndex = index;
        //selectedCourseClosure?(models[index])
        
    } else { // 若点击旁边的书，则让其滚动至中间位置
        [self scrollToItem:index];
        //print("点击下标：\(index)");
    }
}
    
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint pointInView = [self convertPoint:self.collectionView.center toView:self.collectionView];
    NSInteger centerIndex = [self.collectionView indexPathForItemAtPoint:pointInView].row?[self.collectionView indexPathForItemAtPoint:pointInView].row:0;
    //print("滚动至下标：\(index)")
}
    
    
    
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint pointInView = [self convertPoint:self.collectionView.center toView:self.collectionView];
    NSInteger index = [self.collectionView indexPathForItemAtPoint:pointInView].row?[self.collectionView indexPathForItemAtPoint:pointInView].row:0;
    
    
    CourseCardCell *cellj2 = (CourseCardCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index - 2 inSection:0]];
    
    if(cellj2){
        [self.collectionView bringSubviewToFront:cellj2];
    }
    
    CourseCardCell *cella2 = (CourseCardCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index + 2 inSection:0]];
    
    if(cella2){
        [self.collectionView bringSubviewToFront:cella2];
    }
    
    CourseCardCell *cellj1 = (CourseCardCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index - 1 inSection:0]];
    
    if(cellj1){
        [self.collectionView bringSubviewToFront:cellj1];
    }
    
    
    CourseCardCell *cella1 = (CourseCardCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index + 1 inSection:0]];
    
    if(cella1){
        [self.collectionView bringSubviewToFront:cella1];
    }
    
    CourseCardCell *cell0 = (CourseCardCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    if(cell0){
        [self.collectionView bringSubviewToFront:cell0];
    }
}
    
- (void)scrollToItem:(NSInteger)indext{
    NSInteger index = indext < self.models.count ? indext : 0;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}
    
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     - (void)drawRect:(CGRect)rect {
     // Drawing code
     }
     */
    
    @end
