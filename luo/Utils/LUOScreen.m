//
//  LUOScreen.m
//  luo
//
//  Created by luowentao on 2020/6/24.
//  Copyright © 2020 luowentao. All rights reserved.
//

#import "LUOScreen.h"

@implementation LUOScreen
//iphone xs max
+ (CGSize)sizeFor65Inch{
    return CGSizeMake(414,896);
}

//iphone xr
+ (CGSize)sizeFor61Inch{
    return CGSizeMake(414,896);
}

// iphonex
+ (CGSize)sizeFor58Inch{
    return CGSizeMake(375,812);
}
@end
