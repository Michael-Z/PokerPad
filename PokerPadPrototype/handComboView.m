//
//  handComboView.m
//  customViewObjects
//
//  Created by Matt Wahlig on 12/10/12.
//  Copyright (c) 2012 Matt Wahlig. All rights reserved.
//



#import "handComboView.h"

@implementation handComboView

#define CARD_WIDTH 49
#define CARD_HEIGHT 70

#define LEFT_PADDING 30

@synthesize handTitle;
@synthesize infoButton;
@synthesize comboCard1, comboCard2, comboCard3, comboCard4, comboCard5;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void) initialize {
    handTitle = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_PADDING, 13, 242, 25)];
    handTitle.backgroundColor = [UIColor clearColor];
    handTitle.textColor = [UIColor whiteColor];
    handTitle.alpha = 0.5;
    
    [handTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:24]];
    
    int count = 0;
    
    
    comboCard1 = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_PADDING, handTitle.frame.origin.y + handTitle.frame.size.height + 8, CARD_WIDTH, CARD_HEIGHT)];
    count++;
    comboCard2 = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_PADDING + count * (8 + CARD_WIDTH), handTitle.frame.origin.y + handTitle.frame.size.height + 8, CARD_WIDTH, CARD_HEIGHT)];
    count++;
    comboCard3 = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_PADDING + count * (8 + CARD_WIDTH), handTitle.frame.origin.y + handTitle.frame.size.height + 8, CARD_WIDTH, CARD_HEIGHT)];
    count++;
    comboCard4 = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_PADDING + count * (8 + CARD_WIDTH), handTitle.frame.origin.y + handTitle.frame.size.height + 8, CARD_WIDTH, CARD_HEIGHT)];
    count++;
    comboCard5 = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_PADDING + count * (8 + CARD_WIDTH), handTitle.frame.origin.y + handTitle.frame.size.height + 8, CARD_WIDTH, CARD_HEIGHT)];
    
    infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    infoButton.alpha = 0.5;
    
    CGRect infoButtonRect = infoButton.frame;
    
    infoButtonRect.origin.x = handTitle.frame.origin.x + handTitle.frame.size.width + 10;
    infoButtonRect.origin.y = handTitle.frame.origin.y;
    
    infoButton.frame = infoButtonRect;
    
    
    
    [self addSubview:handTitle];
    [self addSubview:infoButton];
    [self addSubview:comboCard1];
    [self addSubview:comboCard2];
    [self addSubview:comboCard3];
    [self addSubview:comboCard4];
    [self addSubview:comboCard5];
    
    //[self setComboBasedOnNumber:0];
    
    
    
}

- (void)setComboBasedOnNumber:(int) comboNumber {
    switch(comboNumber){
        case 0:
        {
            // royal flush
            handTitle.text = @"Royal Flush";
            comboCard1.image = [UIImage imageNamed:@"10h.png"];
            comboCard2.image = [UIImage imageNamed:@"11h.png"];
            comboCard3.image = [UIImage imageNamed:@"12h.png"];
            comboCard4.image = [UIImage imageNamed:@"13h.png"];
            comboCard5.image = [UIImage imageNamed:@"14h.png"];
            break;
        }
        case 1:
        {
            // straight flush
            handTitle.text = @"Straight Flush";
            comboCard1.image = [UIImage imageNamed:@"5c.png"];
            comboCard2.image = [UIImage imageNamed:@"6c.png"];
            comboCard3.image = [UIImage imageNamed:@"7c.png"];
            comboCard4.image = [UIImage imageNamed:@"8c.png"];
            comboCard5.image = [UIImage imageNamed:@"9c.png"];
            break;
        }
        case 2:
        {
            // four of a kind
            handTitle.text = @"Four of a Kind";
            comboCard1.image = [UIImage imageNamed:@"14h.png"];
            comboCard2.image = [UIImage imageNamed:@"14s.png"];
            comboCard3.image = [UIImage imageNamed:@"14d.png"];
            comboCard4.image = [UIImage imageNamed:@"14c.png"];
            comboCard5.image = [UIImage imageNamed:@"13h.png"];
            break;
        }
        case 3:
        {
            // full house
            handTitle.text = @"Full House";
            comboCard1.image = [UIImage imageNamed:@"14h.png"];
            comboCard2.image = [UIImage imageNamed:@"14s.png"];
            comboCard3.image = [UIImage imageNamed:@"14d.png"];
            comboCard4.image = [UIImage imageNamed:@"13c.png"];
            comboCard5.image = [UIImage imageNamed:@"13h.png"];
            break;
        }
        case 4:
        {
            // flush
            handTitle.text = @"Flush";
            comboCard1.image = [UIImage imageNamed:@"2h.png"];
            comboCard2.image = [UIImage imageNamed:@"5h.png"];
            comboCard3.image = [UIImage imageNamed:@"7h.png"];
            comboCard4.image = [UIImage imageNamed:@"11h.png"];
            comboCard5.image = [UIImage imageNamed:@"13h.png"];
            break;
        }
        case 5:
        {
            // straight
            handTitle.text = @"Straight";
            comboCard1.image = [UIImage imageNamed:@"2c.png"];
            comboCard2.image = [UIImage imageNamed:@"3h.png"];
            comboCard3.image = [UIImage imageNamed:@"4h.png"];
            comboCard4.image = [UIImage imageNamed:@"5d.png"];
            comboCard5.image = [UIImage imageNamed:@"6s.png"];
            break;
        }
        case 6:
        {
            // three of a kind
            handTitle.text = @"Three of a Kind";
            comboCard1.image = [UIImage imageNamed:@"14h.png"];
            comboCard2.image = [UIImage imageNamed:@"14c.png"];
            comboCard3.image = [UIImage imageNamed:@"14d.png"];
            comboCard4.image = [UIImage imageNamed:@"13d.png"];
            comboCard5.image = [UIImage imageNamed:@"12s.png"];
            break;
        }
        case 7:
        {
            // two pair
            handTitle.text = @"Two Pair";
            comboCard1.image = [UIImage imageNamed:@"14h.png"];
            comboCard2.image = [UIImage imageNamed:@"14c.png"];
            comboCard3.image = [UIImage imageNamed:@"13d.png"];
            comboCard4.image = [UIImage imageNamed:@"13c.png"];
            comboCard5.image = [UIImage imageNamed:@"12s.png"];
            break;
        }
        case 8:
        {
            // one pair
            handTitle.text = @"One Pair";
            comboCard1.image = [UIImage imageNamed:@"14h.png"];
            comboCard2.image = [UIImage imageNamed:@"14c.png"];
            comboCard3.image = [UIImage imageNamed:@"13d.png"];
            comboCard4.image = [UIImage imageNamed:@"12d.png"];
            comboCard5.image = [UIImage imageNamed:@"11s.png"];
            break;
        }
        case 9:
        {
            // high card
            handTitle.text = @"High Card";
            comboCard1.image = [UIImage imageNamed:@"14h.png"];
            comboCard2.image = [UIImage imageNamed:@"13c.png"];
            comboCard3.image = [UIImage imageNamed:@"12d.png"];
            comboCard4.image = [UIImage imageNamed:@"11d.png"];
            comboCard5.image = [UIImage imageNamed:@"9s.png"];
            break;
        }
            
        default:
            break;
    }
    [handTitle sizeToFit];
    CGRect infoButtonRect = infoButton.frame;
    
    infoButtonRect.origin.x = handTitle.frame.origin.x + handTitle.frame.size.width + 20;
    infoButtonRect.origin.y = handTitle.frame.origin.y;
    
    infoButton.frame = infoButtonRect;
    
    CGPoint centerPoint = CGPointMake(infoButton.center.x, handTitle.center.y);
    infoButton.center = centerPoint;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
