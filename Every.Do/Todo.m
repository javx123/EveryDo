//
//  Todo.m
//  Every.Do
//
//  Created by Javier Xing on 2017-11-14.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

#import "Todo.h"

@implementation Todo

- (instancetype)initWithTask:(NSString*)task andDescription:(NSString*)description priority:(NSInteger)priority deadline:(NSDate*)deadline;
{
    self = [super init];
    if (self) {
        _name = task;
        _todoDescription = description;
        _priority = priority;
        _completed = NO;
        _deadLine = deadline;
    }
    return self;
}


@end
