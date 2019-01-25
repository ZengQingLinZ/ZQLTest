//
//  CourseCardView.h
//  TestDEMO
//
//  Created by 曾清林 on 2019/1/25.
//  Copyright © 2019 曾清林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseCardView : UIView
@property (strong,nonatomic) UICollectionView *collectionView;
@property (assign,nonatomic) NSInteger selectedIndex;
@property (strong,nonatomic) NSArray *models;
@end
