//
//  MyGameService.h
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyGamePiece.h"
#import "MyLinkInfo.h"

@interface MyGameService : NSObject

@property (nonatomic, assign) NSInteger xSize;
@property (nonatomic, assign) NSInteger ySize;

@property (nonatomic, strong) NSArray *pieces;

- (void) start;

- (BOOL) hasPieces;

- (MyGamePiece *) findPieceAtTouchX:(CGFloat)touchX touchY:(CGFloat)touchY;

- (MyLinkInfo *) linkWithBeginPiece:(MyGamePiece *)begin endPiece:(MyGamePiece *)end;

@end
