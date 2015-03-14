//
//  TableCellCustomColoredAccessory.h
//  travel
//
//  Created by Serdar Karatekin on 1/18/12.
//  Copyright (c) 2012 Crispin Porter + Bogusky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCellCustomColoredAccessory : UIControl
{
	UIColor *_accessoryColor;
	UIColor *_highlightedColor;
}

@property (nonatomic, retain) UIColor *accessoryColor;
@property (nonatomic, retain) UIColor *highlightedColor;

+ (TableCellCustomColoredAccessory *)accessoryWithColor:(UIColor *)color;

@end