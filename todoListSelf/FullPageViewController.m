//
//  FullPageViewController.m
//  todoListSelf
//
//  Created by Hansmander Singh on 2023-10-15.
//

#import "FullPageViewController.h"

@interface FullPageViewController ()

@end

@implementation FullPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.addTitle;
    
    self.descriptionView = [[UITextView alloc] init];
    _descriptionView.text = self.addDescription;
    _descriptionView.font = [UIFont systemFontOfSize:20];
    [_descriptionView setEditable:NO];
    _descriptionView.textColor = [UIColor blackColor];
    _descriptionView.backgroundColor = [UIColor whiteColor];
    _descriptionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_descriptionView];
    // Do any additional setup after loading the view.
    
    [self setupConstraints];
}

-(void)setupConstraints {
    [_descriptionView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:17].active = YES;
    [_descriptionView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-17].active = YES;
    [_descriptionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10].active = YES;
    [_descriptionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10].active = YES;
}


@end
