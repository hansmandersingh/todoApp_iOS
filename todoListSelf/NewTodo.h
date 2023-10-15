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

- (void)addItemViewController:(NewTodo *)controller didFinishEnteringItem:(NSString *)item;

@end



@interface NewTodo : UIViewController

@property (nonatomic, weak) id <NewTodoDelegate> delegate;
@property (nonatomic, retain) UITextField *todoTitleField;
@property (nonatomic, retain) UITextField *todoDescriptionField;

@end

NS_ASSUME_NONNULL_END
