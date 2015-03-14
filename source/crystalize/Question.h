//
//  Question.h
//  crystalize
//
//  Created by Justin Kent on 8/11/12.
//  Copyright (c) 2012 Kent Digital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Idea;

@interface Question : NSManagedObject

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSString * placeholder;
@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) Idea *idea;

@end
