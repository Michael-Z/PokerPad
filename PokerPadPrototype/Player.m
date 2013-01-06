//
//  Player.m
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 9/12/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import "Player.h"

@implementation Player;

@synthesize playerName;
@synthesize peerID;
@synthesize seatNumber;
@synthesize balance;
@synthesize winnings;
@synthesize sidePot;
@synthesize potAtSidePotSet;
@synthesize bet;
@synthesize hand;
@synthesize handRank;
@synthesize btController;
@synthesize smallBlind;
@synthesize bigBlind;
@synthesize fold;
@synthesize betRight;
@synthesize winHand;
@synthesize allIn;
@synthesize disconnected;
@synthesize waitVal;
@synthesize identifier;
@synthesize gameScreen;

-(id)init {
    self = [super init];
    if(self) {
        self->playerName = nil;
        self->peerID = nil;
        self->seatNumber = -1;
        self->balance = 0;
        self->winnings = 0;
        self->sidePot = 0;
        self->potAtSidePotSet = 0;
        self->hand = nil;
        self->handRank = 0;
        self->bet = 0;
        self->btController = nil;
        self->smallBlind = NO;
        self->bigBlind = NO;
        self->betRight = NO;
        self->fold = NO;
        self->winHand = NO;
        self->allIn = NO;
        disconnected = NO;
    }
    
    return self;
}

/*- (void) reconnected {
    disconnected = NO;
    
    if(waitVal != nil)
    {
        [self sendData:waitVal];
        waitVal = nil;
    }
}*/

- (void) restoreState {
    
    NSMutableArray *dataArray, *handArray, *flopArray, *turnArray, *riverArray;
    
    NSLog(@"Sending Balance!");
    
    //send their balance
    dataArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(31)], nil];
    [dataArray addObject:[[NSNumber alloc] initWithFloat:balance]];
    [self sendData:[NSKeyedArchiver archivedDataWithRootObject:dataArray]];
    
    NSLog(@"Betting Round: %d", gameScreen.bettingRound);
    
    //send the cards if necessary
    //dealt cards
    if( [hand count] > 0)
    {
        NSLog(@"Sending hand!");
        handArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(0)], nil];
        for (Card *temp in hand) {
            [handArray addObject:temp];
        }
        [self sendData:[NSKeyedArchiver archivedDataWithRootObject:handArray]];
    }
    
    //flop
    if( gameScreen.bettingRound >=1 )
    {
        NSLog(@"Sending flop!");
        flopArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(2)], nil];
        for (int i = 0; i < 3; i++) {
            [flopArray addObject:[gameScreen.tableCards objectAtIndex:i]];
        }
        [self sendData:[NSKeyedArchiver archivedDataWithRootObject:flopArray]];
    }
    
    //turn
    if( gameScreen.bettingRound >=2 )
    {
        NSLog(@"Sending turn!");
        turnArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(3)], nil];
        [turnArray addObject:[gameScreen.tableCards objectAtIndex:3]];
        [self sendData:[NSKeyedArchiver archivedDataWithRootObject:turnArray]];
    }
    
    //river
    if( gameScreen.bettingRound >=3 )
    {
        NSLog(@"Sending river!");
        riverArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(4)], nil];
        [riverArray addObject:[gameScreen.tableCards objectAtIndex:4]];
        [self sendData:[NSKeyedArchiver archivedDataWithRootObject:riverArray]];
    }
    
}

- (void) sendData: (NSData *) dataVal {
    
    /*if(disconnected)
    {
        waitVal = dataVal;
        return;
    }*/
    
    NSArray *temp = [[NSArray alloc] initWithObjects:peerID, nil];
                     
    [btController.btSession sendData:dataVal toPeers:temp withDataMode:GKSendDataReliable error:nil];
}

@end
