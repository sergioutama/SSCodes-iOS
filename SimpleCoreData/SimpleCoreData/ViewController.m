//
//  ViewController.m
//  SimpleCoreData
//
//  Created by Sergio Utama on 29/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ViewController.h"
#import "Student+CoreDataClass.h"
#import "CoreDataManager.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *students;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self fetchData];
    [self setupUI];
    [self.tableView reloadData];
}

#pragma mark - Setup

- (void)setupUI {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.buttonAdd addTarget:self action:@selector(buttonAddTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupData {

    self.managedObjectContext = [[CoreDataManager shared] managedObjectContext];
}

#pragma mark - Actions
- (void)buttonAddTapped:(UIButton *)sender {

    [self createNewStudent];
    [self fetchData];
    [self.tableView reloadData];

}

- (void)createNewStudent {
    
    Student *newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    newStudent.name = self.textField.text;
    
    // Establish relationship
    newStudent.teacher = self.currentTeacher;
    
    
    NSError *saveError = NULL;
    [self.managedObjectContext save:&saveError];
    if (saveError) {
        NSLog(@"Error saving to CoreData : %@, because : %@",saveError.localizedDescription,saveError.localizedFailureReason);
        return;
    }
    
}

- (void)fetchData {
    
    NSFetchRequest *studentFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    
    
    // set predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teacher.name == %@",self.currentTeacher.name];
    [studentFetchRequest setPredicate:predicate];
    
    // sort
    NSSortDescriptor *sortDecriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [studentFetchRequest setSortDescriptors:@[sortDecriptor]];
    
    NSError *fetchError = NULL;
    
    NSArray *fetchResults = [self.managedObjectContext executeFetchRequest:studentFetchRequest error:&fetchError];
    
    if (fetchError) {
        NSLog(@"Error fetching from to CoreData : %@, because : %@",fetchError.localizedDescription,fetchError.localizedFailureReason);
        return;
    }
    
    
    self.students = fetchResults;
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.students.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell" forIndexPath:indexPath];
    
    Student *student = self.students[indexPath.row];
    cell.textLabel.text = student.name;
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
