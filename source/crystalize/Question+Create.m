//
//  Question+Create.m
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import "Question+Create.h"


@implementation Question (Create)

+ (Question *)questionForIdea:(Idea *)idea withQuestionDictionary:(NSDictionary *)questionDict inManagedObjectContext:(NSManagedObjectContext *)context {
    Question *question = nil;
    
    question = [NSEntityDescription insertNewObjectForEntityForName:@"Question" inManagedObjectContext:context];
    
    question.question = [questionDict objectForKey:@"Question"];
    question.placeholder = [questionDict objectForKey:@"Placeholder"];
    question.idea = idea;
    
    return question;
}

@end
