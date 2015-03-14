//
//  Question+Read.m
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import "Question+Read.h"

@implementation Question (Read)

- (BOOL)completed {
    BOOL returnVal = NO;
    
    NSString *answer = self.answer;
    answer = [answer stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (answer.length > 0) {
        returnVal = YES;
    }
    
    return returnVal;
}

@end
