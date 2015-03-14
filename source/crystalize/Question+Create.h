//
//  Question+Create.h
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import "Question.h"
#import "Idea.h"

@interface Question (Create)

+ (Question *)questionForIdea:(Idea *)idea withQuestionDictionary:(NSDictionary *)questionDict inManagedObjectContext:(NSManagedObjectContext *)context;

@end
