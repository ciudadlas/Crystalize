//
//  PDFViewController.m
//  iOSPDFRenderer
//
//  Created by Tope on 21/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PDFViewController.h"
#import "CoreText/CoreText.h"
#import "PDFRenderer.h"

@implementation PDFViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)bringUpMailViewController
{
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"My Subject"];
    [controller setMessageBody:@"Hello there." isHTML:NO]; 
    
//    NSMutableData *pdfData = [NSMutableData data];
    
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:[self getPDFFileName]];

    [controller addAttachmentData:data mimeType:@"application/pdf" fileName:@"SomeFile.pdf"];
    if (controller) [self presentModalViewController:controller animated:YES];

}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{ 
    NSString* fileName = [self getPDFFileName];

    PDFRenderer *renderer = [[PDFRenderer alloc] init];
    renderer.questions = [[NSOrderedSet alloc] initWithObjects:
                          @"PR Headline (philosophical):",
                          @"What is it?",
                          @"Who is it for?",
                          @"What makes it unlike anything else in the world?",
                          @"How does it work?",
                          @"Why are we doing it?",
                          @"How are we promoting it (earned vs. paid media)?",
                          @"What would somebody tell a friend?",
                          @"What are the risks, who are your competitors:",
                          @"Unique UI / Experience:",
                          @"What's the total potential size of the market?",
                          nil];
    
    renderer.answers = [[NSOrderedSet alloc] initWithObjects:
                          @"Make good ideas great... make great ideas happen.",
                          @"iPhone app that helps you catalog your ideas and distill them down to make them successful.",
                          @"People with ideas, inventors, entrepreneurs, daydreamers.",
                          @"It's the simplest way to organize and develop your ideas.",
                          @"It asks you a series of simple questions to help you develop and validate your idea. When you're done, it compiles a professional looking PDF executive summary. Past ideas are archived and can be recalled and edited. Also lets you have your ideas reviewed confidentially.",
                          @"It's a powerful tool for us and others. It helps you stay focused on what's most important when evaluating and executing your idea. Stay focused and answer the right questions. Important for entrepreneurial types. arrows down your ideas to help you focus on the best ideas. Help you look professional to investors and partners. Take good ideas and make them great. Take great ideas and make them real. ",
                        @"Win the Miami hackathon, speaking engagement, word of mouth, app review sites, productivity sites.",
                        @"Usually the idea itself would be shared, and it will include a small amount of branding. This app helped me take my idea to the next level.",
                          @"Stratpad",
                        @"Very close to apple HIG\n Siri like interface \n A trusted confidant",
                          @"300 million + iPhone owners * 80% are on an up to date firmware.",
                          nil];
    
    
    [renderer drawPDF:fileName];
    
    
    [self showPDFFile];
    
    //[self bringUpMailViewController];
    
    [super viewDidLoad];     
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)showPDFFile
{
    NSString* pdfFileName = [self getPDFFileName];
   
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    NSURL *url = [NSURL fileURLWithPath:pdfFileName];
    
    NSLog(@"%@ url:", url.description);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:request];
    
    

    [self.view addSubview:webView];
   
}

-(NSString*)getPDFFileName
{
    NSString* fileName = @"Invoice.PDF";
    
    NSArray *arrayPaths = 
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    return pdfFileName;

}

@end
