//
//  FRDButon.h
//  FRDButtonDemo
//
//  Created by Sebastien Windal on 11/10/13.
//  Copyright (c) 2013 Sebastien Windal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FRDButtonTypeDefault = 0,
    FRDButtonTypePrimary,
    FRDButtonTypeInfo,
    FRDButtonTypeSuccess,
    FRDButtonTypeWarning,
    FRDButtonTypeDanger,
    FRDButtonTypeInverse,
    FRDButtonTypeTwitter,
    FRDButtonTypeFacebook,
    FRDButtonTypePurple,
    FRDButtonTypeGray
} FRDButtonType;

@interface FRDButton : UIButton

@property (strong, nonatomic) UIColor *color;
@property (nonatomic, strong) NSString *hexColorStr;
@property (nonatomic, strong) NSString *crayloaColorStr;

@property (strong, nonatomic) NSNumber *fontSize;
@property (assign, nonatomic) BOOL shouldShowDisabled;

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame type:(FRDButtonType)type;
- (id)initWithFrame:(CGRect)frame type:(FRDButtonType)type fontSize:(CGFloat)fontSize;

- (id)initWithFrame:(CGRect)frame color:(UIColor *)aColor;
- (id)initWithFrame:(CGRect)frame color:(UIColor *)aColor fontSize:(CGFloat)fontSize;

#pragma mark - BButton
- (void)setType:(FRDButtonType)type;

@end