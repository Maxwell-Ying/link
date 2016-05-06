//
//  MyGamePiece.h
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MyGamePoint.h"
#import "MyGameImage.h"

@interface MyGamePiece : NSObject

@property (nonatomic, strong) MyGameImage *image;

@property (nonatomic, assign) NSInteger beginX;
@property (nonatomic, assign) NSInteger beginY;

@property (nonatomic, assign) NSInteger indexX;
@property (nonatomic, assign) NSInteger indexY;

- (instancetype) initWithIndexX:(NSInteger)indexX indexY:(NSInteger)indexY;

- (MyGamePoint *) getCenter;

- (BOOL) isEqual:(MyGamePiece *)other;

@end
