//
//  MyGamePoint.h
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyGamePoint : NSObject

@property (nonatomic, assign) CGFloat X;
@property (nonatomic, assign) CGFloat Y;

-(instancetype) initWithX:(CGFloat)X Y:(CGFloat)Y;

@end
