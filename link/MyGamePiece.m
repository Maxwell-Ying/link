//
//  MyGamePiece.m
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "MyGamePiece.h"

@implementation MyGamePiece

- (instancetype)initWithIndexX:(NSInteger)indexX indexY:(NSInteger)indexY {
    self = [super init];
    if (self) {
        self.indexX = indexX;
        self.indexY = indexY;
    }
    return self;
}

- (MyGamePoint *)getCenter {
    return [[MyGamePoint alloc] initWithX:self.image.image.size.width/2 + self.beginX Y:self.image.image.size.height/2 + self.beginY];
}

- (BOOL) isEqual:(MyGamePiece *)other {
    if (self.image == nil) {
        if (other.image != nil) {
            return NO;
        }
    }
    return self.image.imageId == other.image.imageId;
}

@end
