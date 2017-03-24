//
//  ViewController.m
//  SimpleBrowser
//
//  Created by Sergio Utama on 16/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate> // conform
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *buttonGo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.buttonGo addTarget:self action:@selector(loadURL) forControlEvents:UIControlEventTouchUpInside];
    self.webView.delegate = self; // set
    
}

- (void)loadURL {
    NSURL *URL = [NSURL URLWithString:self.textField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
    
    
}

// implement
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    
    // 1. Create the alert / instance of UIAlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"WebView Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    
    // 2. Create action
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:NULL];
    
    // 3. Add action into alert
    [alert addAction:dismissAction];
    
    // 4. Present alert
    [self presentViewController:alert animated:YES completion:NULL];
    
    
    

    
    
    
}














@end
