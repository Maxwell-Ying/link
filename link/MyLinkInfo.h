//
//  MyLinkInfo.h
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyGamePoint.h"

@interface MyLinkInfo : NSObject

@property (nonatomic, strong) NSMutableArray *points;

-(instancetype) initWithP1:(MyGamePoint *)p1 P2:(MyGamePoint *)p2;
-(instancetype) initWithP1:(MyGamePoint *)p1 P2:(MyGamePoint *)p2 P3:(MyGamePoint *)p3;
-(instancetype) initWithP1:(MyGamePoint *)p1 P2:(MyGamePoint *)p2 P3:(MyGamePoint *)p3 P4:(MyGamePoint *)p4;

@end
