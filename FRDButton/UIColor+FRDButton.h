//
//  UIColor+FRDButton.h
//  FRDButtonDemo
//
//  Created by Sebastien Windal on 11/10/13.
//  Copyright (c) 2013 Sebastien Windal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FRDButton)

- (UIColor *)lightenColorWithValue:(CGFloat)value;
- (UIColor *)darkenColorWithValue:(CGFloat)value;
- (BOOL)isLightColor;

@end
