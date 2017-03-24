//
//  PygLatinTranslator.m
//  Challenge-PygLatin
//
//  Created by Sergio Utama on 16/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import "PygLatinTranslator.h"

@implementation PygLatinTranslator

- (NSInteger)vowelIndexOfString:(NSString *)string; {
    
    for (NSInteger i = 0; i < string.length; i++) {
        
        NSRange nextRange = NSMakeRange(i, 1);
        NSString *nextLetter = [string substringWithRange:nextRange];
        
        if ([self isVowel:nextLetter]){
            return i;
        }
    }
    
    return -1;
}

- (BOOL)isVowel:(NSString *)string; {
    
    NSString *vowel = @"aiueo";
    NSString *normalizedString = [string lowercaseString];
    NSRange range = [vowel rangeOfString:normalizedString];
    
    if (range.location < vowel.length) {
        return YES;
    }
    return NO;
}

- (NSString *)pygLatinFrom:(NSString *)string atIndex:(NSInteger)index; {
    
    if (index < 0) {
        return [NSString stringWithFormat:@"%@ay",string];
    }
    
    if (index == 0){
        return string;
    }
    
    NSString *beforeVowel = [string substringToIndex:index];
    NSString *afterVowel = [string substringFromIndex:index];
    NSString *finalWords = [NSString stringWithFormat:@"%@%@ay",afterVowel,beforeVowel];
    return finalWords;
}

@end

@implementation RomanTranslator


@end
