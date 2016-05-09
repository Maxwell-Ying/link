//
//  MyImageUtil.h
//  link
//
//  Created by Mac on 16/5/6.
//  Copyright © 2016年 Mac. All rights reserved.
//

#ifndef MyImageUtil_h
#define MyImageUtil_h
#import "MyGameImage.h"


NSArray *imageValues()
{
    NSMutableArray *resourceValues = [[NSMutableArray alloc] init];
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *paths = [bundle pathsForResourcesOfType:@"png" inDirectory:nil];
    for (NSString *path in paths) {
        NSString *imageName = [path lastPathComponent];
        if ([imageName hasPrefix:@"p_"]) {
            [resourceValues addObject:imageName];
        }
    }
    return [NSArray arrayWithArray:resourceValues];
}

NSMutableArray * getRandomValues(NSArray *sourceValues, NSInteger size)
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i = 0; i < size; i++) {
        int index = arc4random() % (sourceValues.count);
        NSString *image = sourceValues[index];
        [result addObject:image];
    }
    return result;
}

NSArray *getPlayValues(NSInteger size)
{
    if (size % 2) {
        size += 1;
    }
    NSMutableArray *playImageValues = getRandomValues(imageValues(), size / 2);
    [playImageValues addObjectsFromArray:playImageValues];
    NSInteger i = playImageValues.count;
    while (--i > 0) {
        NSInteger j = arc4random() % (i + 1);
        [playImageValues exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    return [playImageValues copy];
}

NSArray *getplayImages(NSInteger size) {
    NSArray *resourceValues = getPlayValues(size);
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (NSString *value in resourceValues) {
        UIImage *image = [UIImage imageNamed:value];
        MyGameImage *myImage = [[MyGameImage alloc] initWithImage:image imageId:[value intValue]];
        [result addObject:myImage];
    }
    return result;
}

#endif /* MyImageUtil_h */
