//
//  AddItemViewController.m
//  Every.Do
//
//  Created by Javier Xing on 2017-11-14.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancel:(id)sender {
    [self.delegate todoAddItemCancel:self];
    
}
- (IBAction)done:(id)sender {

    Todo *todo = [[Todo alloc]initWithTask:self.taskTextField.text andDescription:self.taskDescriptionTextField.text priority: [self.priorityLevelTextField.text integerValue] deadline:self.deadlinePicker.date];
    
    [self.delegate todoAddItemViewController:self didAddTodo:todo];

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
