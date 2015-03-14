//
//  IdeaDetailTableViewController.h
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Idea+Read.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface IdeaDetailTableViewController : UITableViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, retain) Idea *idea;

@end
