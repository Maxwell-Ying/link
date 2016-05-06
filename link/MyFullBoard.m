//
//  MyFullBoard.m
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "MyFullBoard.h"
#import "MyGamePiece.h"
@implementation MyFullBoard

- (NSArray *)createPieces:(NSArray *)pieces {
    NSMutableArray * notNullPieces = [[NSMutableArray alloc] init];
    for (int i = 1; i < pieces.count - 1; i++) {
        for (int j = 1; j < [pieces[i] count] - 1; j++) {
            MyGamePiece * piece = [[MyGamePiece alloc] initWithIndexX:i indexY:j];
            [notNullPieces addObject:piece];
        }
    }
    return notNullPieces;
}

@end
