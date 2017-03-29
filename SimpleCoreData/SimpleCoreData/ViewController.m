//
//  ViewController.m
//  SimpleCoreData
//
//  Created by Sergio Utama on 29/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ViewController.h"
#import "AppDelegate.h"
#import "Student+CoreDataClass.h"

@interface ViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *fetchedStudents;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCoreData];
    [self setupUI];
    [self fetchCoreData];
    [self.tableView reloadData];
}

#pragma mark - Setup

- (void)setupUI {
    self.tableView.dataSource = self;
    [self.buttonAdd addTarget:self action:@selector(buttonAddTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupCoreData {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
}


#pragma mark - Actions
- (void)buttonAddTapped:(UIButton *)sender {

    
    Student *newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    newStudent.name = self.textField.text;
    
    NSError *saveError = NULL;
    [self.managedObjectContext save:&saveError];
    if (saveError) {
        NSLog(@"Error saving to CoreData : %@, because : %@",saveError.localizedDescription,saveError.localizedFailureReason);
        return;
    }
    
    [self fetchCoreData];
    [self.tableView reloadData];

}

- (void)fetchCoreData {
    
    NSFetchRequest *studentFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    
    NSError *fetchError = NULL;
    NSArray *fetchResults = [self.managedObjectContext executeFetchRequest:studentFetchRequest error:&fetchError];
    if (fetchError) {
        NSLog(@"Error fetching from to CoreData : %@, because : %@",fetchError.localizedDescription,fetchError.localizedFailureReason);
        return;
    }
    self.fetchedStudents = fetchResults;
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedStudents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell" forIndexPath:indexPath];
    
    Student *student = self.fetchedStudents[indexPath.row];
    cell.textLabel.text = student.name;
    
    return  cell;
}

@end
