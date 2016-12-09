//
//  Person.m
//  runTimeDemo6
//
//  Created by yangL on 16/3/30.
//  Copyright © 2016年 LY. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation Person

/*!
 *  @author yangL, 16-03-30 18:03:39
 *
 *  @brief 使用runtime进行归档原理:
    1、获取待归档的类的所有的成员变量 
    2、获取成员变量的名称key 
    3、根据key和decoder获取到value
    4、归档返回
 *
 *  @return self
 */
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);//获取到类的所有的成员变量 count代表个数
        
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            
            NSString *key = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            NSString *value = [decoder decodeObjectForKey:key];
            
//            [self setValue:value forKey:key];
            [self setValue:value forKeyPath:key];
        }
        
        free(ivars);
    }
    
    return self;
}

//解归档
/*!
 *  @author yangL, 16-03-30 18:03:50
 *
 *  @brief 使用runtime进行解归档的原理:
    1、获取待归档的类的所有的成员变量
    2、获取成员变量的名称key
    3、根据key和self获取到value
    4、解归档

 *  @param encoder
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        
        NSString *key = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        
//        NSString *value = [self valueForKey:key];
        id value = [self valueForKeyPath:key];
        
        [encoder encodeObject:value forKey:key];
    }
    
    free(ivars);
}

@end






