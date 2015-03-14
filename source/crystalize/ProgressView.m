//
//  ProgressView.m
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

@synthesize idea;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _progress = 0;
    }
    return self;
}

- (int)progress {
    return _progress;
}

- (void)setProgress:(int)progress {
    
    _progress = progress;
    
    switch (progress) {
        case 0:
            self.image = [UIImage imageNamed:@"crystal-red"];
            break;
        case 1:
            self.image = [UIImage imageNamed:@"crystal-red"];
            break;
        case 2:
            self.image = [UIImage imageNamed:@"crystal-red"];
            break;
        case 3:
            self.image = [UIImage imageNamed:@"crystal-red"];
            break;
        case 4:
            self.image = [UIImage imageNamed:@"crystal-orange"];
            break;
        case 5:
            self.image = [UIImage imageNamed:@"crystal-orange"];
            break;
        case 6:
            self.image = [UIImage imageNamed:@"crystal-orange"];
            break;
        case 7:
            self.image = [UIImage imageNamed:@"crystal-orange"];
            break;
        case 8:
            self.image = [UIImage imageNamed:@"crystal-green"];
            break;
        case 9:
            self.image = [UIImage imageNamed:@"crystal-green"];
            break;
        case 10:
            self.image = [UIImage imageNamed:@"crystal-green"];
            break;
        case 11:
            self.image = [UIImage imageNamed:@"crystal-silver"];
            break;
        default:
            self.image = [UIImage imageNamed:@"crystal-red"];
            break;
    }
    
}

@end
