//
//  MyGameView.h
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyGamePiece.h"
#import "MyLinkInfo.h"
#import "MyGameService.h"

@class MyGameView;

@protocol MyGameViewDelegate <NSObject>

- (void) checkWin:(MyGameView *)gameView;

@end

@interface MyGameView : UIView

@property (nonatomic, strong) MyGameService *gameService;

@property (nonatomic, strong) MyLinkInfo *linkInfo;

@property (nonatomic, strong) MyGamePiece *selectedPiece;
@property (nonatomic, strong) id<MyGameViewDelegate> delegate;

-(void) startGame;

@end
