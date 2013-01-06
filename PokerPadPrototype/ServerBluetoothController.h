//
//  ServerBluetoothController.h
//  PokerPadPrototype
//
//  Created by developer on 11/7/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "ServerBluetoothController.h"
#import "GameScreenViewController.h"
#import "ViewController_iPad.h"
#import "Player.h"

@class ViewController_iPad;
@class GameScreenViewController;

@interface ServerBluetoothController : NSObject <GKSessionDelegate> {

    ViewController_iPad *viewController;
    GameScreenViewController *gameScreenController;
    GKSession *btSession;
    
    NSMutableArray *peerArray;
    NSMutableArray *disconnectedPlayers;
    
    UIAlertView *disconnectAlert;
    
    BOOL accepting;
}

@property (retain, nonatomic) GKSession *btSession;
@property (retain, nonatomic) GameScreenViewController *gameScreenController;
@property (retain, nonatomic) ViewController_iPad *viewController;
@property (retain, nonatomic) NSMutableArray *peerArray;
@property (retain, nonatomic) NSMutableArray *disconnectedPlayers;
@property (nonatomic) BOOL accepting;
@property (nonatomic, retain) UIAlertView *disconnectAlert;

- (id) init;
- (void) startBT;

@end
