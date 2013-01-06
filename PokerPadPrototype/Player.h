//
//  Player.h
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 9/12/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>
#import "ServerBluetoothController.h"
#import "GameScreenViewController.h"

@class ServerBluetoothController;
@class GameScreenViewController;

@interface Player : NSObject {
    NSString *peerID;
    NSString *playerName;
    NSInteger seatNumber;
    NSString *identifier;
    float balance;
    float winnings;
    float bet;
    float sidePot;
    float potAtSidePotSet;
    NSMutableArray *hand;
    NSInteger handRank;
    ServerBluetoothController *btController;
    GameScreenViewController *gameScreen;
    BOOL smallBlind;
    BOOL bigBlind;
    BOOL betRight;
    BOOL fold;
    BOOL winHand;
    BOOL allIn;
    BOOL disconnected;
    NSData *waitVal;
    
}

@property (nonatomic) float balance;
@property (nonatomic) float winnings;
@property (nonatomic) float bet;
@property (nonatomic) float sidePot;
@property (nonatomic) float potAtSidePotSet;
@property (nonatomic) NSInteger seatNumber;
@property (nonatomic, retain) NSString *peerID;
@property (nonatomic, retain) NSString *playerName;
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSMutableArray *hand;
@property (nonatomic) NSInteger handRank;
@property (nonatomic, retain) ServerBluetoothController *btController;
@property (nonatomic, retain) GameScreenViewController *gameScreen;
@property (nonatomic) BOOL smallBlind;
@property (nonatomic) BOOL disconnected;
@property (nonatomic) BOOL bigBlind;
@property (nonatomic) BOOL betRight;
@property (nonatomic) BOOL fold;
@property (nonatomic) BOOL winHand;
@property (nonatomic) BOOL allIn;
@property (nonatomic, retain) NSData *waitVal;

- (id) init;

/* Bluetooth Functions */
- (void) sendData: (NSData *) dataVal;

- (void) reconnected;
- (void) restoreState;



@end
