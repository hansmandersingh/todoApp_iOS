//
//  NewTodo.m
//  todoListSelf
//
//  Created by Hansmander Singh on 2023-10-14.
//

#import "NewTodo.h"

@interface NewTodo ()

@end

@implementation NewTodo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Add Todo"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissVC)] ;
    
    //Added titleText
    _todoTitleView = [self createATextView:@"Add a title for todo: "];
    [self.view addSubview:_todoTitleView];
    
    //Added title Field
    _todoTitleField = [[UITextField alloc] init];
    _todoTitleField = [self createATextField:_todoTitleField withPlaceholder:@"Enter a todo title"];
    [self.view addSubview:_todoTitleField];
    
    //Added Description View
    _todoDescriptionView = [self createATextView:@"Add a description: "];
    [self.view addSubview:_todoDescriptionView];
    
    //Added description Field
    _todoDescriptionField = [[UITextField alloc] init];
    _todoDescriptionField = [self createATextField:_todoDescriptionField withPlaceholder:@"Please enter a description"];
    [self.view addSubview:_todoDescriptionField];
    
    //AddButton
    _addButton = [[UIButton alloc] init];
    [_addButton setTitle:@"Add" forState:UIControlStateNormal];
    _addButton.titleLabel.textColor = [UIColor whiteColor];
    _addButton.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    _addButton.backgroundColor = [UIColor systemBlueColor];
    _addButton.layer.cornerRadius = 10;
    [_addButton addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _addButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_addButton];
    
    [self addConstraints:_todoTitleField withTitle:_todoTitleView withDescriptionView:_todoDescriptionView withDescriptionTextField:_todoDescriptionField withButton:_addButton];
    
}

-(void)addButtonPressed {
    if (![_todoTitleField.text isEqual:@""]) {
        NSString *title = _todoTitleField.text;
        NSString *description;
        
        if ([_todoDescriptionField isEqual:@""]) {
            description = @"";
        } else {
            description = _todoDescriptionField.text;
        }
        
        [self.delegate addItemViewController:self todoTitle:title todoDescription:description];
        
        [self dismissVC];
    } else {
        UIAlertController *emptyFieldAlert = [UIAlertController alertControllerWithTitle:@"Empty Fields" message:@"Forgot to enter title for todo" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [emptyFieldAlert addAction:okButton];
        [self presentViewController:emptyFieldAlert animated:YES completion:nil];
    }
}

-(UITextField *)createATextField:(UITextField *) returningTextField withPlaceholder: (NSString *)text {
    returningTextField.backgroundColor = [UIColor lightGrayColor];
    returningTextField.borderStyle = UITextBorderStyleRoundedRect;
    returningTextField.textColor = [UIColor whiteColor];
    returningTextField.placeholder = text;
    returningTextField.textAlignment = NSTextAlignmentCenter;
    returningTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    return returningTextField;
}

-(UITextView *)createATextView:(NSString *)text {
    UITextView *returningView = [[UITextView alloc] init];
    returningView.text = text;
    returningView.font = [UIFont boldSystemFontOfSize:20];
    returningView.backgroundColor = [UIColor whiteColor];
    returningView.editable = NO;
    returningView.scrollEnabled = NO;
    returningView.textColor = [UIColor blackColor];
    returningView.translatesAutoresizingMaskIntoConstraints = NO;
    
    return returningView;
}

-(void)dismissVC {
    _todoTitleField.text = @"";
    _todoDescriptionField.text = @"";
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addConstraints:(UITextField *)todoTitleField withTitle:(UITextView *)todoTitleView withDescriptionView:(UITextView *)todoDescriptionView withDescriptionTextField: (UITextField *)todoDescriptionField withButton:(UIButton *)addButton {
    //todoView
    [todoTitleView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:17].active = YES;
    [todoTitleView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-17].active = YES;
    [todoTitleView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:17].active = YES;
    
    //todoTextField
    [todoTitleField.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:17].active = YES;
    [todoTitleField.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-17].active = YES;
    [todoTitleField.topAnchor constraintEqualToAnchor:todoTitleView.bottomAnchor constant:10].active = YES;
    
    [todoDescriptionView.topAnchor constraintEqualToAnchor:todoTitleField.bottomAnchor constant:10].active = YES;
    [todoDescriptionView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:17].active= YES;
    [todoDescriptionView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-17].active = YES;
    
    [todoDescriptionField.topAnchor constraintEqualToAnchor:todoDescriptionView.bottomAnchor constant:10].active = YES;
    [todoDescriptionField.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:17].active = YES;
    [todoDescriptionField.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-17].active = YES;
    
    [addButton.topAnchor constraintEqualToAnchor:_todoDescriptionField.bottomAnchor constant:10].active = YES;
    [addButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [addButton.widthAnchor constraintEqualToConstant:70].active = YES;
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
