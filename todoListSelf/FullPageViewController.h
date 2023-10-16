//
//  FullPageViewController.h
//  todoListSelf
//
//  Created by Hansmander Singh on 2023-10-15.
//
#import "ViewController.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FullPageViewController : UIViewController

@property (nonatomic, retain) NSString *addTitle;
@property (nonatomic, retain) NSString *addDescription;
@property (nonatomic, retain) UITextView *descriptionView;

@end

NS_ASSUME_NONNULL_END
