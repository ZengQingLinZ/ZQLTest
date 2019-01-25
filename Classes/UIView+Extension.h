//
//  ___FILENAME___
//  ___PROJECTNAME___
//  微微卿 制作
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___FULLUSERNAME___
//

/** 屏幕尺寸 */
// 屏幕宽度
#define SCREEN_HEIGHT UIScreen.mainScreen.bounds.size.height
// 屏幕高度
#define SCREEN_WIDTH UIScreen.mainScreen.bounds.size.width
// 自适应屏幕宽度
#define FIT_SCREEN_WIDTH(size) (size * SCREEN_WIDTH / 375.0)
// 自适应屏幕高度
#define FIT_SCREEN_HEIGHT(size) (size * SCREEN_HEIGHT / 667.0)

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@end
