//
//  ClientBluetoothController.h
//  PokerPadPrototype
//
//  Created by developer on 10/1/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "ClientBluetoothController.h"
#import "PlayerGameScreenViewController.h"
#import "ViewController.h"
#import "Card.h"

@class ViewController;
@class PlayerGameScreenViewController;
@interface ClientBluetoothController : NSObject <GKSessionDelegate> {
    GKSession *btSession;
    PlayerGameScreenViewController *gameController;
    ViewController *viewController;
    NSString *serverPeerID;
    BOOL gameStarted, connectFlag;
    NSString *uniqueID;
    int connectAttempts;
    
    UIAlertView *disconnectAlert;
    
}

@property (retain, nonatomic) GKSession *btSession;
@property (retain, nonatomic) PlayerGameScreenViewController *gameController;
@property (retain, nonatomic) ViewController *viewController;
@property (retain, nonatomic) NSString *serverPeerID;
@property (retain, nonatomic) NSString *uniqueID;
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) UIAlertView *disconnectAlert;

-(void) joinGame:(NSString*)dispName;
- (void) sendData: (NSMutableArray *) dataArray;

@end
