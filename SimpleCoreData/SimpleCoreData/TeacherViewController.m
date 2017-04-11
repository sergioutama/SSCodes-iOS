//
//  TeacherViewController.m
//  SimpleCoreData
//
//  Created by Sergio Utama on 29/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import "TeacherViewController.h"
#import "Teacher+CoreDataClass.h"
#import "Student+CoreDataClass.h"
#import "CoreDataManager.h"
#import "ViewController.h"

typedef NS_ENUM(NSUInteger, DataState) {
    DataStateFetched,
    DataStateIntialized
};

@interface TeacherViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *teachers;
@property (strong, nonatomic) NSManagedObjectContext *context;

@property (assign, nonatomic) DataState dataState;

@end

@implementation TeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

    [self fetchTeachers];
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupUI {
    
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] init];
    
    [barButtonAdd setTarget:self];
    [barButtonAdd setAction:@selector(buttonAddTapped:)];
    
    
    
    
    
    
    
    
    
    
    [self.buttonAdd addTarget:self action:@selector(buttonAddTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.context = [[CoreDataManager shared] managedObjectContext];
    
    
    
}

#pragma mark - Actions
- (void)buttonAddTapped:(UIButton *)sender {
    // save to database
    Teacher *newTeacher = (Teacher *)[NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:self.context];
    
    newTeacher.name = self.textField.text;
    
    NSError *saveError = NULL;
    [self.context save:&saveError];
    if (saveError) {
        NSLog(@"ErrorSaving %@ | Description : %@ | Reason : %@",self.textField.text,saveError.localizedDescription,saveError.localizedFailureReason);
        return;
    }
    
    [self fetchTeachers];
    [self.tableView reloadData];
    
}

- (void)fetchTeachers {
    // fetch all the teachers
    
    NSFetchRequest *teacherFetchRequest = [Teacher fetchRequest];
    
    NSError *fetchError = NULL;
    NSArray *fetchedObjects = [self.context executeFetchRequest:teacherFetchRequest error:&fetchError];
    
    if (fetchError) {
        NSLog(@"ErrorFethcing | Description : %@ | Reason : %@",fetchError.localizedDescription,fetchError.localizedFailureReason);
        return;
    }
    
    self.teachers = fetchedObjects;
}


#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teachers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherCell" forIndexPath:indexPath];
    
    
    Teacher *teacher = self.teachers[indexPath.row];// get teacher
    
    cell.textLabel.text = teacher.name; // set teacher name
    
    // get all students name
    NSMutableString *allStudentsName = [@"" mutableCopy];
    for (Student *student in teacher.student) {
        [allStudentsName appendFormat:@"%@ ",student.name];
    }
    
    cell.detailTextLabel.text = allStudentsName; // set all students name
    
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Teacher *selectedTeacher = self.teachers[indexPath.row];
    
    ViewController *controller = (ViewController *)[self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ViewController class])];
    
    controller.currentTeacher = selectedTeacher;
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

















@end
