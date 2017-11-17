//
//  SKEditTableViewCell.h
//  SKEditCell
//
//  Created by songkang on 2017/11/17.
//  Copyright © 2017年 songkang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKEditTableViewCell : UITableViewCell
@property (nonatomic, copy) void (^moveTopBtnBlock)(void);/**< 置顶回调 */
@property (nonatomic, copy) void (^remindBtnBlock)(NSString *fundName,NSString *fundCode);/**< 提醒回调 */
- (void)configTitle:(NSString *)title;
@end
