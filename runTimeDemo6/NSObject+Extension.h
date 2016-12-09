//
//  NSObject+Extension.h
//  runTimeDemo6
//
//  Created by yangL on 16/3/30.
//  Copyright © 2016年 LY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

- (void)setDiction:(NSDictionary *)dict;

+ (instancetype)objectWithDic:(NSDictionary *)dict;

@end
