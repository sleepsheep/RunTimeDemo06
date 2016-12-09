//
//  Animal.h
//  runTimeDemo6
//
//  Created by yangL on 16/3/31.
//  Copyright © 2016年 LY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Header;
@interface Animal : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, assign) int age;
@property (nonatomic, strong) Header *header;

@end
