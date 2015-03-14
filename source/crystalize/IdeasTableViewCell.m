//
//  IdeasTableViewCell.m
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import "IdeasTableViewCell.h"

@implementation IdeasTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (Idea *)idea {
    if (_idea) {
        return _idea;
    } else {
        return nil;
    }
}

- (void)setIdea:(Idea *)idea {
    self.title.text = idea.name;
    self.progressView.progress = idea.progress;
}

@end
