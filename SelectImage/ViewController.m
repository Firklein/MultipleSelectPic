//
//  ViewController.m
//  SelectImage
//
//  Created by csj on 2019/7/19.
//  Copyright © 2019 csj. All rights reserved.
//

#import "ViewController.h"
#import "AddImageVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)goPage:(id)sender {
    AddImageVC *addVC = [[AddImageVC alloc] init];
    [self presentViewController:addVC animated:YES completion:nil];
}

@end
