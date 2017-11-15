//
//  Todo.h
//  Every.Do
//
//  Created by Javier Xing on 2017-11-14.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Todo : NSObject

@property (nonatomic, strong)NSString* name;
@property (nonatomic, strong)NSString* todoDescription;
@property (nonatomic,assign)NSInteger priority;
@property (nonatomic, assign)BOOL completed;
@property (nonatomic,strong)NSDate *deadLine;

- (instancetype)initWithTask:(NSString*)task andDescription:(NSString*)description priority:(NSInteger)priority deadline:(NSDate*)deadline;

@end
