//
//  CustomTodo.h
//  todoListSelf
//
//  Created by Hansmander Singh on 2023-10-12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTodo : UITableViewCell

@property (nonatomic, retain) UILabel *todoName;
@property (nonatomic,retain) UILabel *todoDescription;
@property (nonatomic, retain) UIButton *fullPageButton;

@end

NS_ASSUME_NONNULL_END
