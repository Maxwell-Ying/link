//
//  MyGamePoint.m
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "MyGamePoint.h"

@implementation MyGamePoint

- (instancetype) initWithX:(CGFloat)X Y:(CGFloat)Y {
    if (self = [super init]) {
        self.X = X;
        self.Y = Y;
    }
    return self;
}

- (BOOL)isEqual:(MyGamePoint *)object {
    return self.X == object.X && self.Y == object.Y;
}

@end
