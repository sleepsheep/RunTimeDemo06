//
//  UITabBarController+Custom.m
//  runTimeDemo6
//
//  Created by yangL on 16/3/29.
//  Copyright © 2016年 LY. All rights reserved.
//

#import "UITabBarController+Custom.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UITabBarController (Custom)

- (CustomTabBar *)customTabBar {
    return objc_getAssociatedObject(self, @selector(customTabBar));
}

- (void)setCustomTabBar:(CustomTabBar *)customTabBar {
    objc_setAssociatedObject(self, @selector(customTabBar), customTabBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//...其他的可以操作customTabBar的方法

@end
