//
//  MyLinkInfo.m
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "MyLinkInfo.h"

@implementation MyLinkInfo

- (instancetype) initWithP1:(MyGamePoint *)p1 P2:(MyGamePoint *)p2 {
    if (self = [super init]) {
        self.points = [[NSMutableArray alloc] init];
        [self.points addObject:p1];
        [self.points addObject:p2];
    }
    return self;
}

- (instancetype) initWithP1:(MyGamePoint *)p1 P2:(MyGamePoint *)p2 P3:(MyGamePoint *)p3 {
    if (self = [super init]) {
        self.points = [[NSMutableArray alloc] init];
        [self.points addObject:p1];
        [self.points addObject:p2];
        [self.points addObject:p3];
    }
    return self;
}

- (instancetype) initWithP1:(MyGamePoint *)p1 P2:(MyGamePoint *)p2 P3:(MyGamePoint *)p3 P4:(MyGamePoint *)p4{
    if (self = [super init]) {
        self.points = [[NSMutableArray alloc] init];
        [self.points addObject:p1];
        [self.points addObject:p2];
        [self.points addObject:p3];
        [self.points addObject:p4];
    }
    return self;
}
@end
