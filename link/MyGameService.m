//
//  MyGameService.m
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "MyGameService.h"
#import "MyFullBoard.h"
#import "MyGamePoint.h"

@implementation MyGameService

- (instancetype) init {
    if ([super init]) {
        self.xSize = 10;
        self.ySize = 10;
    }
    return self;
}

- (void)start {
    MyFullBoard *board = [[MyFullBoard alloc] init];
    board.xSize = self.xSize;
    board.ySize = self.ySize;
    
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
    NSInteger indexX = [self getIndexWithRelateive:touchX size:30];
    NSInteger indexY = [self getIndexWithRelateive:touchY size:30];
    
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
    if (begin == end) {
        return nil;
    }
    if (![begin isEqual:end]) {
        return nil;
    }
    if (end.indexX < begin.indexX) {
        return [self linkWithBeginPiece:end endPiece:begin];
    }
    
    MyGamePoint *beginPoint = [begin getCenter];
    MyGamePoint *endPoint = [end getCenter];
    if (begin.indexY == end.indexY) {
        if (![self isXBlockFromBegin:beginPoint toEnd:endPoint]) {
            return [[MyLinkInfo alloc] initWithP1:beginPoint P2:endPoint];
        }
    }
    if (begin.indexX == end.indexX) {
        if (![self isYBlockFromBegin:beginPoint toEnd:endPoint]) {
            return [[MyLinkInfo alloc] initWithP1:beginPoint P2:endPoint];
        }
    }
    
    MyGamePoint *cornerPoint = [self getCornerPointFromBegin:beginPoint toEnd:endPoint];
    if (cornerPoint) {
        return [[MyLinkInfo alloc] initWithP1:beginPoint P2:cornerPoint P3:endPoint];
    }
    
    NSDictionary *turns = [self getLinkPointsFromBegin:beginPoint toEnd:endPoint];
    if (turns.count) {
        return [self getShortCutFromPoint:beginPoint toPoint:endPoint turns:turns distance:[self getDistanceFromPoint:beginPoint toPoint:endPoint]];
    }
    return nil;
}

- (NSArray *)getLeftChannelFromPoint:(MyGamePoint *)point min:(NSInteger)min {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSInteger i = point.X - 30; i >= min; i = i - 30) {
        if ([self findPieceAtTouchX:i touchY:point.Y]) {
            return result;
        }
        [result addObject:[[MyGamePoint alloc] initWithX:i Y:point.Y]];
    }
    return result;
}

- (NSArray *)getRightChannelFromPoint:(MyGamePoint *)point max:(NSInteger)max {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSInteger i = point.X + 30; i <= max; i = i + 30) {
        if ([self findPieceAtTouchX:i touchY:point.Y]) {
            return result;
        }
        [result addObject:[[MyGamePoint alloc] initWithX:i Y:point.Y]];
    }
    return result;
}


- (NSArray *)getUpChannelFromPoint:(MyGamePoint *)point min:(NSInteger)min {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSInteger i = point.Y - 30; i >= min; i = i - 30) {
        if ([self findPieceAtTouchX:point.X touchY:i]) {
            return result;
        }
        [result addObject:[[MyGamePoint alloc] initWithX:point.X Y:i]];
    }
    return result;
}


- (NSArray *)getDownChannelFromPoint:(MyGamePoint *)point max:(NSInteger)max {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSInteger i = point.Y + 30; i <= max; i = i + 30) {
        if ([self findPieceAtTouchX:point.X touchY:i]) {
            return result;
        }
        [result addObject:[[MyGamePoint alloc] initWithX:point.X Y:i]];
    }
    return result;
}

- (MyGamePiece *)getPieceAtX:(CGFloat)X Y:(CGFloat)Y {
    return [self findPieceAtTouchX:(NSInteger)X touchY:(NSInteger)Y];
}

- (BOOL) isXBlockFromBegin:(MyGamePoint *)begin toEnd:(MyGamePoint *)end {
    return YES;
}

- (BOOL) isYBlockFromBegin:(MyGamePoint *)begin toEnd:(MyGamePoint *)end {
    return YES;
}

- (MyGamePoint *)getCornerPointFromBegin:(MyGamePoint *)begin toEnd:(MyGamePoint *)end {
    return [[MyGamePoint alloc] init];
}

- (NSDictionary *)getLinkPointsFromBegin:(MyGamePoint *)begin toEnd:(MyGamePoint *)end {
    return [[NSDictionary alloc] init];
}




- (MyLinkInfo *)getShortCutFromPoint:(MyGamePoint *)begin toPoint:(MyGamePoint *)end turns:(NSDictionary *)turns distance:(NSInteger)shortDistance {
    NSMutableArray *infos = [[NSMutableArray alloc] init];
    
    for (MyGamePoint *point1 in turns) {
        MyGamePoint *point2 = turns[point1];
        [infos addObject:[[MyLinkInfo alloc] initWithP1:begin P2:point1 P3:point2 P4:end]];
    }
    return [self getShortCut:infos shortDistance:shortDistance];
}

- (MyLinkInfo *)getShortCut:(NSArray *)infos shortDistance:(NSInteger)shortDistance {
    NSInteger temp = 0;
    MyLinkInfo *result = nil;
    for (int i = 0; i < infos.count; i++) {
        MyLinkInfo *info = infos[i];
        
        NSInteger distance = [self countAll:info.points];
        if (i == 0) {
            temp = distance - shortDistance;
            result = info;
        }
        if (distance - shortDistance < temp) {
            temp = distance - shortDistance;
            result = info;
        }
    }
    return result;
}

- (NSInteger) countAll:(NSArray *)points {
    NSInteger result = 0;
    for (int i = 0; i < points.count - 1; i++) {
        MyGamePoint *point1 = points[i];
        MyGamePoint *point2 = points[i + 1];
        result += [self getDistanceFromPoint:point1 toPoint:point2];
    }
    return result;
}

- (NSInteger)getDistanceFromPoint:(MyGamePoint *)from toPoint:(MyGamePoint *)to {
    NSInteger xDistance = abs((int)(from.X - to.X));
    NSInteger yDistance = abs((int)(from.Y - to.Y));
    return xDistance + yDistance;
}

@end
