//
//  SecondViewController.m
//  FunControllers
//
//  Created by Sergio Utama on 24/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonDismiss;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.buttonDismiss addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonNext addTarget:self action:@selector(displayNextController) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)dismissViewController {
   
    
    if (self.delegate){
        [self.delegate willDismissController:self];
    }
    
    // Use this following carefully
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)displayNextController {
    
    ThirdViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ThirdViewController"];
    [self.navigationController pushViewController:controller animated:YES];
    
}












@end
