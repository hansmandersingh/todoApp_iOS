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
    
    self.title = @"todoList";
    
    UITextField *textBox = [[UITextField alloc] init];
    textBox.backgroundColor = [UIColor lightGrayColor];
    textBox.borderStyle = UITextBorderStyleRoundedRect;
    textBox.textColor = [UIColor whiteColor];
    textBox.placeholder = @"Please enter a todo";
    textBox.textAlignment = NSTextAlignmentCenter;
    textBox.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:textBox];
    
    [self addConstraints:textBox];
}

-(void)addConstraints: (UITextField *)textBox {
    [textBox.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:17].active = YES;
    [textBox.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [textBox.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor  constant:-17].active = YES;
}


@end
