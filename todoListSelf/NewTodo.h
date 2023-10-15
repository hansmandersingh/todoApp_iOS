//
//  NewTodo.h
//  todoListSelf
//
//  Created by Hansmander Singh on 2023-10-14.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class NewTodo;

@protocol NewTodoDelegate <NSObject>

- (void)addItemViewController:(NewTodo *)controller todoTitle:(NSString *)todoTitle todoDescription:(NSString *)todoDescription;

@end

@interface NewTodo : UIViewController

@property (nonatomic, weak) id <NewTodoDelegate> delegate;
@property (nonatomic, retain) UITextView *todoTitleView;
@property (nonatomic, retain) UITextField *todoTitleField;
@property (nonatomic, retain) UITextView *todoDescriptionView;
@property (nonatomic, retain) UITextField *todoDescriptionField;
@property (nonatomic, retain) UIButton *addButton;

@end

NS_ASSUME_NONNULL_END
