//
//  GameScreenViewController.h
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 9/12/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "Deck.h"
#import "Card.h"
#import "Player.h"
#import "SevenEval.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ServerBluetoothController.h"
#import "MBProgressHUD.h"

@class SevenEval;
@class ServerBluetoothController;
@class Player;
@interface GameScreenViewController : UIViewController {
    /* Bluetooth-related Variables */
    ServerBluetoothController *btController;
    NSMutableArray *peerArray;
    
    BOOL viewLoaded;
    BOOL handStarted;
    
    /* Card-related Variables */
    
    Deck *cardDeck;
    NSMutableArray *tableCards; // contains [0] = flop1, [1] = flop2, [2] = flop3, [3] = turn, [4] = river
    NSMutableArray *chipSet;
    SevenEval *handEvaluator;
    
    /* Betting-related Variables */
    NSNumberFormatter *moneyFormatter;
    float currentBet; // current betting round's minimum bet to stay in
    float potValue; // current hand's pot value
    float potAtLastSidePotSet;
    NSInteger bettingRound;
    
    NSInteger smallBlindIndex;
    float smallBlindValue;
    
    NSInteger bigBlindIndex;
    float bigBlindValue;
    
    
    NSMutableArray *betRightArray; // contains players whose bet matches the betToStayIn
    NSMutableArray *betWrongArray; // contains players whose bet doesn't match the betToStayIn
    NSMutableArray *foldArray; // contains players who folded
    NSMutableArray *sidePotArray; // contains players who have a sidePot
    
    
    /* UI Elements */
    UIButton *startHandButton;
    UILabel *potValueLabel;
    UILabel *potTitleLabel, *betTitleLabel;
    UILabel *currentBetLabel;
    UILabel *titleLabel;
    CGRect offScreenFrame;
    UIImageView *flop1Card, *flop2Card, *flop3Card, *turnCard, *riverCard;
    UIImageView *flop1ImageView, *flop2ImageView, *flop3ImageView, *turnImageView, *riverImageView;
    UIImageView *smallBlindChip, *bigBlindChip;
    
    UIImageView *p1SeatImageView, *p2SeatImageView, *p3SeatImageView, *p4SeatImageView, *p5SeatImageView, *p6SeatImageView;
    UIView *p1SeatView, *p2SeatView, *p3SeatView, *p4SeatView, *p5SeatView, *p6SeatView;
    UILabel *p1NameLabel, *p1BalanceLabel, *p1BetLabel, *p1SidePotLabel, *p1BalanceTitle, *p1BetTitle, *p1SidePotTitle;
    UILabel *p2NameLabel, *p2BalanceLabel, *p2BetLabel, *p2SidePotLabel, *p2BalanceTitle, *p2BetTitle, *p2SidePotTitle;
    UILabel *p3NameLabel, *p3BalanceLabel, *p3BetLabel, *p3SidePotLabel, *p3BalanceTitle, *p3BetTitle, *p3SidePotTitle;
    UILabel *p4NameLabel, *p4BalanceLabel, *p4BetLabel, *p4SidePotLabel, *p4BalanceTitle, *p4BetTitle, *p4SidePotTitle;
    UILabel *p5NameLabel, *p5BalanceLabel, *p5BetLabel, *p5SidePotLabel, *p5BalanceTitle, *p5BetTitle, *p5SidePotTitle;
    UILabel *p6NameLabel, *p6BalanceLabel, *p6BetLabel, *p6SidePotLabel, *p6BalanceTitle, *p6BetTitle, *p6SidePotTitle;

    IBOutlet UIImageView *BorderView;
    
    UIAlertView *disconnectAlert;
    
    UIView *tableView;
    
    MBProgressHUD *HUD;
    
    /* Options Menu Variables */
    
    UIView *optionsView;
    UIButton *endGameButton;
    UIButton *cancelButton;
    
    /* Game Statistics */
    NSInteger handsPlayed;
    
}

@property (nonatomic) BOOL viewLoaded;
@property (nonatomic, retain) GKSession *btSession;
@property (nonatomic, retain) ServerBluetoothController *btController;
@property (nonatomic, retain) NSMutableArray *peerArray;
@property (nonatomic, retain) Deck *cardDeck;
@property (nonatomic, retain) SevenEval *handEvaluator;
@property (nonatomic) BOOL handStarted;
@property (nonatomic, retain) IBOutlet UIButton *dealButton;
@property (nonatomic, retain) IBOutlet UIButton *startHandButton;

@property (nonatomic, retain) IBOutlet UIImageView *flop1Card, *flop2Card, *flop3Card, *turnCard, *riverCard;
@property (nonatomic, retain) IBOutlet UIImageView *flop1ImageView;
@property (nonatomic, retain) IBOutlet UIImageView *flop2ImageView;
@property (nonatomic, retain) IBOutlet UIImageView *flop3ImageView;
@property (nonatomic, retain) IBOutlet UIImageView *turnImageView;
@property (nonatomic, retain) IBOutlet UIImageView *riverImageView;
@property (nonatomic, retain) IBOutlet UIImageView *smallBlindChip, *bigBlindChip;

@property (nonatomic, retain) IBOutlet UILabel *potValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *potTitleLabel, *betTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *currentBetLabel;
@property (nonatomic, retain) IBOutlet UILabel *gameStatusLabel;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIView *p1SeatView, *p2SeatView, *p3SeatView, *p4SeatView, *p5SeatView, *p6SeatView;
@property (nonatomic, retain) IBOutlet UIImageView *p1SeatImageView, *p2SeatImageView, *p3SeatImageView, *p4SeatImageView, *p5SeatImageView, *p6SeatImageView;
@property (nonatomic, retain) IBOutlet UILabel *p1NameLabel, *p1BalanceLabel, *p1BetLabel, *p1SidePotLabel, *p1BalanceTitle, *p1BetTitle, *p1SidePotTitle;
@property (nonatomic, retain) IBOutlet UILabel *p2NameLabel, *p2BalanceLabel, *p2BetLabel, *p2SidePotLabel, *p2BalanceTitle, *p2BetTitle, *p2SidePotTitle;
@property (nonatomic, retain) IBOutlet UILabel *p3NameLabel, *p3BalanceLabel, *p3BetLabel, *p3SidePotLabel, *p3BalanceTitle, *p3BetTitle, *p3SidePotTitle;
@property (nonatomic, retain) IBOutlet UILabel *p4NameLabel, *p4BalanceLabel, *p4BetLabel, *p4SidePotLabel, *p4BalanceTitle, *p4BetTitle, *p4SidePotTitle;
@property (nonatomic, retain) IBOutlet UILabel *p5NameLabel, *p5BalanceLabel, *p5BetLabel, *p5SidePotLabel, *p5BalanceTitle, *p5BetTitle, *p5SidePotTitle;
@property (nonatomic, retain) IBOutlet UILabel *p6NameLabel, *p6BalanceLabel, *p6BetLabel, *p6SidePotLabel, *p6BalanceTitle, *p6BetTitle, *p6SidePotTitle;

@property (nonatomic, retain) NSMutableArray *tableCards;
@property (nonatomic, retain) NSMutableArray *chipSet;

@property (nonatomic, retain) NSNumberFormatter *moneyFormatter;
@property (nonatomic) float currentBet;
@property (nonatomic) float potValue;
@property (nonatomic) float potAtLastSidePotSet;
@property (nonatomic) NSInteger bettingRound;

@property (nonatomic) NSInteger smallBlindIndex;
@property (nonatomic) float smallBlindValue;

@property (nonatomic) NSInteger bigBlindIndex;
@property (nonatomic) float bigBlindValue;

@property (nonatomic, retain) NSMutableArray *blindArray;
@property (nonatomic, retain) NSMutableArray *betRightArray;
@property (nonatomic, retain) NSMutableArray *betWrongArray;
@property (nonatomic, retain) NSMutableArray *foldArray;
@property (nonatomic, retain) NSMutableArray *sidePotArray;

@property (nonatomic, retain) IBOutlet UIView *tableView;

/* Options View Variables */

@property (nonatomic, retain) IBOutlet UIView *optionsView;
@property (nonatomic, retain) IBOutlet UIButton *endGameButton, *cancelButton;

/* Game Statistics Variables */

@property (nonatomic) NSInteger handsPlayed;

-(void)setLabelsFont;

-(void)dealCards;
-(IBAction)startHand:(id)sender;
-(Player *)findSmallBlindPlayer;
-(Player *)findBigBlindPlayer;
-(void)getSmallBlindFromPlayer:(Player *)smallBlindPlayer;
-(void)getBigBlindFromPlayer:(Player *)bigBlindPlayer;
-(void)moveSmallBlindChipToPlayer:(Player *)sBlindPlayer;
-(void)moveBigBlindChipToPlayer:(Player *)bBlindPlayer;
-(void)firstBettingRound;
-(void)sendBetRequest;
-(void)startBettingRound;
-(void)bettingFinished;
-(NSInteger)checkIfOnePlayerLeft;

-(void)updatePotAndCurrentBet;

-(void)initPlayerSeatLabels;
-(void)updatePlayerSeatLabel:(Player *)p;
-(void)updateSidePotLabelForPlayer:(Player *)p;
-(void)clearAllSidePots;

-(void)updateServerPotValue:(float)newPot;
-(void)updateServerCurrentBet:(float)newCurrentBet;

-(void)sendClientsUpdatedPot:(float)newPot;
-(void)sendClientsUpdatedCurrentBet:(float)newCurrentBet;
-(void)sendClientsUpdatedPot:(float)newPot AndCurrentBet:(float)newCurrentBet;

-(void)flop;
-(void)turn;
-(void)river;
-(void)decideWinner;
-(NSInteger)calculateHandRankForPlayer:(Player *)p;

-(void)receivedCheck:(Player *) playerBetting;
-(void)receivedCall:(Player *) playerBetting;
-(void)receivedRaise:(Player *) playerBetting data:(NSMutableArray *)dataReceived;
-(void)receivedFold:(Player *) playerBetting;
-(void)receivedAllIn:(Player *) playerBetting data:(NSMutableArray *)dataReceived;
-(void) btDataReceived;

- (Player *)getPlayerWithPeerID:(NSString *)pID;

-(IBAction)toggleMenu:(id)sender;
-(void)showOptionsMenu;
-(void)hideOptionsMenu;
-(IBAction)endGame:(id)sender;


@end
