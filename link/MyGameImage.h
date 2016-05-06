//
//  MyGameImage.h
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyGameImage : UIImage

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSInteger imageId;

- (instancetype) initWithImage:(UIImage *)image imageId:(NSInteger)imageId;

@end
