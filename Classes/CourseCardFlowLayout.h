//
//  CourseCardFlowLayout.h
//  TestDEMO
//
//  Created by 曾清林 on 2019/1/25.
//  Copyright © 2019 曾清林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseCardFlowLayout : UICollectionViewFlowLayout
    @property (assign,nonatomic) CGFloat ActiveDistance;
    @property (assign,nonatomic) CGFloat ScaleFactor;
    @property (strong,nonatomic) UICollectionViewLayoutAttributes *attributes;
@end
