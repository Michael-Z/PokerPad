//
//  ServerBluetoothController.m
//  PokerPadPrototype
//
//  Created by developer on 11/7/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import "ServerBluetoothController.h"

@implementation ServerBluetoothController

@synthesize viewController;
@synthesize gameScreenController;
@synthesize btSession;
@synthesize peerArray;
@synthesize accepting;
@synthesize disconnectedPlayers;
@synthesize disconnectAlert;

- (id) init {
    self = [super init];
    if(self) {
        accepting = YES;
        disconnectedPlayers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void) startBT {
    //Turn on the bluetooth
    btSession = [[GKSession alloc] initWithSessionID:@"com.pokerpad.PokerPadPrototype" displayName:@"Game Server" sessionMode:GKSessionModeServer];
    [btSession setDelegate:self];
    [btSession setAvailable:YES];
    
    [btSession setDataReceiveHandler:self withContext:nil];
    
    NSLog(@"Bluetooth Started");
}

/* Indicates a state change for the given peer.
 */
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
    switch (state)
    {
        case GKPeerStateAvailable:
        {
            NSLog(@"Peer is available: %@", peerID);
            break;
        }
        case GKPeerStateConnecting:
        {
            NSLog(@"Peer is connecting: %@", peerID);
            break;
        }
        case GKPeerStateUnavailable:
        {
            NSLog(@"Peer is unavailable: %@", peerID);
            break;
        }
        case GKPeerStateConnected:
        {
            NSLog(@"Peer is connected: %@", peerID);
            
            //send a request for a unique identifier
            NSMutableArray *handshake = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:30], nil];
            NSData *dataVal = [NSKeyedArchiver archivedDataWithRootObject:handshake];
            NSArray *temp = [[NSArray alloc] initWithObjects:peerID, nil];
            [btSession sendData:dataVal toPeers:temp withDataMode:GKSendDataReliable error:nil];

            break;
        }
        case GKPeerStateDisconnected:
        {
            NSLog(@"Peer is disconnected: %@", peerID);
            
            if(accepting)
            {
                for (Player *temp in peerArray) {
                    if([temp.peerID isEqualToString:peerID])
                    {
                        [disconnectedPlayers addObject:temp];
                        [peerArray removeObject:temp];
                        break;
                    }
                }
                
                [viewController.playersTableView reloadData];
                [viewController.playersLabel setText:[NSString stringWithFormat:@"Players (%i/6)",peerArray.count]];
            }
            else
            {
                Player *disconnected;
                
                for (Player *temp in peerArray) {
                    if(temp.peerID == peerID)
                    {
                        disconnected = temp;
                    }
                }
                
                /*NSString* str = [[NSString alloc] initWithFormat:@"%@ disconnected.\nClick kick to remove from game.\nClick Fold to fold player until reconnection.\nOr wait for reconnection.", disconnected.playerName];
                
                disconnectAlert = [[UIAlertView alloc] initWithTitle:@"Player Disconnected"
                                                             message:str
                                                            delegate:self
                                                   cancelButtonTitle:@"Kick"
                                                   otherButtonTitles:nil];
                
                [disconnectAlert addButtonWithTitle:@"Fold"];
                */
                
                NSString* str = [[NSString alloc] initWithFormat:@"%@ disconnected.\nPlease wait for reconnection.", disconnected.playerName];
                
                disconnectAlert = [[UIAlertView alloc] initWithTitle:@"Player Disconnected"
                                                             message:str
                                                            delegate:self
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
                
                [disconnectAlert show];
                
                for (Player *temp in peerArray) {
                    if(temp.peerID == peerID)
                    {
                        temp.disconnected = YES;
                    }
                }
                
                //TODO:fold player if necessary
                [viewController.playersLabel setText:[NSString stringWithFormat:@"Players (%i/6)",peerArray.count]];
                
            }
            [self.viewController checkIfGameIsReady];
            break;
        }
    }
}

- (void) receiveData:(NSData *)data
            fromPeer:(NSString *)peer
           inSession:(GKSession *)session
             context:(void *)context {
    
    //---convert the NSData to NSString---
    NSMutableArray *dataRecieved = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSNumber *dataTag = [dataRecieved objectAtIndex:0];//[f numberFromString:[dataRecieved objectAtIndex:0]];
    
    Player *playerBetting;
    
    for (Player *temp in peerArray) {
        if([temp.peerID isEqualToString:peer])
        {
            playerBetting = temp;
        }
    }
    
    NSLog(@"DATA RECEIVED!!! %d FROM %@", dataTag.intValue,playerBetting.playerName);
    
    if(dataTag.intValue >= 0 && dataTag.intValue <= 4){
        switch (playerBetting.seatNumber) {
            case 0:
                gameScreenController.p1SeatImageView.highlighted = NO;
                break;
            case 1:
                gameScreenController.p2SeatImageView.highlighted = NO;
                break;
            case 2:
                gameScreenController.p3SeatImageView.highlighted = NO;
                break;
            case 3:
                gameScreenController.p4SeatImageView.highlighted = NO;
                break;
            case 4:
                gameScreenController.p5SeatImageView.highlighted = NO;
                break;
            case 5:
                gameScreenController.p6SeatImageView.highlighted = NO;
                break;
                
            default:
                break;
        }
    }
    
    switch (dataTag.intValue) {
        case 0: // check received
        {
            [gameScreenController receivedCheck:playerBetting];
            [gameScreenController btDataReceived];
            break;
        }
        case 1: // call
        {
            [gameScreenController receivedCall:playerBetting];
            [gameScreenController btDataReceived];
            break;
        }
        case 2: // bet, dataReceived[1] -> playerBet
        {
            [gameScreenController receivedRaise:playerBetting data:dataRecieved];
            [gameScreenController btDataReceived];
            break;
        }
        case 3: // allIn, create side pot
        {
            [gameScreenController receivedAllIn:playerBetting data:dataRecieved];
            [gameScreenController btDataReceived];
            break;
        }
        case 4: // fold
        {
            [gameScreenController receivedFold:playerBetting];
            [gameScreenController btDataReceived];
            break;
        }
        case 5: //sending unique device id.
        {
            NSNumber *val = [dataRecieved objectAtIndex:1];
            NSString *identifier = [dataRecieved objectAtIndex:2];
            
            
            //val = 1 means first time joining game
            
            Player *foundPlayer;
            if(accepting) //first time sending identifier
            {
                if(val.integerValue == 1)
                {
                    //delete player from peer and disconnect that is equal to this identifier
                    for (Player *temp in disconnectedPlayers) {
                        if([temp.identifier isEqualToString:identifier])
                        {
                            NSLog(@"Deleting disconnected peer to array: %@ id: %@", [btSession displayNameForPeer:peer], identifier);
                            [disconnectedPlayers removeObject:temp];
                            break;
                        }
                    }
                    
                    for (Player *temp in peerArray) {
                        if([temp.identifier isEqualToString:identifier])
                        {
                            NSLog(@"Deleting peer to array: %@ id: %@", [btSession displayNameForPeer:peer], identifier);
                            [peerArray removeObject:temp];
                            break;
                        }
                    }
                    
                    //add this player to peerArray
                    NSLog(@"Adding peer to array: %@ id: %@", [btSession displayNameForPeer:peer], identifier);
                    Player *temp = [[Player alloc] init];
                    
                    [temp setGameScreen:gameScreenController];
                    [temp setPeerID:peer];
                    [temp setPlayerName:[btSession displayNameForPeer:peer]];
                    [temp setBtController:self];
                    [temp setIdentifier:identifier];
                    
                    [peerArray addObject:temp];
                    
                    [viewController test];
                    [viewController.playersTableView reloadData];
                }
                else
                {
                    BOOL found = NO;
                    //check to see if there is a person in disconnected who is this identifier
                    for (Player *temp in disconnectedPlayers) {
                        NSLog(@"Identifier check: %@", identifier);
                        NSLog(@"Identifier2: %@ Name: %@",temp.identifier, temp.playerName);
                        if([temp.identifier isEqualToString:identifier])
                        {
                            NSLog(@"Restoring peer to array: %@ id: %@", [btSession displayNameForPeer:peer], identifier);
                            [temp setPeerID:peer];
                            [peerArray addObject:temp];
                            [disconnectedPlayers removeObject:temp];
                            NSLog(@"Peer array count: %d", peerArray.count);
                            found = YES;
                            break;
                        }
                    }
                    
                    //check to see if there is a person in peerArray who is this identifier
                    if(!found)
                    {
                        NSLog(@"Changing peer to array: %@ id: %@", [btSession displayNameForPeer:peer], identifier);
                        for (Player *temp in peerArray) {
                            if([temp.identifier isEqualToString:identifier])
                            {
                                [temp setPeerID:peer];
                                found = YES;
                                break;
                            }
                        }
                    }
                    
                    //else add this person to peerArray
                    if(!found)
                    {
                        NSLog(@"Adding peer to array: %@ id: %@", [btSession displayNameForPeer:peer], identifier);
                        Player *temp = [[Player alloc] init];
                        
                        [temp setGameScreen:gameScreenController];
                        [temp setPeerID:peer];
                        [temp setPlayerName:[btSession displayNameForPeer:peer]];
                        [temp setBtController:self];
                        [temp setIdentifier:identifier];
                        
                        [peerArray addObject:temp];
                        
                    }
                }
                
                [self.viewController checkIfGameIsReady];
                
                [viewController.playersLabel setText:[NSString stringWithFormat:@"Players (%i/6)",peerArray.count]];
                
                [viewController.playersTableView reloadData];
            }
            else
            {
                //find the one with this id and set the peerID to this one
                for (Player *temp in peerArray) {
                    if([temp.identifier isEqualToString:identifier])
                    {
                        
                        NSLog(@"Changing peer to array: %@ id: %@", [btSession displayNameForPeer:peer], identifier);
                        [temp setPeerID:peer];
                        foundPlayer = temp;
                        break;
                    }
                }
                
                //call a function to start playing again
                [disconnectAlert dismissWithClickedButtonIndex:0 animated:YES];
                
                //resetup foundPlayer with the correct information
                [foundPlayer restoreState];
                
                //[foundPlayer reconnected];
            }
            /*
            if(peerArray.count > 1){
                [viewController.startGameButton setEnabled:YES];
            }
            else {
                [viewController.startGameButton setEnabled:NO];
            }
             */
        }
        case 6: //player with this identifier quit
        {
            NSString *identifier = [dataRecieved objectAtIndex:2];
            
            //send to the player quit function
            //[self playerQuit:identifier];
            break;
            
        }
        default:
            break;
    }
    
    NSLog(@"PeerCount: %i", peerArray.count);
    
    
    
    NSLog(@"Returning from dataReceived.");
}

/* Indicates a connection request was received from another peer.
 Accept by calling -acceptConnectionFromPeer:
 Deny by calling -denyConnectionFromPeer:
 */
- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
    
    NSLog(@"Connection Request Recieved: %@", peerID);
    
    if([session acceptConnectionFromPeer:peerID error:nil] == YES){
        NSLog(@"Connection request succeeded: %@", peerID);
        
    }
    else {
        NSLog(@"Connection request failed: %@", peerID);
    }
}

/* Indicates a connection error occurred with a peer, which includes connection request failures, or disconnects due to timeouts.
 */
- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
    NSLog(@"Peer connection failed with error %@",[error localizedDescription]);

}

/* Indicates an error occurred with the session such as failing to make available.
 */
- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
    NSLog(@"Session connection failed with error %@",[error localizedDescription]);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //0 is kick player
    
    //1 is fold player
}

@end
