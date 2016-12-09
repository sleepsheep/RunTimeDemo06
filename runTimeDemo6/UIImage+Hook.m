//
//  UIImage+Hook.m
//  runTimeDemo6
//
//  Created by yangL on 16/3/29.
//  Copyright © 2016年 LY. All rights reserved.
//

#import "UIImage+Hook.h"
#import <objc/runtime.h>

@implementation UIImage (Hook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class selfClass = object_getClass([self class]);
        
        SEL sel1 = @selector(imageNamed:);
        Method method1 = class_getClassMethod(selfClass, sel1);
        
        SEL sel2 = @selector(myImageNamed:);
        Method method2 = class_getClassMethod(selfClass, sel2);
        
        BOOL flag = class_addMethod(selfClass, sel1, method_getImplementation(method1), method_getTypeEncoding(method1));
        if (flag) {//添加成功说明没有实现，没有实现只能替换
            class_replaceMethod(selfClass, sel1, method_getImplementation(method2), method_getTypeEncoding(method2));
        } else {
            method_exchangeImplementations(method1, method2);
        }
    });
}

+ (UIImage *)myImageNamed:(NSString *)imageName {
    NSString *imageNameNew = [NSString stringWithFormat:@"%@%@", @"new_", imageName];
    return [self myImageNamed:imageNameNew];
}

@end
