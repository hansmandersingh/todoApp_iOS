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
        [self addSubview:self.todoName];
        
        [self todoNameConstraints:_todoName];
    }
    return self;
}

-(void)todoNameConstraints:(UILabel *)todoName {
    [todoName.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;
    [todoName.topAnchor constraintEqualToAnchor:self.topAnchor constant:5].active = YES;
    [todoName.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5].active = YES;
    [todoName.heightAnchor constraintEqualToConstant:30].active = YES;
}

@end
