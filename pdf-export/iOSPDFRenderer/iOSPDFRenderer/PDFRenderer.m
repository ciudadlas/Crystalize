//
//  PDFRenderer.m
//  iOSPDFRenderer
//
//  Created by Tope on 24/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PDFRenderer.h"

@implementation PDFRenderer

@synthesize questions, answers, lastYValue;

-(void)drawPDF:(NSString*)fileName
{
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    [self drawIdeaTitle:@"Crystalize"];
    [self drawConfidentialText];
    [self drawCrystalizeBrandingText];
    [self drawCrystalizeLogo];
    [self drawCopyrightInfo:@"© Serdar Karatekin\nMiami, FL\n786.300.9630"];
    
    for (int i = 0; i < [self.answers count]; i++)
    {
        [self drawQuestionAndAnswer:i];
    }
    

    
    int xOrigin = 50;
    int yOrigin = 300;
    
    int rowHeight = 50;
    int columnWidth = 120;
    
    int numberOfRows = 7;
    int numberOfColumns = 4;
    
    //[self drawTableAt:CGPointMake(xOrigin, yOrigin) withRowHeight:rowHeight andColumnWidth:columnWidth andRowCount:numberOfRows andColumnCount:numberOfColumns];
    
    //[self drawTableDataAt:CGPointMake(xOrigin, yOrigin) withRowHeight:rowHeight andColumnWidth:columnWidth andRowCount:numberOfRows andColumnCount:numberOfColumns];
    
    /*
    
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    [self drawText:@"Hello World" inFrame:CGRectMake(0, 0, 300, 50)];
    
    [self drawLabels];
    [self drawLogo];
    
    [self drawTableAt:CGPointMake(xOrigin, yOrigin) withRowHeight:rowHeight andColumnWidth:columnWidth andRowCount:numberOfRows andColumnCount:numberOfColumns];
    
    [self drawTableDataAt:CGPointMake(xOrigin, yOrigin) withRowHeight:rowHeight andColumnWidth:columnWidth andRowCount:numberOfRows andColumnCount:numberOfColumns];
     
    */
    
    
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}

-(void)drawIdeaTitle:(NSString *)title
{
    CTFontRef font = CTFontCreateWithName(CFSTR("HelveticaNeue-UltraLight"), 32, NULL);
    [self drawText:title inFrame:CGRectMake(45, 210, 200, 100) fontRef:font incrementYValue:NO];

}

-(void)drawCopyrightInfo:(NSString *)info
{
    CTFontRef font = CTFontCreateWithName(CFSTR("HelveticaNeue-Light"), 7, NULL);
    [self drawText:info inFrame:CGRectMake(45, 310, 200, 100) fontRef:font incrementYValue:NO];
    
}

-(void)drawConfidentialText
{
    CTFontRef font = CTFontCreateWithName(CFSTR("HelveticaNeue-Light"), 9, NULL);
    [self drawText:@"Confidential" inFrame:CGRectMake(45, 250, 200, 100) fontRef:font incrementYValue:NO];
    
}

-(void)drawCrystalizeBrandingText
{
    CTFontRef font = CTFontCreateWithName(CFSTR("HelveticaNeue-Light"), 7, NULL);
    [self drawText:@"Crystalize" inFrame:CGRectMake(500, 200, 200, 100) fontRef:font incrementYValue:NO];    
}

-(void)drawCrystalizeLogo
{
    UIImage* logo = [UIImage imageNamed:@"icon.png"];
    [self drawImage:logo inRect:CGRectMake(500, 50, logo.size.width, logo.size.height)];   
}

-(void)drawQuestionAndAnswer:(int)index
{
    float currentValue = self.lastYValue;
    
    CTFontRef questionFont = CTFontCreateWithName(CFSTR("HelveticaNeue-Bold"), 12, NULL);
    [self drawText:[self.questions objectAtIndex:index] inFrame:CGRectMake(150, 300 + currentValue, 425, 100) fontRef:questionFont incrementYValue:YES];
    
    CTFontRef answerFont = CTFontCreateWithName(CFSTR("HelveticaNeue-Light"), 9, NULL);
    [self drawText:[self.answers objectAtIndex:index] inFrame:CGRectMake(150, 315 + currentValue, 425, 100) fontRef:answerFont incrementYValue:YES];
    
    self.lastYValue += 20;
}


-(void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[] = {0.2, 0.2, 0.2, 0.3};
    
    CGColorRef color = CGColorCreate(colorspace, components);
    
    CGContextSetStrokeColorWithColor(context, color);
    
    
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    
}


-(void)drawImage:(UIImage*)image inRect:(CGRect)rect
{

    [image drawInRect:rect];

}

-(void)drawText:(NSString*)textToDraw inFrame:(CGRect)frameRect fontRef:(CTFontRef)font incrementYValue:(BOOL)increment
{
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    
    // Create an attributed string
    CFStringRef keys[] = { kCTFontAttributeName };
    CFTypeRef values[] = { font };
    CFDictionaryRef attr = CFDictionaryCreate(NULL, (const void **)&keys, (const void **)&values,
                                              sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFAttributedStringRef attrString = CFAttributedStringCreate(NULL, stringRef, attr);
    CFRelease(attr);

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    
    
    CGFloat widthConstraint = 500; // Your width constraint, using 500 as an example
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(
                                                                        framesetter, /* Framesetter */
                                                                        CFRangeMake(0, textToDraw.length), /* String range (entire string) */
                                                                        NULL, /* Frame attributes */
                                                                        CGSizeMake(widthConstraint, CGFLOAT_MAX), /* Constraints (CGFLOAT_MAX indicates unconstrained) */
                                                                        NULL /* Gives the range of string that fits into the constraints, doesn't matter in your situation */
                                                                        );
    CGFloat suggestedHeight = suggestedSize.height;
    
    if (increment)
    {
        self.lastYValue += suggestedHeight;
    }
    
    NSLog(@"%f y", suggestedSize.height);
    
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(currentContext, [[UIColor blackColor] CGColor]);
    CGContextSetTextDrawingMode(currentContext, kCGTextFill);
    
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, frameRect.origin.y*2);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    

    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    CGContextTranslateCTM(currentContext, 0, (-1)*frameRect.origin.y*2);
    
    
    CFRelease(frameRef);
    //CFRelease(stringRef);
    CFRelease(framesetter);

}



-(void)drawTableAt:(CGPoint)origin 
    withRowHeight:(int)rowHeight 
   andColumnWidth:(int)columnWidth 
      andRowCount:(int)numberOfRows 
   andColumnCount:(int)numberOfColumns

{
   
    for (int i = 0; i <= numberOfRows; i++) {
        
        int newOrigin = origin.y + (rowHeight*i);
        
        
        CGPoint from = CGPointMake(origin.x, newOrigin);
        CGPoint to = CGPointMake(origin.x + (numberOfColumns*columnWidth), newOrigin);
        
        [self drawLineFromPoint:from toPoint:to];
        
        
    }
    
    for (int i = 0; i <= numberOfColumns; i++) {
        
        int newOrigin = origin.x + (columnWidth*i);
        
        
        CGPoint from = CGPointMake(newOrigin, origin.y);
        CGPoint to = CGPointMake(newOrigin, origin.y +(numberOfRows*rowHeight));
        
        [self drawLineFromPoint:from toPoint:to];
        
        
    }
}

-(void)drawTableDataAt:(CGPoint)origin 
    withRowHeight:(int)rowHeight 
   andColumnWidth:(int)columnWidth 
      andRowCount:(int)numberOfRows 
   andColumnCount:(int)numberOfColumns
{
    int padding = 10; 
    
    NSArray* headers = [NSArray arrayWithObjects:@"Quantity", @"Description", @"Unit price", @"Total", nil];
    NSArray* invoiceInfo1 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
    NSArray* invoiceInfo2 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
    NSArray* invoiceInfo3 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
    NSArray* invoiceInfo4 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
    
    NSArray* allInfo = [NSArray arrayWithObjects:headers, invoiceInfo1, invoiceInfo2, invoiceInfo3, invoiceInfo4, nil];
    
    for(int i = 0; i < [allInfo count]; i++)
    {
        NSArray* infoToDraw = [allInfo objectAtIndex:i];
        
        for (int j = 0; j < numberOfColumns; j++) 
        {
            
            int newOriginX = origin.x + (j*columnWidth);
            int newOriginY = origin.y + ((i+1)*rowHeight);
            
            CGRect frame = CGRectMake(newOriginX + padding, newOriginY + padding, columnWidth, rowHeight);
            
            
            //[self drawText:[infoToDraw objectAtIndex:j] inFrame:frame];
        }
        
    }
    
}@end
