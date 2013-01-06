//
//  PlayerSeatView.h
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 10/24/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class Player;

@interface PlayerSeatView : UIView

@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) IBOutlet UILabel *playerNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerBetLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerBalanceLabel;

@end
