//
//  QuestionViewController.m
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import "QuestionViewController.h"
#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import <QuartzCore/QuartzCore.h>

@interface QuestionViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation QuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self configureView];
    
    self.view.backgroundColor = [UIColor colorWithRed:.94 green:.94 blue:.94 alpha:1.0];
    //UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveAndExit:)];
    //self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [self save];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.question) {
        self.questionLabel.text = self.question.question;
        self.questionLabel.backgroundColor = [UIColor colorWithRed:.89 green:.89 blue:.91 alpha:1.0];
        
        self.answerTextView.layer.borderWidth = 1.0f;
        self.answerTextView.layer.borderColor = [[UIColor grayColor] CGColor];
        
        
        if (self.question.completed) {
            self.answerTextView.text = self.question.answer;
            self.answerTextView.font = [UIFont systemFontOfSize:self.answerTextView.font.pointSize];
        } else {
            self.answerTextView.text = self.question.placeholder;
        }
    }
}

- (void)save {
    if ([self isEdited]) {
        self.question.answer = self.answerTextView.text;
        // If this is the name question, propogate to the idea
        if ([self.question.idea.questions objectAtIndex:0] == self.question) {
            self.question.idea.name = self.question.answer;
        }
        self.question.idea.lastModified = [NSDate date];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] saveContext];
        [self.delegate.tableView reloadData];
    }
}


- (void)saveAndExit:(id)sender {
    [self save];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter / Setters

- (void)setQuestion:(Question *)newQuestion {
    if (_question != newQuestion) {
        _question = newQuestion;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (BOOL)isEdited {
    BOOL isEdited = YES;
    
    if ([self.answerTextView.text isEqualToString:self.question.answer] ||
        [self.answerTextView.text isEqualToString:self.question.placeholder]) {
        isEdited = NO;
    }
    
    return isEdited;
}

#pragma mark - UITextViewDelegate methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.question.placeholder isEqualToString:textView.text]) {
        textView.text = @"";
        textView.font = [UIFont systemFontOfSize:textView.font.pointSize];
    }
    
    return YES;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


@end
