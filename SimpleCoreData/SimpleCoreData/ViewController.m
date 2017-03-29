//
//  ViewController.m
//  SimpleCoreData
//
//  Created by Sergio Utama on 29/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - Setup

- (void)setupUI {
    self.tableView.dataSource = self;
    [self.buttonAdd addTarget:self action:@selector(buttonAddTapped:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)buttonAddTapped:(UIButton *)sender {}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell" forIndexPath:indexPath];
    return  cell;
}

@end
