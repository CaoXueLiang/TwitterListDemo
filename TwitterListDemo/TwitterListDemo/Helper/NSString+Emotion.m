//
//  NSString+Emotion.m
//  TwitterListDemo
//
//  Created by bjovov on 2017/11/29.
//  Copyright © 2017年 Cao Xueliang. All rights reserved.
//

#import "NSString+Emotion.h"
#import <YYText/YYText.h>
#import "EmoticonHelper.h"

@implementation NSString (Emotion)
- (NSMutableAttributedString *)convertToEmotionWithFont:(UIFont *)font{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:self];
    {
        NSArray<NSTextCheckingResult *> *emoticonResults = [[EmoticonHelper regexEmoticon] matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
        NSUInteger clipLength = 0;
        for (NSTextCheckingResult *emo in emoticonResults) {
            if (emo.range.location == NSNotFound && emo.range.length <= 1) continue;
            NSRange range = emo.range;
            range.location -= clipLength;
            if ([text yy_attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
            
            NSLog(@"%@--%@",emo,NSStringFromRange(range));
//            NSString *emoString = [text.string substringWithRange:range];
//            NSString *imagePath = [EmoticonHelper emoticonDic][emoString];
//            UIImage *image = [EmoticonHelper imageWithPath:imagePath];
//            if (!image) continue;
//
//            __block BOOL containsBindingRange = NO;
//            [text enumerateAttribute:YYTextBindingAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
//                if (value) {
//                    containsBindingRange = YES;
//                    *stop = YES;
//                }
//            }];
//            if (containsBindingRange) continue;
//
//
//            YYTextBackedString *backed = [YYTextBackedString stringWithString:emoString];
//            NSMutableAttributedString *emoText = [NSAttributedString yy_attachmentStringWithEmojiImage:image fontSize:font.pointSize].mutableCopy;
//            [emoText yy_setTextBackedString:backed range:NSMakeRange(0, emoText.length)];
//            [emoText yy_setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:NSMakeRange(0, emoText.length)];
//
//            [text replaceCharactersInRange:range withAttributedString:emoText];
        }
    }
    return text;
}

@end

