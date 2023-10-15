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
    _todoTitleField.backgroundColor = [UIColor lightGrayColor];
    _todoTitleField.borderStyle = UITextBorderStyleRoundedRect;
    _todoTitleField.textColor = [UIColor whiteColor];
    _todoTitleField.placeholder = @"Please enter a todo";
    _todoTitleField.textAlignment = NSTextAlignmentCenter;
    _todoTitleField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_todoTitleField];
    
    //Added Description View
    _todoDescriptionView = [self createATextView:@"Add a description: "];
    [self.view addSubview:_todoDescriptionView];
    
    
    [self addConstraints:_todoTitleField withTitle:_todoTitleView withDescriptionView:_todoDescriptionView];
    
    NSString *isitWorking = @"chall pya";
    [self.delegate addItemViewController:self didFinishEnteringItem:isitWorking];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addConstraints:(UITextField *)todoTitleField withTitle:(UITextView *)todoTitleView withDescriptionView:(UITextView *)todoDescriptionView {
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
