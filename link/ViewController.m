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
@property (nonatomic, strong) UIAlertController *successAlert;
@property (nonatomic, strong) UIAlertController *failAlert;
@property (nonatomic, strong) UIView *barView;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, assign) NSInteger maxPieces;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.successAlert = [UIAlertController alertControllerWithTitle:@"Game Over" message:@"Success" preferredStyle:UIAlertControllerStyleAlert];
    [self.successAlert addAction:[UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:nil]];
    self.failAlert = [UIAlertController alertControllerWithTitle:@"Gameover" message:@"Failed" preferredStyle:UIAlertControllerStyleAlert];
    [self.failAlert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    CGRect gameRect = [UIScreen mainScreen].bounds;
    gameRect.size.height -= 30;
    self.gameView = [[MyGameView alloc] initWithFrame:gameRect];
    self.gameView.gameService = [[MyGameService alloc] init];
    self.gameView.gameService.xSize = gameRect.size.width /30;
    self.gameView.gameService.ySize = gameRect.size.height/30;
    self.gameView.delegate = self;
    self.gameView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.gameView];
    
    self.maxPieces = (self.gameView.gameService.xSize - 1) * (self.gameView.gameService.ySize - 1);
    
    CGRect barRect = [UIScreen mainScreen].bounds;
    barRect.size.height = 30;
    barRect.origin.y = gameRect.size.height;
    self.barView = [[UIView alloc] initWithFrame:barRect];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.frame  = CGRectMake(30, 0, 70, 30);
    startButton.layer.cornerRadius = 10;
    startButton.backgroundColor = [UIColor greenColor];
    [startButton setTitle:@"start" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    [self.barView addSubview:startButton];
    
    self.time = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 110, 30)];
    self.time.text = [NSString stringWithFormat:@"left time : 0"];
    [self.barView addSubview:self.time];
    self.progress = [[UIProgressView alloc] initWithFrame:CGRectMake(220, 14, 150, 30)];
    self.progress.progressTintColor = [UIColor greenColor];
    self.progress.trackTintColor = [UIColor clearColor];
    self.progress.progress = 1.0;
    [self.barView addSubview:self.progress];
    
    [self.view addSubview:self.barView];
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
    self.leftTime = self.maxPieces / 2;
    [self.gameView startGame];
    self.isPlaying = YES;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshView) userInfo:nil repeats:YES];
    self.gameView.selectedPiece = nil;
}

- (void)refreshView {
    //
    self.time.text = [NSString stringWithFormat:@"left time : %ld", self.leftTime];
    if (self.leftTime < self.maxPieces / 3.0) {
        self.progress.progressTintColor = [UIColor orangeColor];
    }
    else if (self.leftTime < self.maxPieces / 6.0) {
        self.progress.progressTintColor = [UIColor redColor];
    }
    [self.progress setProgress:((self.leftTime * 2.0) / self.maxPieces) animated:YES];
    self.leftTime--;
    if (self.leftTime < 0) {
        [self.timer invalidate];
        self.isPlaying = NO;
        
        [self presentViewController:self.failAlert animated:YES completion:nil];
        
        return;
    }
}

- (void)checkWin:(MyGameView *)gameView {
    if (![gameView.gameService hasPieces]) {
        [self presentViewController:self.successAlert animated:YES completion:nil];
        [self.timer invalidate];
        self.isPlaying =NO;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
