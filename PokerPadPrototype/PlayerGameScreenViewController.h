//
//  PlayerGameScreenViewController.h
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 9/25/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import <GameKit/GameKit.h>
#import "Card.h"
#import "ClientBluetoothController.h"
#import "Player.h"

@class ClientBluetoothController;
@interface PlayerGameScreenViewController : UIViewController <UIAlertViewDelegate> {
    NSString *playerName;
    
    NSMutableArray *playerCards; // player's 2 cards
    NSMutableArray *dealerCards; // flop, turn, river
    NSMutableArray *chipSet; // chips values, ascending order
    NSNumberFormatter *moneyFormatter;
    float balance; // player's current balance
    float playerBet; // player's current bet
    float betIncrease;
    float betToStayIn; // bet that player must call/raise to stay in
    float potValue; // pot value for current hand
    float sidePotValue;
    float tableBet;
    BOOL wasPreviousBlind;
    int chipCount;
    int minimumBet;
    int currentPot;
    //int playerBet;
    
    UILabel *gameStatusLabel;
    UILabel *playerBetLabel;
    UILabel *playerBetTitle;
    UILabel *betToStayInLabel;
    UILabel *potLabel;
    UILabel *potTitle;
    UILabel *sidePotLabel;
    UILabel *balanceLabel;
    UILabel *balanceTitle;
    UILabel *tableBetLabel;
    UILabel *tableBetTitle;
    UIButton *bet5Button;
    UIButton *chip1;
    UIButton *chip2;
    UIButton *chip3;
    UIButton *chip4;
    UIButton *chip5;
    UIButton *checkBetButton;
    UIButton *foldButton;
    UIButton *resetBetButton;
    
    UIImageView *c1Image, *c2Image;
    UIImageView *blindChip;
    
    UIImageView *card1ImageView;
    UIImageView *card2ImageView;
    UIImageView *dealCardImageView;
    UIImageView *wLImageView;
    
    UIImageView *flop1ImageView;
    UIImageView *flop2ImageView;
    UIImageView *flop3ImageView;
    UIImageView *turnImageView;
    UIImageView *riverImageView;
    
    UIAlertView *gameOverAlertView;
    
    ClientBluetoothController *btController;
}

@property (nonatomic, retain) NSString *playerName;

@property (nonatomic, retain) IBOutlet UILabel *gameStatusLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerBetTitle, *potTitle, *balanceTitle, *tableBetTitle;
@property (nonatomic, retain) IBOutlet UILabel *balanceLabel;
@property (nonatomic, retain) IBOutlet UILabel *potLabel;
@property (nonatomic, retain) IBOutlet UILabel *sidePotLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerBetLabel;
@property (nonatomic, retain) IBOutlet UILabel *betToStayInLabel;
@property (nonatomic, retain) IBOutlet UILabel *tableBetLabel;
@property (nonatomic, retain) IBOutlet UIButton *bet5Button;
@property (nonatomic, retain) IBOutlet UIButton *chip1;
@property (nonatomic, retain) IBOutlet UIButton *chip2;
@property (nonatomic, retain) IBOutlet UIButton *chip3;
@property (nonatomic, retain) IBOutlet UIButton *chip4;
@property (nonatomic, retain) IBOutlet UIButton *chip5;
@property (nonatomic, retain) IBOutlet UIButton *checkBetButton;
@property (nonatomic, retain) IBOutlet UIButton *foldButton;
@property (nonatomic, retain) IBOutlet UIButton *resetBetButton;

@property (nonatomic, retain) IBOutlet UIImageView *c1Image, *c2Image;
@property (nonatomic, retain) IBOutlet UIImageView *blindChip;
@property (nonatomic, retain) IBOutlet UIImageView *dealCardImageView;
@property (nonatomic, retain) IBOutlet UIImageView *card1ImageView;
@property (nonatomic, retain) IBOutlet UIImageView *card2ImageView;
@property (nonatomic, retain) IBOutlet UIImageView *flop1ImageView;
@property (nonatomic, retain) IBOutlet UIImageView *flop2ImageView;
@property (nonatomic, retain) IBOutlet UIImageView *flop3ImageView;
@property (nonatomic, retain) IBOutlet UIImageView *turnImageView;
@property (nonatomic, retain) IBOutlet UIImageView *riverImageView;
@property (nonatomic, retain) IBOutlet UIImageView *wLImageView;

@property (nonatomic, retain) ClientBluetoothController *btController;

@property (nonatomic, retain) NSMutableArray *playerCards;
@property (nonatomic, retain) NSMutableArray *dealerCards;
@property (nonatomic, retain) NSMutableArray *chipSet;

@property (nonatomic, retain) NSNumberFormatter *moneyFormatter;
@property (nonatomic) float balance;
@property (nonatomic) float playerBet;
@property (nonatomic) float betToStayIn;
@property (nonatomic) float potValue;
@property (nonatomic) float sidePotValue;
@property (nonatomic) float betIncrease;
@property (nonatomic) float tableBet;
@property (nonatomic) BOOL wasPreviousBlind;

-(IBAction)increaseBetBy5:(id)sender;
-(IBAction)sendBetAction:(id)sender;
-(IBAction)increaseBet:(id)sender;
-(IBAction)resetBet:(id)sender;
-(IBAction)foldHand:(id)sender;

-(void)gameStartedWithBalance:(float)newBalance AndChipSetFlag:(NSInteger)chipSetFlag;
-(void)blindNotificationBigBlind:(BOOL)isBigBlind withBlind:(float)blindVal;
-(void)newDealReceivedWithCardArray:(NSMutableArray*)twoCards;
-(void)betRequestReceived;
-(void)flopReceivedWithCardArray:(NSMutableArray*)threeCards;
-(void)turnReceivedWithCard:(Card *)nextCard;
-(void)riverReceivedWithCard:(Card *)nextCard;
-(void)wonHandWithPot:(float)potAmount;
-(void)lostHandToPlayer:(NSString *)winnerName;
-(void)winOrLoseReceivedWithValue:(NSMutableArray*)status;
-(void)gameEnded:(NSString *)message;

-(void)newBetRound;
-(void)updateNewPot:(float)newPot;
-(void)updateSidePot:(float)newSidePot;
-(void)updateCurrentBet:(float)newBet;

-(void)updateLabels;
-(void)enableBettingButtons;
-(void)disableBettingButtons;

-(void)showBlindChip:(int)blindFlag;
-(void)hideBlindChip;

-(void)sendBet:(NSNumber *)betVal;


@end
