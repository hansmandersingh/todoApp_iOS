//
//  ViewController.m
//  todoListSelf
//
//  Created by Hansmander Singh on 2023-10-11.
//

#import "ViewController.h"
#import "NewTodo.h"
#import "CustomTodo.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,NewTodoDelegate> 

@property (nonatomic) UITableView *table;
@property (nonatomic, retain) UIButton * addButton;

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
    //[self.view addSubview:textBox];
    
    [textBox addTarget:self action:@selector(byPressingEnter:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    //tableview to add todo to
    self.table = [[UITableView alloc] init];
    
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.translatesAutoresizingMaskIntoConstraints = NO;
    //Adding Edit button
    
    self.navigationItem.rightBarButtonItem = [self editButtonItem];
    
    [self.view addSubview:self.table];
    
    //Adding plus Button here
    self.addButton = [[UIButton alloc] init];
    self.addButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.addButton setTitle:@"+" forState:UIControlStateNormal];
    self.addButton.backgroundColor = [UIColor systemBlueColor];
    self.addButton.titleLabel.backgroundColor = [UIColor systemBlueColor];
    self.addButton.layer.cornerRadius = 32;
    [self.addButton.titleLabel setFont:[UIFont systemFontOfSize:40]];
    self.addButton.titleLabel.numberOfLines = 0;
    [self.addButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    self.addButton.titleLabel.lineBreakMode = NSLineBreakByClipping;
    [self.addButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.addButton];
    
    [self addConstraints:textBox withTable:self.table withButton:self.addButton];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];

    [_table setEditing:editing animated:animated];
}

-(void)addConstraints: (UITextField *)textBox withTable: (UITableView *)table withButton:(UIButton *)addButton {
    //for textField
    
    
    //for table
    [table.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant: 10].active = YES;
    [table.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:9].active = YES;
    [table.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-17].active = YES;
    [table.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10].active = YES;
    
    //for add button
    [addButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-15].active = YES;
    [addButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-15].active = YES;
    [addButton.widthAnchor constraintEqualToConstant:70].active = YES;
    [addButton.heightAnchor constraintEqualToConstant:70].active = YES;
}

- (void)addItemViewController:(NewTodo *)controller todoTitle:(NSString *)todoTitle todoDescription:(NSString *)todoDescription {
    NSLog(@"%@ \n %@",todoTitle, todoDescription);
    [todoArray addObject:todoTitle];
    [todoDescriptionArray addObject:todoDescription];
    [self.table reloadData];
}

-(void)buttonPressed{
    NewTodo *newTodoPage = [[NewTodo alloc] init];
    newTodoPage.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:newTodoPage];
    
    [self presentViewController:navController animated:YES completion:^{
        
    }];
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
        [newText addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = [self->todoDescriptionArray objectAtIndex:indexPath.row];
        }];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(![[newText.textFields[0] text] isEqualToString:@""]) {
                [self->todoArray replaceObjectAtIndex:indexPath.row withObject:[newText.textFields[0] text]];
                [self->todoDescriptionArray replaceObjectAtIndex:indexPath.row withObject:[newText.textFields[1] text]];
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
