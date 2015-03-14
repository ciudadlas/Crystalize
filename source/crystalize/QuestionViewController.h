//
//  QuestionViewController.h
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question+Read.h"
#import "IdeaDetailTableViewController.h"

@interface QuestionViewController : UIViewController <UITextViewDelegate, UISplitViewControllerDelegate> {
}

@property (weak, nonatomic) IdeaDetailTableViewController *delegate;
@property (weak, nonatomic) Question *question;

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextView *answerTextView;
@property (readonly) BOOL isEdited;

- (void)save;
- (IBAction)saveAndExit:(id)sender;

@end
