//
//  UIView+KSBoundsCategory.m
//  Autolancer
//
//  Created by user on 28/10/14.
//  Copyright (c) 2014 mac-214. All rights reserved.
//

#import "UIView+KSBoundsCategory.h"

@implementation UIView (KSBoundsCategory)

- (void)borderWidth:(CGFloat)width borderColor:(UIColor *)color radius:(CGFloat)radius
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
}

@end
