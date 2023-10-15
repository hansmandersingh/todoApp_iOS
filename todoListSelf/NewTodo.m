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
    self.view.backgroundColor = [UIColor whiteColor];
    _todoTitleField = [[UITextField alloc] init];
    _todoTitleField.backgroundColor = [UIColor lightGrayColor];
    _todoTitleField.borderStyle = UITextBorderStyleRoundedRect;
    _todoTitleField.textColor = [UIColor whiteColor];
    _todoTitleField.placeholder = @"Please enter a todo";
    _todoTitleField.textAlignment = NSTextAlignmentCenter;
    _todoTitleField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_todoTitleField];
    [self addConstraints:_todoTitleField];
    
    NSString *isitWorking = @"chall pya";
    [self.delegate addItemViewController:self didFinishEnteringItem:isitWorking];
}

-(void)addConstraints:(UITextField *)todoTitleField {
    [todoTitleField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:5].active = YES;
    [todoTitleField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-5].active = YES;
    [todoTitleField.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10].active = YES;
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
