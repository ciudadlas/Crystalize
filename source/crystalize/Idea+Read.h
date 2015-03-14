//
//  Idea+Read.h
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import "Idea.h"

@interface Idea (Read)

- (int)progress; //returns a float between 0.0 and 1.0
- (NSString *)pdfPath; //returns a temp path to a rendered PDF document of the idea
- (NSString *)editablePath; //returns a temp path to an editable export of the idea

@end
