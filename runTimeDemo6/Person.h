//
//  Person.h
//  runTimeDemo6
//
//  Created by yangL on 16/3/30.
//  Copyright © 2016年 LY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

- (id)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

@end
