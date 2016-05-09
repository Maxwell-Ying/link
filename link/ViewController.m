//
//  ViewController.m
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "MyGameView.h"

#define DEFAULT_TIME 100

@interface ViewController () <MyGameViewDelegate>

@property (nonatomic, strong) MyGameView *gameView;
@property (nonatomic, assign) NSInteger leftTime;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) UIAlertController *alert;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gameView = [[MyGameView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.gameView.gameService = [[MyGameService alloc] init];
    self.gameView.delegate = self;
    self.gameView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.gameView];
    [self startGame];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)startGame {
    if (self.timer) {
        [self.timer invalidate];
    }
    self.leftTime = DEFAULT_TIME;
    [self.gameView startGame];
    self.isPlaying = YES;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshView) userInfo:nil repeats:YES];
    self.gameView.selectedPiece = nil;
}

- (void)refreshView {
    //
    self.leftTime--;
    if (self.leftTime < 0) {
        [self.timer invalidate];
        self.isPlaying = NO;
        //
        return;
    }
}

- (void)checkWin:(MyGameView *)gameView {
    if (![gameView.gameService hasPieces]) {
        //
        [self.timer invalidate];
        self.isPlaying =NO;
    }
}

@end
