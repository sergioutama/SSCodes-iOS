//
//  SecondViewController.h
//  FunControllers
//
//  Created by Sergio Utama on 24/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecondViewController;

@protocol SecondViewControllerDelegate <NSObject>
// - (void)viewController:(SecondViewController *)controller didTapButton:(UIButton *)button;
- (void)willDismissController:(SecondViewController *)controller;
@end

@interface SecondViewController : UIViewController

@property (weak, nonatomic) id<SecondViewControllerDelegate> delegate;

@property (strong, nonatomic) NSString *name;

@end



















