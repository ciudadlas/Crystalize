//
//  ProgressView.h
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Idea+Read.h"

@interface ProgressView : UIImageView {
    int _progress;
}

@property (nonatomic) int progress;
@property (nonatomic, retain) Idea *idea;

@end
