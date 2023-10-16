//
//  CustomTodo.m
//  todoListSelf
//
//  Created by Hansmander Singh on 2023-10-12.
//

#import "CustomTodo.h"

@implementation CustomTodo

- (id)initWithStyle: (UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.todoName = [[UILabel alloc] init];
        self.todoName.font = [UIFont boldSystemFontOfSize:19];
        self.todoName.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.todoName];
        
        self.todoDescription = [[UILabel alloc] init];
        self.todoDescription.font = [UIFont systemFontOfSize:15];
        self.todoDescription.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.todoDescription];
        
        self.fullPageButton = [[UIButton alloc] init];
        [self.fullPageButton setImage:[UIImage systemImageNamed:@"arrow.right"] forState:UIControlStateNormal];
        self.fullPageButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.fullPageButton];
        
        [self todoNameConstraints:_todoName withDescription:_todoDescription withButton:_fullPageButton];
    }
    return self;
}

-(void)todoNameConstraints:(UILabel *)todoName withDescription: (UILabel *)todoDescription withButton:(UIButton *)fullPageButton {
    [todoName.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = YES;
    [todoName.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5].active = YES;
    [todoName.heightAnchor constraintEqualToConstant:30].active = YES;
    
    [todoDescription.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = YES;
    [todoDescription.topAnchor constraintEqualToAnchor:self.todoName.bottomAnchor constant:5].active = YES;
    [todoDescription.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-5].active = YES;
    
    [fullPageButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10].active = YES;
    [fullPageButton.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5].active = YES;
    [fullPageButton.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-5].active = YES;
}

@end
