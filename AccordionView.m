/*
    AccordionView.m

    Created by Wojtek Siudzinski on 19.12.2011.
    Copyright (c) 2011 Appsome. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

#import "AccordionView.h"

@implementation AccordionView

@synthesize selectedIndex, isHorizontal, animationDuration, animationCurve;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        views = [NSMutableArray new];
        headers = [NSMutableArray new];
        originalSizes = [NSMutableArray new];
        
        self.backgroundColor = [UIColor clearColor];
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
        scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:scrollView];
        
        selectedIndex = -1;
        
        self.userInteractionEnabled = YES;
        scrollView.userInteractionEnabled = YES;
        
        animationDuration = 0.3;
        animationCurve = UIViewAnimationCurveEaseIn;
    }
    
    return self;
}

- (void)addHeader:(id)aHeader withView:(id)aView {
    if ((aHeader != nil) && (aView != nil)) {
        [headers addObject:aHeader];
        [views addObject:aView];
        [originalSizes addObject:[NSValue valueWithCGSize:[aView frame].size]];
        
        CGRect frame = [aHeader frame];
        
        if (self.isHorizontal) {
            // TODO
        } else {
            frame.origin.x = 0;
            frame.size.width = [self frame].size.width;
            [aHeader setFrame:frame];
            
            frame = [aView frame];
            frame.origin.x = 0;
            frame.size.width = [self frame].size.width;
            [aView setFrame:frame];
        }
        
        [scrollView addSubview:aHeader];
        [scrollView addSubview:aView];
        
        if ([aHeader respondsToSelector:@selector(addTarget:action:forControlEvents:)]) {
            [aHeader setTag:[headers count] - 1];
            [aHeader addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)setSelectedIndex:(NSInteger)aSelectedIndex {
    if (aSelectedIndex >= [views count]) return;
    if (aSelectedIndex == selectedIndex) return;
    selectedIndex = aSelectedIndex;
    if (selectedIndex == -1) return;
    
    if (self.isHorizontal) {
        // TODO
    } else {
        int height = 0;
        for (int i=0; i<[views count]; i++) {
            id aHeader = [headers objectAtIndex:i];
            id aView = [views objectAtIndex:i];
        
            CGSize originalSize = [[originalSizes objectAtIndex:i] CGSizeValue];
            CGRect viewFrame = [aView frame];
            CGRect headerFrame = [aHeader frame];
            headerFrame.origin.y = height;
            height += headerFrame.size.height;
            viewFrame.origin.y = height;
            
            if (i == aSelectedIndex) {
                viewFrame.size.height = originalSize.height;
                [aView setHidden:NO];
            } else {
                viewFrame.size.height = 0;
            }
            
            height += viewFrame.size.height;
            
            
            if (!CGRectEqualToRect([aHeader frame], headerFrame) || !CGRectEqualToRect([aView frame], viewFrame)) {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(animationDone)];
                [UIView setAnimationDuration:self.animationDuration];
                [UIView setAnimationCurve:self.animationCurve];
                [UIView setAnimationBeginsFromCurrentState:YES];
                [aHeader setFrame:headerFrame];
                [aView setFrame:viewFrame];
                [UIView commitAnimations];
            }
            [scrollView setContentSize:CGSizeMake([self frame].size.width, height)];
        }
    }
}

- (void)setOriginalSize:(CGSize)size forIndex:(NSUInteger)index {
    if (index >= [views count]) return;
    
    [originalSizes replaceObjectAtIndex:index withObject:[NSValue valueWithCGSize:size]];
}

- (void)touchDown:(id)sender {
    [self setSelectedIndex:[sender tag]];
}

- (void)animationDone {
    for (int i=0; i<[views count]; i++) {
        if (i != selectedIndex) [[views objectAtIndex:i] setHidden:YES];
    }
}

@end
