//
//  IdeasTableViewCell.h
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Idea+Read.h"
#import "ProgressView.h"

@interface IdeasTableViewCell : UITableViewCell {
    Idea *_idea;
}

@property (nonatomic,retain) Idea *idea;
@property (nonatomic,retain) IBOutlet UILabel *title;
@property (nonatomic,retain) IBOutlet ProgressView *progressView;

@end
