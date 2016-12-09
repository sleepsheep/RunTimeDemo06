//
//  ViewController.m
//  TestMUI
//
//  Created by yangL on 16/3/27.
//  Copyright © 2016年 LY. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Callback.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UIImage+Hook.h"
#import "Animal.h"
#import "NSObject+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1、01添加私有成员变量
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 300, 100) callback:^(UIButton *btn) {
        NSLog(@"~~~");
    }];
    button.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:button];
    
    //3、03方法交换
    [UIImage load];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, 400, 400)];
    UIImage *image = [UIImage imageNamed:@"123"];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"狗", @"name", @"小黄", @"nickName", @"23", @"age", nil];
    Animal *animal = [Animal objectWithDic:dict];
//    [animal setDiction:dict];
    NSLog(@"%@", animal.name);

    
}

- (void)exChangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls1 = object_getClass([self class]);
        SEL sel1 = @selector(viewWillAppear:);
        Method m1 = class_getClassMethod(cls1, sel1);
        
        Class cls2 = object_getClass([self class]);
        SEL sel2 = @selector(viewWillAppearCustom:);
        Method m2 = class_getClassMethod(cls2, sel2);
        
        BOOL flag = class_addMethod([self class], sel1, method_getImplementation(m2), method_getTypeEncoding(m2));
        if (flag) {
            class_replaceMethod(cls1, sel2, method_getImplementation(m1), method_getTypeEncoding(m1));
        } else {
            method_exchangeImplementations(m1, m2);
        }
        
    });
}

//- (void)viewWillAppearCustom:(BOOL)animated {
//    [super viewWillAppear:animated];
//    NSLog(@"%d", num++);
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
