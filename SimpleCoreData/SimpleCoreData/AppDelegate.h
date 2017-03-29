//
//  AppDelegate.h
//  SimpleCoreData
//
//  Created by Sergio Utama on 29/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

