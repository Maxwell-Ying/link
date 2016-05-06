//
//  MyGameService.m
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "MyGameService.h"
#import "MyFullBoard.h"

@implementation MyGameService

- (void)start {
    MyFullBoard *board = [[MyFullBoard alloc] init];
    
    self.pieces = [board create];
}

- (BOOL) hasPieces {
    for (int i = 0; i < self.pieces.count; i++) {
        for (int j = 0; j < [self.pieces[i] count]; j++) {
            if ([self.pieces[i][j] class] == [MyGamePiece class]) {
                return YES;
            }
        }
    }
    return NO;
}

- (MyGamePiece *)findPieceAtTouchX:(CGFloat)touchX touchY:(CGFloat)touchY {
    if (touchX < 0 || touchY < 0) {
        return nil;
    }
    NSInteger indexX = [self getIndexWithRelateive:touchX size:20];
    NSInteger indexY = [self getIndexWithRelateive:touchY size:20];
    
    if (indexX < 0 || indexY < 0) {
        return nil;
    }
    if (indexX > self.pieces.count || indexY > [self.pieces[0] count] ) {
        return nil;
    }
    return self.pieces[indexX][indexY];
}

- (NSInteger) getIndexWithRelateive:(NSInteger)relative size:(NSInteger) size {
    NSInteger index = -1;
    if (relative % size == 0) {
        index = relative/size - 1;
    }
    else {
        index = relative/size;
    }
    return index;
}

- (MyLinkInfo *) linkWithBeginPiece:(MyGamePiece *)begin endPiece:(MyGamePiece *)end {
    return [[MyLinkInfo alloc] init];
}

@end
