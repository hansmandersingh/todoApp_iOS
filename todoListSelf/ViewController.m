//
//  ViewController.m
//  todoListSelf
//
//  Created by Hansmander Singh on 2023-10-11.
//

#import "ViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *todoArray;
}

@property (nonatomic) UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"todoList";
    todoArray = [[NSMutableArray alloc]initWithObjects:@"ABC",@"XYZ", nil];
    
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
    UIBarButtonItem *EditButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(isEditingTable:)];
    [self.navigationItem setRightBarButtonItem:EditButton];
    [self.view addSubview:self.table];
    
    [self addConstraints:textBox withTable:self.table];
}

-(void)isEditingTable:(UIBarButtonItem *)item {
    if(![_table isEditing]) {
        item.title = @"Done";
        [_table setEditing:YES animated:YES];
    } else {
        item.title = @"Edit";
        [_table setEditing:NO animated:YES];
    }
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
    textField.text = @"";
    [self.table reloadData];
    [self resignFirstResponder];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }
    
    cell.textLabel.text = [todoArray objectAtIndex:indexPath.row];
    return cell;
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
        [tableView reloadData];
    }
}

@end
