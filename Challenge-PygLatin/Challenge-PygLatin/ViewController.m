//
//  ViewController.m
//  Challenge-PygLatin
//
//  Created by Sergio Utama on 16/03/2017.
//  Copyright © 2017 Sergio Utama. All rights reserved.
//

#import "ViewController.h"
#import "PygLatinTranslator.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *labelTranslated;
@property (weak, nonatomic) IBOutlet UIButton *buttonTranslate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.buttonTranslate addTarget:self action:@selector(translate) forControlEvents:UIControlEventTouchUpInside];
}

- (void)translate; {

    [self convertRoman];
    
    NSString *normalText = self.textField.text;
//    [self translateString:normalText];
//    [self translateString2:normalText];
//    [self translateString3:normalText];
//    [self translateString4:normalText];
    [self translateString5:normalText];
    
//    NSString *vowel = @"aiueo";
//    
//    NSString *firstLetter = [normalText substringToIndex:1];
//    NSRange range = [vowel rangeOfString:firstLetter];
//    
//    if (range.location < vowel.length){
//        NSLog(@"%@",normalText);
//        return;
//    }
//    
//    for (NSUInteger i = 1; i < normalText.length; i++) {
//        NSRange nextRange = NSMakeRange(i, 1);
//        NSString *nextLetter = [normalText substringWithRange:nextRange];
//        
//        if ([vowel rangeOfString:nextLetter].location < vowel.length){
//            
//            // found the next vowel
//            NSString *beforeVowel = [normalText substringToIndex:i];
//            NSString *afterVowel = [normalText substringFromIndex:i];
//            NSString *finalWords = [NSString stringWithFormat:@"%@%@ay",afterVowel,beforeVowel];
//            NSLog(@"%@",finalWords);
//            return;
//            
//        }
//        
//    }
    
}

- (void)translateString:(NSString *)text {

    PygLatinTranslator *translator = [[PygLatinTranslator alloc] init];
    
    for (NSUInteger i = 0; i < text.length; i++) {
        
        NSRange nextRange = NSMakeRange(i, 1);
        NSString *nextLetter = [text substringWithRange:nextRange];
        
        if ([translator isVowel:nextLetter]){
            
            if (i==0){
                NSLog(@"%@",text);
                return;
            }
            
            NSString *beforeVowel = [text substringToIndex:i];
            NSString *afterVowel = [text substringFromIndex:i];
            NSString *finalWords = [NSString stringWithFormat:@"%@%@ay",afterVowel,beforeVowel];
            NSLog(@"%@",finalWords);
            return;
        }
        
    }
    
}

- (void)translateString2:(NSString *)text {
    
    PygLatinTranslator *translator = [[PygLatinTranslator alloc] init];
    
    for (NSUInteger i = 0; i < text.length; i++) {
        
        NSRange nextRange = NSMakeRange(i, 1);
        NSString *nextLetter = [text substringWithRange:nextRange];
        
        if ([translator isVowel:nextLetter]){
            
            if (i==0){
                NSLog(@"%@",text);
                return;
            }
            
            NSLog(@"%@",[translator pygLatinFrom:text atIndex:i]);
            return;
        }
        
    }
}

- (void)translateString3:(NSString *)text {
    
    PygLatinTranslator *translator = [[PygLatinTranslator alloc] init];
    
    for (NSUInteger i = 0; i < text.length; i++) {
        
        NSRange nextRange = NSMakeRange(i, 1);
        NSString *nextLetter = [text substringWithRange:nextRange];
        
        if ([translator isVowel:nextLetter]){
            NSLog(@"%@",[translator pygLatinFrom:text atIndex:i]);
            return;
        }
    }
}

- (void)translateString4:(NSString *)text {
    PygLatinTranslator *translator = [[PygLatinTranslator alloc] init];
    NSLog(@"%@",[translator pygLatinFrom:text atIndex:[translator vowelIndexOfString:text]]);
    return;
    
}

- (void)translateString5:(NSString *)text {
    
    NSArray *texts = [text componentsSeparatedByString:@" "];
    NSMutableString *convertedText = [NSMutableString string];
    PygLatinTranslator *translator = [[PygLatinTranslator alloc] init];
    for (NSString *newText in texts) {
        [convertedText appendFormat:@"%@ ",[translator pygLatinFrom:newText atIndex:[translator vowelIndexOfString:newText]]];
    }
    
    NSLog(@"Converted : %@",convertedText);
    return;
    
}

- (void)convertRoman {

    
    NSUInteger number = [self.textField.text integerValue];
    
    number = 1234;
    // split number to
    NSUInteger ribuan = number / 1000;
    number = number- (ribuan * 1000);
    NSUInteger ratusan = number / 100;
    number = number- (ratusan*100);
    NSUInteger puluhan = number / 10;
    NSUInteger satuan = number - (puluhan * 10);
    
    
    
    // then use this as index to receive from array
    // append all to string

}




@end
