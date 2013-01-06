//
//  PlayerSeatView.m
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 10/24/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import "PlayerSeatView.h"
#import "Card.h"
#import "Player.h"

@implementation PlayerSeatView

@synthesize player;
@synthesize playerBalanceLabel;
@synthesize playerBetLabel;
@synthesize playerNameLabel;
/*
-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
    BOOL loadedAPlaceholder = ([[self subviews] count] == 0);
    if(loadedAPlaceholder) {
        PlayerSeatView* realPlayerSeat = [[self class] loadFromNib];
        
        realPlayerSeat.frame = self.frame;
        realPlayerSeat.autoresizingMask = self.autoresizingMask;
        realPlayerSeat.alpha = self.alpha;
        realPlayerSeat.hidden = self.hidden;
		
		// convince ARC that we're legit
		CFRelease((__bridge const void*)self);
		CFRetain((__bridge const void*)realPlayerSeat);
		
        return realPlayerSeat;
    }
    return self;
}
-(void)setPlayer:(Player *)p {
    player = p;
    self.playerNameLabel.text = player.playerName;
    [self updateLabels];
}

-(void)updateLabels {
    self.playerBalanceLabel = [NSString stringWithFormat:@"%i",player.balance];
    self.playerBetLabel = [NSString stringWithFormat:@"%i",player.bet];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
