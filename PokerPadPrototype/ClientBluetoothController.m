//
//  ClientBluetoothController.m
//  PokerPadPrototype
//
//  Created by developer on 10/1/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import "ClientBluetoothController.h"
#import "Player.h"

@implementation ClientBluetoothController

@synthesize btSession;
@synthesize gameController;
@synthesize viewController;
@synthesize serverPeerID;
@synthesize uniqueID;
@synthesize name;
@synthesize disconnectAlert;

/* Bluetooth Methods */

-(id) init {
    self = [super init];
    
    uniqueID = [[UIDevice currentDevice] uniqueIdentifier];
    
    gameStarted = NO;
    connectFlag = NO;
    return self;
}


- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
    switch (state)
    {
            
        case GKPeerStateAvailable:
            
            if(connectFlag)
            {
                //[self session:btSession connectionWithPeerFailed:peerID withError:nil];
                [btSession connectToPeer:peerID withTimeout:5];
            }
            
            
            
            NSLog(@"Peer is available: %@ peercount: %d", peerID, [[btSession peersWithConnectionState:GKPeerStateAvailable] count]);
            break;
        case GKPeerStateConnecting:
            NSLog(@"Peer is connecting: %@", peerID);
            break;
        case GKPeerStateUnavailable:
            NSLog(@"Peer is unavailable: %@", peerID);
            break;
        case GKPeerStateConnected:
        {
            //Gets called when connection is made.
            NSLog(@"Peer is connected: %@ peercount: %d", peerID, [[btSession peersWithConnectionState:GKPeerStateAvailable] count]);

            /*if(serverPeerID == nil){
                serverPeerID = peerID;
            }*/
            
            
            /*NSMutableArray *sendIDArray;
            
            if(!gameStarted)
            {
                //send 5 for uniqueID, 1 for first time, and the uniqueID
                sendIDArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(5)], [[NSNumber alloc] initWithInt:(1)], uniqueID, nil];
            
                //Transition to game screen
                [self.viewController startGame];
                gameStarted = YES;
            }
            else
            {
                //send 5 for uniqueID, 0 for not first time, and the uniqueID
                sendIDArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(5)], [[NSNumber alloc] initWithInt:(0)], uniqueID, nil];
            }*/
            
            //[self sendData:sendIDArray];
            
            connectAttempts = 0;
            
            break;
        }
        case GKPeerStateDisconnected:
            
            if(peerID == serverPeerID)
            {
                NSLog(@"Peer is disconnected: %@", peerID);
                
                NSString* str = [[NSString alloc] initWithFormat:@"You disconnected. Click here to reconnect."];
                                 
                disconnectAlert = [[UIAlertView alloc] initWithTitle:@"Player Disconnected"
                                                             message:str
                                                            delegate:self
                                                   cancelButtonTitle:@"Reconnect"
                                                   otherButtonTitles:@"Cancel",nil];
                
                [disconnectAlert show];
            }
                
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView == disconnectAlert) {
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
        if([title isEqualToString:@"Reconnect"]){
            [self joinGame:name];
        }
        else if([title isEqualToString:@"Cancel"]){
            ViewController *homeScreen = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
            homeScreen.view.hidden = NO;
            homeScreen.centerView.hidden = NO;
            homeScreen.nameField.text = gameController.playerName;
            homeScreen.joinGameButton.enabled = YES;
            
            // animate game screen out
            CGRect newFrame = gameController.view.frame;
            newFrame.origin.y += newFrame.size.height + 50;
            gameController.view.backgroundColor = [UIColor clearColor];
            
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationCurveEaseOut
                             animations:^{
                                 gameController.view.frame = newFrame;
                             }
                             completion:^(BOOL finished){
                                 [gameController.view removeFromSuperview];
                                 //homeScreen.view.frame = self.view.frame;
                                 //[self.view addSubview:homeScreen.view];
                                 //homeScreen.menuView.hidden = NO;
                                 [viewController.view bringSubviewToFront:homeScreen.centerView];
                             }];
            [viewController presentModalViewController:homeScreen animated:YES];
        }
    }

}

/* Indicates a connection request was received from another peer.
 
 Accept by calling -acceptConnectionFromPeer:
 Deny by calling -denyConnectionFromPeer:
 */
- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
    NSLog(@"Received connection request from peer: %@", peerID);
}

/* Indicates a connection error occurred with a peer, which includes connection request failures, or disconnects due to timeouts.
 */
- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
    NSLog(@"Peer connection failed with error %@",[error localizedDescription]);
    
    if(connectAttempts++ < 5)
    {
        [btSession connectToPeer:peerID withTimeout:5];
    }
    else
    {
        [self joinGame: name];
    }

}

/* Indicates an error occurred with the session such as failing to make available.
 */
- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
    NSLog(@"Session connection failed with error %@",[error localizedDescription]);
    
    //[self joinGame]
}

//function to connect to the server
-(void) joinGame:(NSString*)dispName {
    
    connectAttempts = 0;
    
    //if not connected, then connect
    //if(btSession == NULL){
        btSession = [[GKSession alloc] initWithSessionID:@"com.pokerpad.PokerPadPrototype" displayName:dispName sessionMode:GKSessionModeClient];
    //}
    btSession.delegate = self;
    if(btSession.available == NO) {
        btSession.available = YES;
    }
    [btSession setDataReceiveHandler:self withContext:nil];
    NSLog(@"Device: %@ | PeerID: %@",btSession.displayName,btSession.peerID);
    
    connectFlag = YES;
    
    
    
    

}


- (void) receiveData:(NSData *)data
            fromPeer:(NSString *)peer
           inSession:(GKSession *)session
             context:(void *)context {
    
    //---convert the NSData to NSString---
    NSMutableArray *dataRecieved = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    
    NSNumber *dataTag = [dataRecieved objectAtIndex:0];
    
    NSLog(@"Received Data: %d", dataTag.intValue);
    
    serverPeerID = peer;
    
    switch (dataTag.intValue) {
        case -1: // game started
        {
            float balance = [(NSNumber*)[dataRecieved objectAtIndex:1] floatValue];
            NSInteger chipSetFlag = [(NSNumber*)[dataRecieved objectAtIndex:2] integerValue];
            
            [gameController gameStartedWithBalance:balance AndChipSetFlag:chipSetFlag];
            break;
        }
        case 0: //2 cards dealt
        {
            Card *card1, *card2;
            
            card1 = [dataRecieved objectAtIndex:1];
            card2 = [dataRecieved objectAtIndex:2];
            
            [gameController newDealReceivedWithCardArray:[[NSMutableArray alloc] initWithObjects:card1, card2, nil]];

            break;
        }
        case 1: //request a bet
        {
            [gameController betRequestReceived];
            
            break;
        }
        case 2: //flop
        {
            Card *card1, *card2, *card3;
            
            card1 = [dataRecieved objectAtIndex:1];
            card2 = [dataRecieved objectAtIndex:2];
            card3 = [dataRecieved objectAtIndex:3];
            
            [gameController flopReceivedWithCardArray:[[NSMutableArray alloc] initWithObjects:card1, card2, card3, nil]];
            

            break;
        }
        case 3: //turn
        {
            Card *card1;
            
            card1 = [dataRecieved objectAtIndex:1];
            
            [gameController turnReceivedWithCard:card1];

            break;
        }
        case 4: //river
        {
            Card *card1;
            
            card1 = [dataRecieved objectAtIndex:1];

            [gameController riverReceivedWithCard:card1];

            break;

        }
        case 5: //win or lost
        {
            //receive 2 NsNumber
            //1 == win 0 == loss
            //2nd number: amount won
            
            // [1] = (Player *)winner, [2] = potValue
            
//            NSNumber *winStatus = [dataRecieved objectAtIndex:1];
//            NSNumber *amountWon = [dataRecieved objectAtIndex:2];
            
            // Stopping Point
            
            //NSString *winnerPlayerName = [dataRecieved objectAtIndex:1];
            //NSInteger winnings = [[dataRecieved objectAtIndex:2] integerValue];
            //NSInteger winFlag = [[dataRecieved objectAtIndex:3] integerValue];
            
            //[gameController winnerRecevied:winnerPlayerName AndPot:winnings AndWinFlag:winFlag];
            
            
            //[gameController winOrLoseReceivedWithValue:[[NSMutableArray alloc] initWithObjects:winStatus, amountWon, nil]];
            
            break;
        }
        case 6: //small blind notification
        {
            [gameController blindNotificationBigBlind:NO withBlind:[(NSNumber*)[dataRecieved objectAtIndex:1] floatValue]];
            break;
        }
        case 7: //big blind notification
        {
            [gameController blindNotificationBigBlind:YES withBlind:[(NSNumber*)[dataRecieved objectAtIndex:1] floatValue]];
            break;
        }
        case 8: //recieved updated bet
        {
            float currentBet = [[dataRecieved objectAtIndex:1] floatValue];
            
            [gameController updateCurrentBet:currentBet];
            
            break;
        }
        case 9: // received updated pot
        {
            float currentPot = [[dataRecieved objectAtIndex:1] floatValue];
            
            [gameController updateNewPot:currentPot];
            
            break;
        }
        case 10: //recieved updated pot / bet
        {
            float currentBet, currentPot;
            
            currentPot = [[dataRecieved objectAtIndex:1] floatValue];
            currentBet = [[dataRecieved objectAtIndex:2] floatValue];
            
            [gameController updateNewPot:currentPot];
            [gameController updateCurrentBet:currentBet];
            
            break;
        }
        case 20: // hand won
        {
            float winnings = [[dataRecieved objectAtIndex:1] floatValue];
            
            [gameController wonHandWithPot:winnings];
            
            break;
        }
        case 21: // hand lost
        {
            NSString *winnerPlayerName = [dataRecieved objectAtIndex:1];
            
            [gameController lostHandToPlayer:winnerPlayerName];
            
            break;
        }
        case 22: // update side pot value
        {
            float sidePot = [[dataRecieved objectAtIndex:1] floatValue];
            
            [gameController updateSidePot:sidePot];
            
            break;
        }
        case 23:
        {
            NSString *message = [dataRecieved objectAtIndex:1];
            if([message isEqualToString:@"New Hand Started"]){
                if(!gameController.blindChip.hidden) {
                    [gameController hideBlindChip];
                }
            }
            [gameController.gameStatusLabel setText:message];
            break;
        }
        case 30: // request unique identifier
        {
            NSMutableArray *sendIDArray;
            
            if(!gameStarted)
            {
                //send 5 for uniqueID, 1 for first time, and the uniqueID
                sendIDArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(5)], [[NSNumber alloc] initWithInt:(1)], uniqueID, nil];
                
                //Transition to game screen
                [self.viewController startGame];
                gameStarted = YES;
            }
            else
            {
                //send 5 for uniqueID, 0 for not first time, and the uniqueID
                sendIDArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(5)], [[NSNumber alloc] initWithInt:(0)], uniqueID, nil];
            }
            
            [self sendData:sendIDArray];
            break;
        }
        case 31: // restore state of client after disconnection
        {
            //balance
            NSNumber *tempBal = (NSNumber *)[dataRecieved objectAtIndex:1];
            
            [gameController setBalance:[tempBal floatValue]];
            [gameController updateLabels];
            break;
        }
        case 50: // game ended
        {
            NSString *endGameMessage = [dataRecieved objectAtIndex:1];
            
            [gameController gameEnded:endGameMessage];
            break;
        }
        default:
            break;
    }
    
}

- (void) sendData: (NSMutableArray *) dataArray {
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
    
    NSArray *temp = [[NSArray alloc] initWithObjects:serverPeerID, nil];
    
    [btSession sendData:dataToSend toPeers:temp withDataMode:GKSendDataReliable error:nil];
}





@end
