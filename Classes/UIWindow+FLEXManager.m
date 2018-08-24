//
//  UIWindow+FLEXManager.m
//  FLEX
//
//  Created by 华振宇 on 2018/8/24.
//

#import "UIWindow+FLEXManager.h"
#import "FLEXManager.h"
#import <objc/runtime.h>

@implementation UIWindow (FLEXManager)

+ (void)load {
    [UIWindow swizzle];
}

+ (void)swizzle {
    Method method = class_getInstanceMethod([UIWindow class], @selector(initWithFrame:));
    Method swizzledMethod = class_getInstanceMethod([UIWindow class], @selector(swizzled_initWithFrame:));
    method_exchangeImplementations(method, swizzledMethod);
    method = class_getInstanceMethod([UIWindow class], @selector(init));
    swizzledMethod = class_getInstanceMethod([UIWindow class], @selector(swizzled_init));
    method_exchangeImplementations(method, swizzledMethod);
}

- (instancetype)swizzled_init {
    [self swizzled_init];
    [self handleLongPress];
    return self;
}

- (instancetype)swizzled_initWithFrame:(CGRect)frame {
    [self swizzled_initWithFrame:frame];
    [self handleLongPress];
    return self;
}

- (void)handleLongPress {
    UILongPressGestureRecognizer *longPress = [UILongPressGestureRecognizer new];
    [longPress addTarget:[FLEXManager sharedManager] action:@selector(showExplorer)];
    [self addGestureRecognizer:longPress];
}

@end
