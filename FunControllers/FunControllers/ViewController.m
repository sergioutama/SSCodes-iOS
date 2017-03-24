//
//  ViewController.m
//  FunControllers
//
//  Created by Sergio Utama on 24/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController () <SecondViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@property (weak, nonatomic) IBOutlet UIButton *buttonNextNav;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.buttonNext addTarget:self action:@selector(displayNextController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonNextNav addTarget:self action:@selector(displayNextNavController) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)displayNextController {

    // display the next controller programatically

// Use it when the view controller was created programatically
//    SecondViewController *controller = [[SecondViewController alloc] init];
    
    
// Can only be use when the view controller to present is in the same storyboard
//    [self.storyboard instantiateViewControllerWithIdentifier:@""];
    
    // if it's not in the same storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SecondViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    
    controller.delegate = self;
    controller.name = @"Sergio";

    [self presentViewController:controller animated:YES completion:NULL];

}

- (void)displayNextNavController {

    SecondViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SecondViewController class])];
    controller.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [self presentViewController:navController animated:YES completion:NULL];

}




#pragma mark - SecondViewController Delegate
- (void)willDismissController:(SecondViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


















@end
