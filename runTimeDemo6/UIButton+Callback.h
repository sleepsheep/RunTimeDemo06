//
//  UIButton+Callback.h
//  TestMUI
//
//  Created by yangL on 16/3/27.
//  Copyright © 2016年 LY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^callBack)(UIButton *);
@interface UIButton (Callback)

- (instancetype)initWithFrame:(CGRect)frame callback:(callBack)callback;

@end
