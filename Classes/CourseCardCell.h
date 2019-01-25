//
//  CourseCardCell.h
//  TestDEMO
//
//  Created by 曾清林 on 2019/1/25.
//  Copyright © 2019 曾清林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseCardCell : UICollectionViewCell
    @property (weak, nonatomic) IBOutlet UIView *containerView;
    @property (weak, nonatomic) IBOutlet UIImageView *imgView;
    @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
    
@end
