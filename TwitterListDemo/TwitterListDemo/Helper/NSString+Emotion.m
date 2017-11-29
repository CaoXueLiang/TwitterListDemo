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
    
    // 匹配 [表情]
    NSArray<NSTextCheckingResult *> *emoticonResults = [[EmoticonHelper regexEmoticon] matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
    NSUInteger emoClipLength = 0;
    for (NSTextCheckingResult *emo in emoticonResults) {
        if (emo.range.location == NSNotFound && emo.range.length <= 1) continue;
        NSRange range = emo.range;
        range.location -= emoClipLength;
        if ([text yy_attribute:YYTextHighlightAttributeName atIndex:range.location]) continue;
        if ([text yy_attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
        NSString *emoString = [text.string substringWithRange:range];
        NSString *imagePath = [EmoticonHelper emoticonDic][emoString];
        UIImage *image = [EmoticonHelper imageWithPath:imagePath];
        if (!image) continue;
        
        NSAttributedString *emoText = [NSAttributedString yy_attachmentStringWithEmojiImage:image fontSize:font.pointSize];
        [text replaceCharactersInRange:range withAttributedString:emoText];
        emoClipLength += range.length - 1;
    }
    
    return text;
}

@end

