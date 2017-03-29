//
//  Student+CoreDataProperties.h
//  SimpleCoreData
//
//  Created by Sergio Utama on 29/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *gender;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, retain) Teacher *teacher;

@end

NS_ASSUME_NONNULL_END
