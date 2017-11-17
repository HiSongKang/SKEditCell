//
//  ViewController.m
//  SKEditCell
//
//  Created by songkang on 2017/11/17.
//  Copyright © 2017年 songkang. All rights reserved.
//

#import "ViewController.h"
#import "SKEditTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *editTable;/**< <#注释#> */
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.editTable];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.editTable.frame =self.view.bounds;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKEditTableViewCell *editCell = [tableView dequeueReusableCellWithIdentifier:@"edit"];
    if (!editCell) {
        editCell = [[SKEditTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"edit"];
    }
    [editCell configTitle:[NSString stringWithFormat:@"第%ld行",indexPath.row]];
    return editCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
        return sourceIndexPath;
    }
    return proposedDestinationIndexPath;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSLog(@"排序了");
}
//编辑样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}

- (UITableView *)editTable
{
    if (_editTable) {
        return _editTable;
    }
    
    _editTable = [[UITableView alloc] init];
    _editTable.editing = YES;
    _editTable.delegate = self;
    _editTable.dataSource = self;
    _editTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _editTable.backgroundColor = [UIColor whiteColor];
    [_editTable setEditing:YES animated:NO];
    _editTable.estimatedRowHeight = 0;
    _editTable.estimatedSectionHeaderHeight = 0;
    _editTable.estimatedSectionFooterHeight = 0;
    return _editTable;
}
@end
