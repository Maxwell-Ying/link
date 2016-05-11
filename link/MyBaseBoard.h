//
//  MyBaseBoard.h
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBaseBoard : NSObject

@property (nonatomic, assign) NSInteger xSize;
@property (nonatomic, assign) NSInteger ySize;

-(NSArray *) createPieces:(NSArray *)pieces;
-(NSArray *) create;

@end
