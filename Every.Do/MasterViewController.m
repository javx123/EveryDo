//
//  MasterViewController.m
//  Every.Do
//
//  Created by Javier Xing on 2017-11-14.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Todo.h"
#import "TodoTableViewCell.h"
#import "AddItemViewController.h"

@interface MasterViewController () <UITableViewDelegate, UITableViewDataSource, AddItemViewControllerProtocol>

@property (nonatomic,strong)NSMutableArray <Todo*> *todos;
@property (nonatomic, strong)NSMutableArray <Todo*> *completedTodos;
@end

@implementation MasterViewController

-(NSMutableArray <Todo*>*)todos {
    if (_todos == nil){
        _todos = [[NSMutableArray alloc]init];
        [_todos addObject:[[Todo alloc]initWithTask:@"Go Shopping" andDescription:@"Go to the store and buy milk, and any other groceries" priority:2 deadline:[NSDate date]]];
        [_todos addObject:[[Todo alloc]initWithTask:@"Go Gym" andDescription:@"Go work out back and arms" priority:1 deadline:[NSDate date]]];
        [_todos addObject:[[Todo alloc]initWithTask:@"Clean House" andDescription:@"Clean room, washroom, and kitchen" priority:3 deadline:[NSDate date]]
         ];
    }
    return _todos;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self.editButtonItem setAction:@selector(startEditing:)];
    self.completedTodos = [[NSMutableArray alloc]init];
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
                                                                               action:@selector(openAddObjectVC:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UISwipeGestureRecognizer *swipeTodo = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(crossTodo:)];
    [self.view addGestureRecognizer:swipeTodo];
}


-(void)crossTodo:(UISwipeGestureRecognizer*)sender{

    CGPoint swippedTodo = [sender locationInView:sender.view];
    NSIndexPath *todoPathRow = [self.tableView indexPathForRowAtPoint:swippedTodo];
    if (todoPathRow.section == 0) {
        Todo * todo = self.todos[todoPathRow.row];
        todo.completed = YES;
        if ([self.todos containsObject:todo]) {
            [self.todos removeObjectAtIndex:todoPathRow.row];
            [self.completedTodos addObject:todo];
        }
        [self.tableView reloadData];
    }
}

- (void)openAddObjectVC:(id)sender {
    [self performSegueWithIdentifier:@"AddItem" sender:nil];
    
}

#pragma mark - Editing functionalities

-(void)startEditing:(id)sender{
    self.tableView.editing = !self.tableView.editing;
    
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return  YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    Todo *todoToMove = self.todos[sourceIndexPath.row];
    [self.todos removeObjectAtIndex:sourceIndexPath.row];
    [self.todos insertObject:todoToMove atIndex:destinationIndexPath.row];
    
}




#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *passedTodo = self.todos[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem:passedTodo];
    }
    else if ([segue.identifier isEqualToString:@"AddItem"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        AddItemViewController *addItemViewController = [navigationController viewControllers][0];
        addItemViewController.delegate = self;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.todos.count;
    }
    else{
        return self.completedTodos.count;
    }
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return @"Todos";
    }
    else{
        return @"Completed";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MM-yyy HH:mm"];
    
    if (indexPath.section == 0) {
        Todo *todo = self.todos[indexPath.row];
        //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        //        [dateFormatter setDateFormat:@"dd-MM-yyy HH:mm"];
        NSString *deadlineString = [dateFormatter stringFromDate:todo.deadLine];
        
        if (todo.completed) {
            NSDictionary * attributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
            NSAttributedString *titleLabelFinished = [[NSAttributedString alloc]initWithString:todo.name attributes:attributes];
            NSAttributedString *descriptionLabelFinished = [[NSAttributedString alloc]initWithString:todo.todoDescription attributes:attributes];
            NSString *priorityString = [NSString stringWithFormat:@"%ld", todo.priority];
            NSAttributedString *priorityLabelFinished = [[NSAttributedString alloc]initWithString:priorityString attributes:attributes];
            NSAttributedString *deadlineLabelFinished = [[NSAttributedString alloc]initWithString:deadlineString attributes:attributes];
            cell.titleLabel.attributedText = titleLabelFinished;
            cell.descriptionLabel.attributedText = descriptionLabelFinished;
            cell.priorityLabel.attributedText = priorityLabelFinished;
            cell.deadlineLabel.attributedText = deadlineLabelFinished;
        }
        else{
            cell.titleLabel.text = todo.name;
            cell.descriptionLabel.text = todo.todoDescription;
            cell.priorityLabel.text = [NSString stringWithFormat:@"%ld",todo.priority];
            cell.deadlineLabel.text = deadlineString;
        }
    }
    else{
        Todo *todo = self.completedTodos[indexPath.row];
        NSString *deadlineString = [dateFormatter stringFromDate:todo.deadLine];
        NSDictionary *attributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
        NSAttributedString *titleLabelFinished = [[NSAttributedString alloc]initWithString:todo.name attributes:attributes];
        NSAttributedString *descriptionLabelFinished = [[NSAttributedString alloc]initWithString:todo.todoDescription attributes:attributes];
        NSString *priorityString = [NSString stringWithFormat:@"%ld", todo.priority];
        NSAttributedString *priorityLabelFinished = [[NSAttributedString alloc]initWithString:priorityString attributes:attributes];
        NSAttributedString *deadlineLabelFinished = [[NSAttributedString alloc]initWithString:deadlineString attributes:attributes];
        cell.titleLabel.attributedText = titleLabelFinished;
        cell.descriptionLabel.attributedText = descriptionLabelFinished;
        cell.priorityLabel.attributedText = priorityLabelFinished;
        cell.deadlineLabel.attributedText = deadlineLabelFinished;
    }
    
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

//-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
//    UITableView *tableview =
//
//}


#pragma mark - Add Item delegate methods

-(void)todoAddItemCancel:(AddItemViewController*)controller{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)todoAddItemViewController:(Todo *)controller didAddTodo:(Todo *)todo{
    [self.todos addObject:todo];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.todos count] - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




//    if (!self.todos) {
//        self.todos = [[NSMutableArray alloc] init];
//    }
//    [self.objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
@end
