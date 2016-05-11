//
//  MyBaseBoard.m
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "MyBaseBoard.h"
#import "MyGameImage.h"
#import "MyGamePiece.h"
#import "MyImageUtil.h"

@implementation MyBaseBoard

-(instancetype)init {
    if ([super init]) {
        self.xSize = 10;
        self.ySize = 10;
    }
    return self;
}

-(NSArray *) createPieces:(NSArray *)pieces {
    return nil;
}

-(NSArray *) create {
    NSMutableArray * pieces = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.xSize; i++) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (int j = 0; j < self.ySize; j++) {
            [arr addObject:[NSObject new]];
        }
        [pieces addObject:arr];
    }
    
    NSArray *notNullPieces = [self createPieces:pieces];
    
    NSArray <MyGameImage *>*playImage = getplayImages(notNullPieces.count);
    
    int imageWidth = playImage[0].image.size.width;
    int imageHeight = playImage[0].image.size.height;
    
    for (int i = 0; i < notNullPieces.count; i++) {
        MyGamePiece *piece = notNullPieces[i];
        piece.image = playImage[i];
        piece.beginX = piece.indexX * imageWidth + 0;// or add beginImageX
        piece.beginY = piece.indexY * imageHeight+ 0;// or add beginImageY
        [pieces[piece.indexX] setObject:piece atIndex:piece.indexY];
    }
    return pieces;
}



@end
