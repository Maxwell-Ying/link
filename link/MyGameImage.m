//
//  MyGameImage.m
//  link
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "MyGameImage.h"

@implementation MyGameImage

-(instancetype) initWithImage:(UIImage *)image imageId:(NSInteger)imageId {
    if (self = [super init]) {
        self.image = image;
        self.imageId = imageId;
    }
    return self;
}

@end
