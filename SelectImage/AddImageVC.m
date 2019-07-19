//
//  AddImageVC.m
//  SelectImage
//
//  Created by csj on 2019/7/19.
//  Copyright © 2019 csj. All rights reserved.
//

#import "AddImageVC.h"
#import "HYSelectImagesView.h"
#import "HYSelectImagesCell.h"

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)

@interface AddImageVC ()

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, assign) NSInteger cellHeight;
@property (nonatomic, strong) HYSelectImagesView *selectView;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableArray *urlArray;

@end

@implementation AddImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self initWithTable];
    [self initWithData];
    [self initWithSelectImage];
}

- (void)initWithTable {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HYSelectImagesCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HYSelectImagesCell class])];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = NO;
    self.tableView.sectionHeaderHeight = 0.01;
    self.tableView.sectionFooterHeight = 0.01;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)initWithData{
    self.urlArray = [[NSMutableArray alloc] init];
    self.itemSize = CGSizeMake((kScreenW-4*10)/3, (kScreenW-4*10)/3);
}

- (void)initWithSelectImage {
    //九宫格图片选择器
    self.cellHeight = 180;
    self.selectView = [[NSBundle mainBundle] loadNibNamed:@"HYSelectImagesView" owner:nil options:nil].firstObject;
    self.selectView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.cellHeight - 30);
    self.selectView.imgViewController = self;
    __weak typeof(self) weakSelf = self;
    [self.selectView setImgHandler:^(NSMutableArray * _Nonnull images) {
        NSLog(@"选择的图片:%@",images);
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i = 0; i < images.count; i++) {
                UIImage *img = [images objectAtIndex:i];
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
                NSString *name = @"img";
                NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%d.jpg", name,i]];   // 保存文件的名称
                NSLog(@"imagePath = %@", filePath);
                // 保存成功会返回YES
                BOOL result = [UIImageJPEGRepresentation(img, 1.0) writeToFile:filePath atomically:YES];
                if (result) {
                    NSLog(@"%d", result);
                    [weakSelf.imgArray addObject:filePath];
                    //删除掉存在本地的图片
                    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                }
            }
            [weakSelf updateImage];
            if (images.count <= 3) {
                weakSelf.cellHeight = 180;
            } else if (images.count <= 6) {
                weakSelf.cellHeight = 310;
            } else if (images.count <= 9) {
                weakSelf.cellHeight = 440;
            }
            [weakSelf.tableView reloadData];
        });
    }];
    self.selectView.backgroundColor = [UIColor whiteColor];
}

- (void)updateImage {
    if (self.imgArray.count > 0) {
    } else {
        NSDictionary *dict = @{@"image":self.urlArray};
        NSLog(@"上传的图片：%@",dict);
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYSelectImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HYSelectImagesCell class]) forIndexPath:indexPath];
    cell.conView.backgroundColor = [UIColor whiteColor];
    self.selectView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.cellHeight - 30);
    [cell.conView addSubview:self.selectView];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FLT_EPSILON;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
