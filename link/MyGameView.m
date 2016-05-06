//
//  MyGameView.m
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "MyGameView.h"

@interface MyGameView()
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) UIColor *bubbleColor;

@end

@implementation MyGameView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.selectedImage = [UIImage imageNamed:@"select.png"];
        
        self.bubbleColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bubble.png"]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if (self.gameService == nil) {
        return;
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, [self.bubbleColor CGColor]);
    CGContextSetLineWidth(ctx, 10);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    NSArray *pieces = self.gameService.pieces;
    if (pieces != nil) {
        for (int i = 0; i < pieces.count; i++) {
            for (int j = 0; j < [pieces[i] count]; j++) {
                if ([pieces[i][j] class] == MyGamePiece.class) {
                    MyGamePiece *piece = pieces[i][j];
                    [piece.image.image drawAtPoint:CGPointMake(piece.beginX, piece.beginY)];
                }
            }
        }
    }
    
    if (self.linkInfo != nil) {
        [self drawLine:self.linkInfo context:ctx];
        self.linkInfo = nil;
        
        [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0.3];
    }
    if (self.selectedPiece != nil) {
        [self.selectedImage drawAtPoint:CGPointMake(self.selectedPiece.beginX, self.selectedPiece.beginY)];
    }
}

- (void) drawLine:(MyLinkInfo *)linkInfo context:(CGContextRef)ctx {
    NSArray *points = linkInfo.points;
    MyGamePoint *firstPoint = points[0];
    CGContextMoveToPoint(ctx, firstPoint.X, firstPoint.Y);
    for (int i = 1; i < points.count; i++) {
        MyGamePoint *currentPoint = points[i];
        CGContextAddLineToPoint(ctx, currentPoint.X, currentPoint.Y);
    }
    CGContextStrokePath(ctx);
}

- (void) startGame {
    [self.gameService start];
    [self setNeedsDisplay];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    NSArray *pieces = self.gameService.pieces;
    CGPoint touchPoint = [touch locationInView:self];
    
    MyGamePiece *currentPiece = [self.gameService findPieceAtTouchX:touchPoint.x touchY:touchPoint.y];
    
    if ([currentPiece class] != MyGamePiece.class) {
        return;
    }
    
    if (self.selectedPiece == nil) {
        self.selectedPiece = currentPiece;
        [self setNeedsDisplay];
        return;
    }
    else {
        MyLinkInfo *linkInfo = [self.gameService linkWithBeginPiece:self.selectedPiece endPiece:currentPiece];
        if (linkInfo == nil) {
            self.selectedPiece = currentPiece;
            [self setNeedsDisplay];
        }
        else {
            [self handleSuccessLink:linkInfo prevPiece:self.selectedPiece currentPiece:currentPiece pieces:pieces];
        }
    }
}

- (void) handleSuccessLink:(MyLinkInfo *)linkInfo prevPiece:(MyGamePiece *)prevPiece currentPiece:(MyGamePiece *)currentPiece pieces:(NSArray *)pieces {
    self.linkInfo = linkInfo;
    self.selectedPiece = nil;
    pieces[prevPiece.indexX][prevPiece.indexY] = [NSObject new];
    pieces[currentPiece.indexX][currentPiece.indexY] = [NSObject new];
    [self setNeedsDisplay];
    [self.delegate checkWin:self];
}

@end
