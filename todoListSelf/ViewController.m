//
//  ViewController.m
//  todoListSelf
//
//  Created by Hansmander Singh on 2023-10-11.
//

#import "ViewController.h"
#import "CustomTodo.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *todoArray;
    NSMutableArray *todoDescriptionArray;
}

@property (nonatomic) UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title = @"todoList";
    todoArray = [[NSMutableArray alloc]initWithObjects:@"ABC",@"XYZ", nil];
    todoDescriptionArray = [[NSMutableArray alloc] initWithObjects:@"First three letters", @"last three letters", nil];
    
    //textField to enter text for todo
    UITextField *textBox = [[UITextField alloc] init];
    textBox.backgroundColor = [UIColor lightGrayColor];
    textBox.borderStyle = UITextBorderStyleRoundedRect;
    textBox.textColor = [UIColor whiteColor];
    textBox.placeholder = @"Please enter a todo";
    textBox.textAlignment = NSTextAlignmentCenter;
    textBox.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:textBox];
    
    [textBox addTarget:self action:@selector(byPressingEnter:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    //tableview to add todo to
    self.table = [[UITableView alloc] init];
    
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.translatesAutoresizingMaskIntoConstraints = NO;
    //Adding Edit button
    
    self.navigationItem.rightBarButtonItem = [self editButtonItem];
    
    [self.view addSubview:self.table];
    
    [self addConstraints:textBox withTable:self.table];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];

    [_table setEditing:editing animated:animated];
}

-(void)addConstraints: (UITextField *)textBox withTable: (UITableView *)table {
    //for textField
    [textBox.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:17].active = YES;
    [textBox.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [textBox.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor  constant:-17].active = YES;
    
    //for table
    [table.topAnchor constraintEqualToAnchor:textBox.bottomAnchor constant: 10].active = YES;
    [table.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:9].active = YES;
    [table.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-17].active = YES;
    [table.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10].active = YES;
    
}

-(void)byPressingEnter:(UITextField *) textField {
    [todoArray addObject:textField.text];
    [todoDescriptionArray addObject:@""];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[todoArray count]-1 inSection:0];
    [_table beginUpdates];
    [_table insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_table endUpdates];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *bottomIndexPath = [NSIndexPath indexPathForRow:self->todoArray.count-1 inSection:0];
        [self.table scrollToRowAtIndexPath:bottomIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
    
    textField.text = @"";
    [self.table reloadData];
    [self resignFirstResponder];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CustomTodo *cell = (CustomTodo *)[tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if(cell == nil) {
        cell = [[CustomTodo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }
    
    cell.todoName.text = [todoArray objectAtIndex:indexPath.row];
    cell.todoDescription.text = [todoDescriptionArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return todoArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", (long)indexPath.row);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [todoArray removeObjectAtIndex:indexPath.row];
        [todoDescriptionArray removeObjectAtIndex:indexPath.row];
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
        [tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self tableView:tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
        completionHandler (YES);
    }];
    
    UIContextualAction *editAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Edit" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            NSLog(@"------------------>%@",sourceView);
        UIAlertController *newText = [UIAlertController alertControllerWithTitle:@"Change Todo" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [newText addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = [self->todoArray objectAtIndex:indexPath.row];
        }];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(![[newText.textFields[0] text] isEqualToString:@""]) {
                [self->todoArray replaceObjectAtIndex:indexPath.row withObject:[newText.textFields[0] text]];
                [tableView reloadData];
            }
        }];
        [newText addAction:confirm];
        [self presentViewController:newText animated:YES completion:nil];
        
        
        
            completionHandler (YES);
    }];
    editAction.backgroundColor = [UIColor systemGreenColor];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction,editAction]];
        
    return config;
}

@end
