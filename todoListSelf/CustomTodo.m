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
        self.todoName.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.todoName];
        
        self.todoDescription = [[UILabel alloc] init];
        self.todoDescription.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.todoDescription];
        
        [self todoNameConstraints:_todoName withDescription:_todoDescription];
    }
    return self;
}

-(void)todoNameConstraints:(UILabel *)todoName withDescription: (UILabel *)todoDescription {
    [todoName.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = YES;
    [todoName.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5].active = YES;
    [todoName.heightAnchor constraintEqualToConstant:30].active = YES;
    
    [todoDescription.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = YES;
    [todoDescription.topAnchor constraintEqualToAnchor:self.todoName.bottomAnchor constant:5].active = YES;
    [todoDescription.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-5].active = YES;
}

@end
