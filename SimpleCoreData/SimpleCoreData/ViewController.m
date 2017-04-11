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



@interface ViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *students;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
//    [self fetchData];
    [self setupUI];
//    [self.tableView reloadData];
}

#pragma mark - Setup

- (void)setupUI {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.buttonAdd addTarget:self action:@selector(buttonAddTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupData {

    self.managedObjectContext = [[CoreDataManager shared] managedObjectContext];
    
    NSFetchRequest *studentFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    
    // set predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teacher.name == %@",self.currentTeacher.name];
    [studentFetchRequest setPredicate:predicate];
    
    // sort
    NSSortDescriptor *sortDecriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [studentFetchRequest setSortDescriptors:@[sortDecriptor]];
    

    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:studentFetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:NULL cacheName:NULL];
    
    self.fetchedResultsController.delegate = self;
    NSError *fetchControllerError = NULL;
    [self.fetchedResultsController performFetch:&fetchControllerError];
    
    if (fetchControllerError) {
        NSLog(@"FetchController Error : %@",fetchControllerError);
    }
    
}

#pragma mark - Actions
- (void)buttonAddTapped:(UIButton *)sender {

    [self createNewStudent];
//    [self fetchData];
//    [self.tableView reloadData];

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
//    return self.students.count;
    
    // check the sorting using switch
    
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell" forIndexPath:indexPath];
    
//    Student *student = self.students[indexPath.row];
    Student *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = student.name;
    
    return  cell;
}


#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}



#pragma mark - NSFetchedResultsController Delegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {

    [self.tableView beginUpdates];
    
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
        {
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        case NSFetchedResultsChangeDelete:
        {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
            break;
        case NSFetchedResultsChangeMove:
        {
            [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
        }
            break;
        case NSFetchedResultsChangeUpdate:
        {
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
    }
 

    [self.tableView endUpdates];

}





























@end
