//
//  FRDButon.m
//  FRDButtonDemo
//
//  Created by Sebastien Windal on 11/10/13.
//  Copyright (c) 2013 Sebastien Windal. All rights reserved.
//

#import "FRDButton.h"
#import <CoreGraphics/CoreGraphics.h>
#import "UIColor+FRDButton.h"

@interface FRDButton()

@property (assign, nonatomic) CGGradientRef gradient;
@property (readonly, nonatomic) UILabel *fastTitleLabel;

- (void)setup;
+ (UIColor *)colorForButtonType:(FRDButtonType)type;
- (void)setGradientEnabled:(BOOL)enabled;

@end


@implementation FRDButton

#pragma mark - Initialization


- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.fastTitleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
    self.fastTitleLabel.font = self.titleLabel.font;
    self.shouldShowDisabled = YES;
    [self setType:FRDButtonTypeDefault];

}

- (id)initWithFrame:(CGRect)frame type:(FRDButtonType)type
{
    return [self initWithFrame:frame color:[FRDButton colorForButtonType:type]];
}

- (id)initWithFrame:(CGRect)frame color:(UIColor *)aColor
{
    self = [self initWithFrame:frame color:aColor];
    
    if(self) {
        self.fastTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if(self) {
        [self setup];
    }
    return self;
}

#pragma mark - Parent overrides
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if(self.shouldShowDisabled)
        [self setGradientEnabled:enabled];
    
    [self setNeedsDisplay];
}

#pragma mark - Setters



- (void)setColor:(UIColor *)newColor
{
    _color = newColor;
    
    if ([newColor isLightColor]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleShadowColor:[[UIColor whiteColor] colorWithAlphaComponent:0.1f] forState:UIControlStateNormal];
        
        if(self.shouldShowDisabled)
            [self setTitleColor:[UIColor colorWithWhite:0.4f alpha:0.5f] forState:UIControlStateDisabled];
    }
    else {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.1f] forState:UIControlStateNormal];
        
        if(self.shouldShowDisabled)
            [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateDisabled];
    }
    
    if(self.shouldShowDisabled)
        [self setGradientEnabled:self.enabled];
    else
        [self setGradientEnabled:YES];
    
    [self setNeedsDisplay];
}

- (void)setShouldShowDisabled:(BOOL)show
{
    _shouldShowDisabled = show;
    
    if (show) {
        if([self.color isLightColor])
            [self setTitleColor:[UIColor colorWithWhite:0.4f alpha:0.5f] forState:UIControlStateDisabled];
        else
            [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateDisabled];
    }
    else {
        if([self.color isLightColor])
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        else
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    }
}

#pragma mark - FRDButton

- (void)setType:(FRDButtonType)type
{
    self.color = [FRDButton colorForButtonType:type];
}


+ (UIColor *)colorForButtonType:(FRDButtonType)type
{
    UIColor *newColor = nil;
    
    switch (type) {
        case FRDButtonTypePrimary:
            newColor = [UIColor colorWithRed:0.00f green:0.33f blue:0.80f alpha:1.00f];
            break;
        case FRDButtonTypeInfo:
            newColor = [UIColor colorWithRed:0.18f green:0.59f blue:0.71f alpha:1.00f];
            break;
        case FRDButtonTypeSuccess:
            newColor = [UIColor colorWithRed:0.32f green:0.64f blue:0.32f alpha:1.00f];
            break;
        case FRDButtonTypeWarning:
            newColor = [UIColor colorWithRed:0.97f green:0.58f blue:0.02f alpha:1.00f];
            break;
        case FRDButtonTypeDanger:
            newColor = [UIColor colorWithRed:0.74f green:0.21f blue:0.18f alpha:1.00f];
            break;
        case FRDButtonTypeInverse:
            newColor = [UIColor colorWithRed:0.13f green:0.13f blue:0.13f alpha:1.00f];
            break;
        case FRDButtonTypeTwitter:
            newColor = [UIColor colorWithRed:0.25f green:0.60f blue:1.00f alpha:1.00f];
            break;
        case FRDButtonTypeFacebook:
            newColor = [UIColor colorWithRed:0.23f green:0.35f blue:0.60f alpha:1.00f];
            break;
        case FRDButtonTypePurple:
            newColor = [UIColor colorWithRed:0.45f green:0.30f blue:0.75f alpha:1.00f];
            break;
        case FRDButtonTypeGray:
            newColor = [UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f];
            break;
        case FRDButtonTypeDefault:
        default:
            newColor = [UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f];
            break;
    }
    
    return newColor;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *border = [self.color darkenColorWithValue:0.02f];
    
    // Shadow Declarations
    UIColor *shadow = [self.color lightenColorWithValue:0.20f];
    CGSize shadowOffset = CGSizeMake(0.0f, 1.0f);
    CGFloat shadowBlurRadius = 1.0f;
    
    // Rounded Rectangle Drawing
    UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.5f, 0.5f, rect.size.width-1.0f, rect.size.height-1.0f)
                                                                    cornerRadius:2.0f];
    
    CGContextSaveGState(context);
    
    [roundedRectanglePath addClip];
    
    CGContextDrawLinearGradient(context,
                                self.gradient,
                                CGPointMake(0.0f, self.highlighted ? rect.size.height - 0.5f : 0.5f),
                                CGPointMake(0.0f, self.highlighted ? 0.5f : rect.size.height - 0.5f), 0.0f);
    
    CGContextRestoreGState(context);
    
    if (!self.highlighted) {
        // Rounded Rectangle Inner Shadow
        CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -shadowBlurRadius, -shadowBlurRadius);
        roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -shadowOffset.width, -shadowOffset.height);
        roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1.0f, -1.0f);
        
        UIBezierPath *roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
        [roundedRectangleNegativePath appendPath: roundedRectanglePath];
        roundedRectangleNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = shadowOffset.width + round(roundedRectangleBorderRect.size.width);
            CGFloat yOffset = shadowOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1f, xOffset), yOffset + copysign(0.1f, yOffset)),
                                        shadowBlurRadius,
                                        shadow.CGColor);
            
            [roundedRectanglePath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0.0f);
            [roundedRectangleNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [roundedRectangleNegativePath fill];
        }
        CGContextRestoreGState(context);
    } else {
        // slighty change the button color when it is tapped (highlighted).
        CGContextSaveGState(context);
        {
            CGRect rectangle = self.bounds;
            CGContextAddRect(context, rectangle);
            UIColor *offColor = self.color.isLightColor ? [self.color darkenColorWithValue:0.1] : [self.color lightenColorWithValue:0.25];
            CGContextSetFillColorWithColor(context, offColor.CGColor);
            CGContextFillRect(context, rectangle);
        }
        CGContextRestoreGState(context);
        
    }
    
    [border setStroke];
    roundedRectanglePath.lineWidth = 1.0f;
    [roundedRectanglePath stroke];
}

- (void)setGradientEnabled:(BOOL)enabled
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UIColor *topColor = enabled ? [self.color lightenColorWithValue:0.1f] : [self.color darkenColorWithValue:0.1f];
    
    NSArray *newGradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)self.color.CGColor, nil];
    CGFloat newGradientLocations[] = {0.0f, 1.0f};
    
    _gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)newGradientColors, newGradientLocations);
    CGColorSpaceRelease(colorSpace);
}

#pragma mark - performance

- (UILabel*)fastTitleLabel
{
    if (self.subviews.count == 1)
        return [self.subviews objectAtIndex:0];
    
    return self.titleLabel;
}

@end