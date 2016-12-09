//
//  UIButton+Callback.m
//  TestMUI
//
//  Created by yangL on 16/3/27.
//  Copyright © 2016年 LY. All rights reserved.
//

#import "UIButton+Callback.h"
#import <objc/runtime.h>

@interface UIButton()

@property (nonatomic, copy) callBack callback;

@end

@implementation UIButton (Callback)

- (instancetype)initWithFrame:(CGRect)frame callback:(callBack)callback {
    self = [self initWithFrame:frame];
    if (self) {
        self.callback = callback;
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (callBack)callback {
    return objc_getAssociatedObject(self, @selector(callback));
}

- (void)setCallback:(callBack)callback {
    objc_setAssociatedObject(self, @selector(callback), callback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)buttonClick:(UIButton *)button {
    self.callback(button);
}

@end
