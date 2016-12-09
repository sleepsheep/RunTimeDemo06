//
//  NSObject+Extension.m
//  runTimeDemo6
//
//  Created by yangL on 16/3/30.
//  Copyright © 2016年 LY. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

/*!
 *  @author yangL, 16-03-31 10:03:19
 *
 *  @brief 字典转化为模型的方法
 *
 *  @param dict 待转化的字典
 */
- (void)setDiction:(NSDictionary *)dict {
    Class selfclass = self.class;
    
    //循环遍历 类 (本类 或 所有父类)
    while (selfclass && selfclass != [NSObject class]) {
        
        unsigned int count = 0;
        //获取到待转化的模型的所有的变量
        Ivar* ivars = class_copyIvarList(selfclass, &count);
        
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            
            //获取变量的名字 但是注意 这里获取到的变量前面会有一个下划线 '_'
            NSString *keyTemp = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            //去掉‘_’ 以便和dict中的key匹配
            NSString *key = [keyTemp substringFromIndex:1];
            //获取字典中对应的key的value
            id value = [dict objectForKey:key];
            //如果字典中没有这个值那么value将会是一个空值
            if (value == nil) {
                continue;
            }
            
            /*
             这里进行下说明：字符串和类的encodingType都是以@开头、int --> i、float--> f
             */
            //如果类中包含另一个类的对象，也将这个类对象的字典转化为模型
            NSString *encodeType = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
            //对象会以 @名字 的形式出现 但是NSString也会以这个形式出现
            NSRange range = [encodeType rangeOfString:@"@"];
            //说明是字符串或者是对象
            if (range.location != NSNotFound) {
                //forType是类名或者NSString
                NSString *forType = [encodeType substringWithRange:NSMakeRange(2, encodeType.length - 3)];
                //不是字符串，说明是类
                if (![forType isEqualToString:@"NSString"]) {
                    //字符串转化为类
                    Class classS = NSClassFromString(forType);
                    //解析类中的字段
                    value = [classS objectWithDic:value];
                }
            }
            [self setValue:value forKey:key];
        }
        //官方文档说明，使用完后必须释放
        free(ivars);
        selfclass = [selfclass superclass];
    }
}

+ (instancetype)objectWithDic:(NSDictionary *)dict {
    NSObject *object = [[self alloc] init];
    [object setDiction:dict];
    return object;
}

@end
