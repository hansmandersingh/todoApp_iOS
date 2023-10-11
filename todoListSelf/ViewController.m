//
//  ViewController.m
//  todoListSelf
//
//  Created by Hansmander Singh on 2023-10-11.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"todoList";
    
    UITextField *textBox = [[UITextField alloc] init];
    textBox.backgroundColor = [UIColor lightGrayColor];
    textBox.borderStyle = UITextBorderStyleRoundedRect;
    textBox.textColor = [UIColor whiteColor];
    textBox.text = @"Please enter a todo task";
    textBox.textAlignment = NSTextAlignmentCenter;
    textBox.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:textBox];
    
    [textBox.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10].active = YES;
    [textBox.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [textBox.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor  constant:-10].active = YES;
}


@end
