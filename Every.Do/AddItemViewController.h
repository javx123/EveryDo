//
//  AddItemViewController.h
//  Every.Do
//
//  Created by Javier Xing on 2017-11-14.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@class AddItemViewController;

@protocol AddItemViewControllerProtocol <NSObject>
-(void)todoAddItemCancel:(AddItemViewController*)controller;
-(void)todoAddItemViewController:(AddItemViewController *)controller didAddTodo:(Todo *)todo;
@end

@interface AddItemViewController : UIViewController
@property (nonatomic, weak) id <AddItemViewControllerProtocol> delegate;
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;
@property (weak, nonatomic) IBOutlet UITextField *taskDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *priorityLevelTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *deadlinePicker;


@end
