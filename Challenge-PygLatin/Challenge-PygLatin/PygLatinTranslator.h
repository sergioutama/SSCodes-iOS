//
//  PygLatinTranslator.h
//  Challenge-PygLatin
//
//  Created by Sergio Utama on 16/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PygLatinTranslator : NSObject

- (NSInteger)vowelIndexOfString:(NSString *)string;
- (BOOL)isVowel:(NSString *)string;
- (NSString *)pygLatinFrom:(NSString *)string atIndex:(NSInteger)index;

@end


@interface RomanTranslator : NSObject

@end
