//
//  UIImageExtras.h
//  ScaryBugs
//
//  Created by Ray Wenderlich on 8/23/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScaleAndCrop : NSObject 

+ (UIImage*)image:(UIImage*)toCrop ByScalingAndCroppingForSize:(CGSize)targetSize;

@end

