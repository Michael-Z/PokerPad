//
//  GameScreenViewController.m
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 9/12/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import "GameScreenViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation GameScreenViewController

@synthesize handStarted;
@synthesize viewLoaded;
@synthesize btSession;
@synthesize btController;
@synthesize peerArray;
@synthesize cardDeck;
@synthesize moneyFormatter;
@synthesize handEvaluator;
@synthesize dealButton;
@synthesize startHandButton;
@synthesize endGameButton;

@synthesize tableCards;
@synthesize chipSet;
@synthesize betRightArray;
@synthesize betWrongArray;
@synthesize foldArray;
@synthesize sidePotArray;
@synthesize blindArray;
@synthesize potValue;
@synthesize potAtLastSidePotSet;
@synthesize currentBet;
@synthesize smallBlindIndex;
@synthesize bigBlindIndex;
@synthesize smallBlindValue;
@synthesize bigBlindValue;
@synthesize bettingRound;

@synthesize flop1Card, flop2Card, flop3Card, turnCard, riverCard;
@synthesize riverImageView;
@synthesize flop1ImageView;
@synthesize flop2ImageView;
@synthesize flop3ImageView;
@synthesize turnImageView;
@synthesize smallBlindChip, bigBlindChip;

@synthesize potValueLabel;
@synthesize currentBetLabel;
@synthesize potTitleLabel, betTitleLabel;
@synthesize gameStatusLabel;
@synthesize titleLabel;

@synthesize p1SidePotTitle, p2SidePotTitle, p3SidePotTitle, p4SidePotTitle, p5SidePotTitle, p6SidePotTitle;
@synthesize p1SeatImageView, p2SeatImageView, p3SeatImageView, p4SeatImageView, p5SeatImageView, p6SeatImageView;
@synthesize p1BalanceLabel, p1BetLabel, p1NameLabel, p1SidePotLabel, p1SeatView, p1BalanceTitle, p1BetTitle;
@synthesize p2BalanceLabel, p2BetLabel, p2NameLabel, p2SidePotLabel, p2SeatView, p2BalanceTitle, p2BetTitle;
@synthesize p3BalanceLabel, p3BetLabel, p3NameLabel, p3SidePotLabel, p3SeatView, p3BalanceTitle, p3BetTitle;
@synthesize p4BalanceLabel, p4BetLabel, p4NameLabel, p4SidePotLabel, p4SeatView, p4BalanceTitle, p4BetTitle;
@synthesize p5BalanceLabel, p5BetLabel, p5NameLabel, p5SidePotLabel, p5SeatView, p5BalanceTitle, p5BetTitle;
@synthesize p6BalanceLabel, p6BetLabel, p6NameLabel, p6SidePotLabel, p6SeatView, p6BalanceTitle, p6BetTitle;

@synthesize tableView;

@synthesize optionsView;

@synthesize handsPlayed;

#define PI 3.14159

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    flop1Card.frame = offScreenFrame;
    flop2Card.frame = offScreenFrame;
    flop3Card.frame = offScreenFrame;
    turnCard.frame = offScreenFrame;
    riverCard.frame = offScreenFrame;
    
    [self.view addSubview:flop1Card];
    [self.view addSubview:flop2Card];
    [self.view addSubview:flop3Card];
    [self.view addSubview:turnCard];
    [self.view addSubview:riverCard];
    
    for(int i=0; i<peerArray.count; i++){
        switch (i) {
            case 0:
            {
                CGRect newFrame = p1SeatView.frame;
                newFrame.origin.y -= 500;
                p1SeatImageView.image = [UIImage imageNamed:@"seatBorder.png"];
                p1SeatImageView.highlightedImage = [UIImage imageNamed:@"seatBorderHighlight.png"];
                p1SeatView.frame = newFrame;
                p1SeatView.hidden = NO;
                
                newFrame.origin.y += 500;
                
                [UIView animateWithDuration:1
                                      delay:1
                                    options:UIViewAnimationCurveEaseIn
                                 animations:^{
                                     p1SeatView.frame = newFrame;
                                 }
                                 completion:^(BOOL finished){
                                     
                                 }];
                break;
            }
            case 1:
            {
                CGRect newFrame = p2SeatView.frame;
                newFrame.origin.x -= 500;
                p2SeatImageView.image = [UIImage imageNamed:@"seatBorder.png"];
                p2SeatImageView.highlightedImage = [UIImage imageNamed:@"seatBorderHighlight.png"];
                p2SeatView.frame = newFrame;
                p2SeatView.hidden = NO;
                
                newFrame.origin.x += 500;
                
                [UIView animateWithDuration:1
                                      delay:1
                                    options:UIViewAnimationCurveEaseIn
                                 animations:^{
                                     p2SeatView.frame = newFrame;
                                 }
                                 completion:^(BOOL finished){
                                     
                                 }];
                break;
            }
            case 2:
            {
                CGRect newFrame = p3SeatView.frame;
                newFrame.origin.y += 500;
                p3SeatImageView.image = [UIImage imageNamed:@"seatBorder.png"];
                p3SeatImageView.highlightedImage = [UIImage imageNamed:@"seatBorderHighlight.png"];
                p3SeatView.frame = newFrame;
                p3SeatView.hidden = NO;
                
                newFrame.origin.y -= 500;
                
                [UIView animateWithDuration:1
                                      delay:1
                                    options:UIViewAnimationCurveEaseIn
                                 animations:^{
                                     p3SeatView.frame = newFrame;
                                 }
                                 completion:^(BOOL finished){
                                     
                                 }];
                break;
            }
            case 3:
            {
                CGRect newFrame = p4SeatView.frame;
                newFrame.origin.y += 500;
                p4SeatImageView.image = [UIImage imageNamed:@"seatBorder.png"];
                p4SeatImageView.highlightedImage = [UIImage imageNamed:@"seatBorderHighlight.png"];
                p4SeatView.frame = newFrame;
                p4SeatView.hidden = NO;
                
                newFrame.origin.y -= 500;
                
                [UIView animateWithDuration:1
                                      delay:1
                                    options:UIViewAnimationCurveEaseIn
                                 animations:^{
                                     p4SeatView.frame = newFrame;
                                 }
                                 completion:^(BOOL finished){
                                     
                                 }];
                break;
            }
            case 4:
            {
                CGRect newFrame = p5SeatView.frame;
                newFrame.origin.x += 500;
                p5SeatImageView.image = [UIImage imageNamed:@"seatBorder.png"];
                p5SeatImageView.highlightedImage = [UIImage imageNamed:@"seatBorderHighlight.png"];
                p5SeatView.frame = newFrame;
                p5SeatView.hidden = NO;
                
                newFrame.origin.x -= 500;
                
                [UIView animateWithDuration:1
                                      delay:1
                                    options:UIViewAnimationCurveEaseIn
                                 animations:^{
                                     p5SeatView.frame = newFrame;
                                 }
                                 completion:^(BOOL finished){
                                     
                                 }];
                break;
            }
            case 5:
            {
                CGRect newFrame = p6SeatView.frame;
                newFrame.origin.x += 500;
                p6SeatImageView.image = [UIImage imageNamed:@"seatBorder.png"];
                p6SeatImageView.highlightedImage = [UIImage imageNamed:@"seatBorderHighlight.png"];
                p6SeatView.frame = newFrame;
                p6SeatView.hidden = NO;
                
                newFrame.origin.x -= 500;
                
                [UIView animateWithDuration:1
                                      delay:1
                                    options:UIViewAnimationCurveEaseIn
                                 animations:^{
                                     p6SeatView.frame = newFrame;
                                 }
                                 completion:^(BOOL finished){
                                     
                                 }];
                break;
            }
                
            default:
                break;
        }
    }

}

- (void)viewDidLoad
{
    handsPlayed = 0;
    handStarted = NO;
    viewLoaded = NO;
    endGameButton.hidden = YES;
    [self setLabelsFont];
    
    [gameStatusLabel setText:@"Game Started"];
    
    if(peerArray.count < 2) {
        [startHandButton setEnabled:NO];
    }
    
    offScreenFrame = CGRectMake(self.view.center.x - (flop1Card.frame.size.width / 2), -(flop1Card.frame.size.height + 30), flop1Card.frame.size.width, flop1Card.frame.size.height);
    
    [p1SeatView setBackgroundColor:[UIColor clearColor]];
    [p2SeatView setBackgroundColor:[UIColor clearColor]];
    [p3SeatView setBackgroundColor:[UIColor clearColor]];
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(PI/2);
    p2SeatView.transform = transform;
    CGRect original = p2SeatView.frame;
    CGRect newLocation = CGRectMake(20, (self.view.bounds.size.height/2)-(original.size.height/2), original.size.width, original.size.height);
    p2SeatView.frame = newLocation;
    
    transform = CGAffineTransformMakeRotation(-PI/2);
    original = p5SeatView.frame;
    newLocation = CGRectMake(self.view.frame.size.width - 20, (self.view.bounds.size.height/2)-(original.size.height/2), original.size.width, original.size.height);
    p5SeatView.frame = newLocation;
    
    transform = CGAffineTransformMakeRotation(PI);
    p1SeatView.transform = transform;
    p6SeatView.transform = transform;
    
    
    NSLog(@"p2seat x:%f y:%f",p2SeatView.frame.origin.x,p2SeatView.frame.origin.y);
    
    
    
    moneyFormatter = [[NSNumberFormatter alloc] init];
    [moneyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    //UIImage *patternImage = [UIImage imageNamed:@"felt2.png"];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"felt2.png"]];
    
    NSLog(@"Peers connected: %i",peerArray.count);
    for(Player *p in peerArray) {
        [self updatePlayerSeatLabel:p];
    }
    //[self initPlayerSeatLabels];
    self.flop1ImageView.image = [UIImage imageNamed:@"flop-placeholder.png"];
    self.flop2ImageView.image = [UIImage imageNamed:@"flop-placeholder.png"];
    self.flop3ImageView.image = [UIImage imageNamed:@"flop-placeholder.png"];
    self.turnImageView.image = [UIImage imageNamed:@"turn-placeholder.png"];
    self.riverImageView.image = [UIImage imageNamed:@"river-placeholder.png"];
    [self.startHandButton setImage:[UIImage imageNamed:@"start-hand-button-selected.png"] forState:UIControlStateSelected];
    [self.startHandButton setImage:[UIImage imageNamed:@"start-hand-button-selected.png"] forState:UIControlStateHighlighted];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Felt@2x.png"]];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [potValueLabel setText:[NSString stringWithFormat:@"%@", [moneyFormatter stringFromNumber:[NSNumber numberWithFloat:potValue]]]];
    [currentBetLabel setText:[NSString stringWithFormat:@"%@", [moneyFormatter stringFromNumber:[NSNumber numberWithFloat:currentBet]]]];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

// startHand() :: Handles everything for a whole hand (Dealing, Betting, Deciding Winner, etc.)
-(IBAction)startHand:(id)sender {
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Starting Hand";
    HUD.delegate = self;
    handStarted = YES;
    
    flop1Card.frame = offScreenFrame;
    flop2Card.frame = offScreenFrame;
    flop3Card.frame = offScreenFrame;
    turnCard.frame = offScreenFrame;
    riverCard.frame = offScreenFrame;
    
    NSLog(@"sblind index: %i | bblind index: %i",smallBlindIndex,bigBlindIndex);
    [startHandButton setEnabled:NO];
    [self sendStatusMessageUpdate:@"New Hand Started"];
    betRightArray = [[NSMutableArray alloc] init];
    betWrongArray = [[NSMutableArray alloc] init];
    sidePotArray = [[NSMutableArray alloc] init];
    foldArray = [[NSMutableArray alloc] init];
    tableCards = [[NSMutableArray alloc] init];
    
    [self updateFoldedPlayerSeats];
    [self updatePlayerObjects];
    
    self.flop1ImageView.image = [UIImage imageNamed:@"flop-placeholder.png"];
    self.flop2ImageView.image = [UIImage imageNamed:@"flop-placeholder.png"];
    self.flop3ImageView.image = [UIImage imageNamed:@"flop-placeholder.png"];
    self.turnImageView.image = [UIImage imageNamed:@"turn-placeholder.png"];
    self.riverImageView.image = [UIImage imageNamed:@"river-placeholder.png"];
    
    [self updateServerCurrentBet:0];
    [self updateServerPotValue:0];
    [self setPotAtLastSidePotSet:0];
    
    [self sendClientsUpdatedPot:potValue AndCurrentBet:currentBet];
    
    // check if this is first hand played (blind chips not moved)
    if (handsPlayed > 0) {
        // find previous blind players
        Player *prevSmallBlind = [self findSmallBlindPlayer];
        Player *prevBigBlind = [self findBigBlindPlayer];
        
        // send flag to player, telling player screen to remove blind chip
        
        NSMutableArray *removeBlindFlag = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(11)], nil];
        
        NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:removeBlindFlag];
        
        [prevSmallBlind sendData:dataToSend];
        [prevBigBlind sendData:dataToSend];
    }
    
    [betRightArray removeAllObjects];
    [betWrongArray removeAllObjects];
    [foldArray removeAllObjects];
    [tableCards removeAllObjects];
    [self clearAllSidePots];

    bettingRound = 0;
    
    HUD.labelText = @"Getting Blinds";

    Player *smallBlindPlayer = [self findSmallBlindPlayer];
    
    bigBlindIndex = (smallBlindIndex + 1) % peerArray.count;
    
    
    Player *bigBlindPlayer = [self findBigBlindPlayer];
    
    [self moveSmallBlindChipToPlayer:smallBlindPlayer];
    [self moveBigBlindChipToPlayer:bigBlindPlayer];
    
    [self getSmallBlindFromPlayer:smallBlindPlayer];
    [self getBigBlindFromPlayer:bigBlindPlayer];
    
    HUD.labelText = @"Dealing Cards";

    [self dealCards];
    
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"hand2", CFSTR ("wav"), NULL);
    
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURLRef,  &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    [HUD hide:YES afterDelay:1];
    
    [self sendBetRequest];
}

-(void)updatePlayerObjects {
    for (Player *p in peerArray) {
        p.winnings = 0;
        p.sidePot = 0;
        p.potAtSidePotSet = 0;
        p.bet = 0;
        [p.hand removeAllObjects];
        p.handRank = 0;
        p.smallBlind = NO;
        p.bigBlind = NO;
        p.fold = NO;
        p.betRight = NO;
        p.winHand = NO;
        p.allIn = NO;
        
        [self updatePlayerSeatLabel:p];
    }
}


-(void)updateFoldedPlayerSeats {
    for (Player *p in peerArray) {
        if (p.fold) {
            switch (p.seatNumber) {
                case 0:
                {
                    p1SeatImageView.image = [UIImage imageNamed:@"seatBorder.png"];
                    break;
                }
                case 1:
                {
                    p2SeatImageView.image = [UIImage imageNamed:@"seatBorder.png"];
                    break;
                }
                case 2:
                {
                    p3SeatImageView.image = [UIImage imageNamed:@"seatBorder.png"];
                    break;
                }
                case 3:
                {
                    p4SeatImageView.image = [UIImage imageNamed:@"seatBorder.png"];
                    break;
                }
                case 4:
                {
                    p5SeatImageView.image = [UIImage imageNamed:@"seatBorder.png"];
                    break;
                }
                case 5:
                {
                    p6SeatImageView.image = [UIImage imageNamed:@"seatBorder.png"];
                    break;
                }
                    
                default:
                    break;
            }
        }
    }
}

//called to start any betting round
-(void)sendBetRequest {
    Player *playerToBet = [betWrongArray objectAtIndex:0];
    switch (playerToBet.seatNumber) {
        case 0:
            p1SeatImageView.highlighted = YES;
            break;
        case 1:
            p2SeatImageView.highlighted = YES;
            break;
        case 2:
            p3SeatImageView.highlighted = YES;
            break;
        case 3:
            p4SeatImageView.highlighted = YES;
            break;
        case 4:
            p5SeatImageView.highlighted = YES;
            break;
        case 5:
            p6SeatImageView.highlighted = YES;
            break;
            
        default:
            break;
    }
    
    // check if player up to bet is allIn
    if (playerToBet.allIn == YES) {
        [betRightArray addObject:playerToBet];
        [betWrongArray removeObjectAtIndex:0];
        if(betWrongArray.count > 0){
            [self sendBetRequest];
        }
        else if(betWrongArray.count == 0){
            [self bettingDone];
        }
    }
    // check if player up to bet has folded
    else if (playerToBet.fold == YES){
        
    }
    // check if player up to bet is out of money
    else if (playerToBet.balance == 0){
        
    }
    // otherwise, player up to bet is good to bet
    else {
        NSMutableArray *turnToBet = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(1)], nil];
        
        NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:turnToBet];
        [playerToBet sendData: dataToSend];
    }
}

-(void)startBettingRound {
    
    //FIND THE OBJECT OF THE FIRST PERSON STARTING WITH SMALL BLIND WHO DIDNT FOLD
    /*
    Player *firstBetter;
    for(int i = 0; i < peerArray.count; i++)
    {
        firstBetter = [peerArray objectAtIndex:(smallBlindIndex + i) % peerArray.count];
        if(!firstBetter.fold)
        {
            break;
        }
    }
    
    //MOVE THE BET RIGHT ARRAY TO THE BET WRONG ARRAY BASED OFF THAT INDEX
    int startIndex = [betRightArray indexOfObject:firstBetter];
    for(int i = 0; i<betRightArray.count; i++){
        
        [betWrongArray addObject:[betRightArray objectAtIndex:(startIndex + i) % betRightArray.count]];
    }
    
    for(int i = 0; i < peerArray.count; i++)
    {
        [[peerArray objectAtIndex:i] setBet:0];
    }
    */
    [self updateServerCurrentBet:0];
    [self sendClientsUpdatedCurrentBet:0];
    
    [self sendBetRequest];
    
}

-(Player *)findSmallBlindPlayer {
    Player *smPlayer = [peerArray objectAtIndex:smallBlindIndex];
    while(smPlayer.balance == 0){
        if(smallBlindIndex == peerArray.count-1)
            smallBlindIndex = 0;
        else
            smallBlindIndex++;
        smPlayer = [peerArray objectAtIndex:smallBlindIndex];
    }
    return smPlayer;
}

-(Player *)findBigBlindPlayer {
    Player *bgPlayer = [peerArray objectAtIndex:bigBlindIndex];
    while(bgPlayer.balance == 0){
        if(bigBlindIndex == peerArray.count-1)
            bigBlindIndex = 0;
        else
            bigBlindIndex++;
        bgPlayer = [peerArray objectAtIndex:bigBlindIndex];
    }
    return bgPlayer;
}

-(void)getSmallBlindFromPlayer:(Player *)smallBlindPlayer {
    // check if player balance > smallBlindValue
    if(smallBlindPlayer.balance < smallBlindValue && smallBlindPlayer.balance > 0){
        NSMutableArray *allInArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithFloat:smallBlindPlayer.balance], nil];
        [self receivedAllIn:smallBlindPlayer data:allInArray];
    }
    else {
    
    smallBlindPlayer.balance -= smallBlindValue;
    smallBlindPlayer.smallBlind = YES;
    
    //set this players bet
    smallBlindPlayer.bet = smallBlindValue;
    
    [self updatePlayerSeatLabel:smallBlindPlayer];
    
    potValue += smallBlindValue;
    
    NSLog(@"small blind player id: %@",smallBlindPlayer.peerID);
    }
    NSMutableArray *smallBlindArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:6], nil];
    [smallBlindArray addObject:[[NSNumber alloc] initWithFloat:smallBlindPlayer.bet]];
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:smallBlindArray];
    
    [smallBlindPlayer sendData: dataToSend];
    
}

-(void)getBigBlindFromPlayer:(Player *)bigBlindPlayer {
    bigBlindPlayer.balance -= bigBlindValue;
    bigBlindPlayer.bigBlind = YES;
    
    bigBlindPlayer.bet = bigBlindValue;
    
    [self updatePlayerSeatLabel:bigBlindPlayer];
    
    [self updateServerPotValue:potValue + bigBlindValue];
    [self updateServerCurrentBet:bigBlindValue];
    
    //[betRightArray addObject:bigBlindPlayer];
    
    //add everyone to the array with big blind last since they get the opportunity to bet again
    for(int i=0; i<peerArray.count; i++){
        Player *temp = [peerArray objectAtIndex:((i + bigBlindIndex + 1) % peerArray.count)];
        [betWrongArray addObject:temp];
    }
    
    NSMutableArray *bigBlindArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(7)], nil];
    [bigBlindArray addObject:[[NSNumber alloc] initWithFloat:bigBlindValue]];
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:bigBlindArray];
    
    [bigBlindPlayer sendData: dataToSend];
    
    [self sendClientsUpdatedPot:potValue AndCurrentBet:currentBet];
}

-(void)bettingDone {
    switch (bettingRound) {
        case 0:
        {
            //pre flop betting finished
            //make sure there are at least two betters left in bet right array
            [betRightArray removeAllObjects];
            [betWrongArray removeAllObjects];
            [sidePotArray removeAllObjects];
            for (int i = smallBlindIndex; i < peerArray.count; i++) {
                Player *temp = [peerArray objectAtIndex:i];
                temp.bet = 0;
                [self updatePlayerSeatLabel:temp];
                if (temp.fold == NO) {
                    [betWrongArray addObject:temp];
                }
            }
            for (int i = 0; i < smallBlindIndex; i++) {
                Player *temp = [peerArray objectAtIndex:i];
                temp.bet = 0;
                [self updatePlayerSeatLabel:temp];
                if (temp.fold == NO) {
                    [betWrongArray addObject:temp];
                }
            }
            [self flop];
            [self startBettingRound];
            
            break;
        }
        case 1:
            //flop betting finished
            //make sure there are at least two betters left in bet right array
            
            [betRightArray removeAllObjects];
            [betWrongArray removeAllObjects];
            [sidePotArray removeAllObjects];
            for (int i = smallBlindIndex; i < peerArray.count; i++) {
                Player *temp = [peerArray objectAtIndex:i];
                temp.bet = 0;
                [self updatePlayerSeatLabel:temp];
                if (temp.fold == NO) {
                    [betWrongArray addObject:temp];
                }
            }
            for (int i = 0; i < smallBlindIndex; i++) {
                Player *temp = [peerArray objectAtIndex:i];
                temp.bet = 0;
                [self updatePlayerSeatLabel:temp];
                if (temp.fold == NO) {
                    [betWrongArray addObject:temp];
                }
            }
            [self turn];
            [self startBettingRound];
            
            break;
        case 2:
            //make sure there are at least two betters left in bet right array
            //turn betting finished
        
        
            [betRightArray removeAllObjects];
            [betWrongArray removeAllObjects];
            [sidePotArray removeAllObjects];
            for (int i = smallBlindIndex; i < peerArray.count; i++) {;
                Player *temp = [peerArray objectAtIndex:i];
                temp.bet = 0;
                [self updatePlayerSeatLabel:temp];
                if (temp.fold == NO) {
                    [betWrongArray addObject:temp];
                }
            }
            
            for (int i = 0; i < smallBlindIndex; i++) {
                Player *temp = [peerArray objectAtIndex:i];
                temp.bet = 0;
                [self updatePlayerSeatLabel:temp];
                if (temp.fold == NO) {
                    [betWrongArray addObject:temp];
                }
            }
            [self river];
            [self startBettingRound];
            
            break;
        case 3:
            //river betting finished
            [self decideWinner];
            if(smallBlindIndex == peerArray.count-1)
                smallBlindIndex = 0;
            else
                smallBlindIndex++;
            break;
        default:
            break;
    }
    
    
}

-(NSInteger)checkIfOnePlayerLeft {
    NSInteger onePlayerLeft = -1;
    NSLog(@"folds:%i sidePots:%i players:%i",foldArray.count,sidePotArray.count,peerArray.count);
    if(foldArray.count == peerArray.count-1)
        onePlayerLeft = 1;
    else if(foldArray.count + sidePotArray.count == peerArray.count-1){
        onePlayerLeft = 2;
    }
    return onePlayerLeft;
}

-(void)updatePotAndCurrentBet {
    [potValueLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:potValue]]]];
    [currentBetLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:currentBet]]]];
    for (Player *p in peerArray) {
        NSMutableArray *potAndBetArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(1)], nil];
        [potAndBetArray addObject:[[NSNumber alloc] initWithFloat:potValue]];
        [potAndBetArray addObject:[[NSNumber alloc] initWithFloat:currentBet]];
        
        NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:potAndBetArray];
        
        [p sendData:dataToSend];
    }
}

// initPlayerSeatLabels --- not used anymore, add updates to updatePlayerSeatLabel
/*
-(void)initPlayerSeatLabels {
    for(int i=0; i<peerArray.count; i++){
        Player *p = [peerArray objectAtIndex:i];
        switch (p.seatNumber) {
            case 0:
            {
                [p1NameLabel setText:p.playerName];
                [p1BetLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.bet]]]];
                [p1BalanceLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.balance]]]];
                break;
            }
            case 1:
            {
                [p2NameLabel setText:p.playerName];
                [p2BetLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.bet]]]];
                [p2BalanceLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.balance]]]];
                break;
            }
            case 2:
            {
                [p3NameLabel setText:p.playerName];
                [p3BetLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.bet]]]];
                [p3BalanceLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.balance]]]];
                break;
            }
            default:
                break;
        }
    }
}
 */

-(void)updatePlayerSeatLabel:(Player *)p {
    switch (p.seatNumber) {
        case 0:
        {
            [p1NameLabel setText:p.playerName];
            [p1BetLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.bet]]]];
            [p1BalanceLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.balance]]]];
            if(p.sidePot == 0){
                [p1SidePotTitle setHidden:YES];
                [p1SidePotLabel setHidden:YES];
            }
            break;
        }
        case 1:
        {
            [p2NameLabel setText:p.playerName];
            [p2BetLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.bet]]]];
            [p2BalanceLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.balance]]]];
            if(p.sidePot == 0){
                [p2SidePotTitle setHidden:YES];
                [p2SidePotLabel setHidden:YES];
            }
            break;
        }
        case 2:
        {
            [p3NameLabel setText:p.playerName];
            [p3BetLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.bet]]]];
            [p3BalanceLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.balance]]]];
            if(p.sidePot == 0){
                [p3SidePotTitle setHidden:YES];
                [p3SidePotLabel setHidden:YES];
            }
            break;
        }
        case 3:
        {
            [p4NameLabel setText:p.playerName];
            [p4BetLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.bet]]]];
            [p4BalanceLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.balance]]]];
            if(p.sidePot == 0){
                [p4SidePotTitle setHidden:YES];
                [p4SidePotLabel setHidden:YES];
            }
            break;
        }
        case 4:
        {
            [p5NameLabel setText:p.playerName];
            [p5BetLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.bet]]]];
            [p5BalanceLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.balance]]]];
            if(p.sidePot == 0){
                [p5SidePotTitle setHidden:YES];
                [p5SidePotLabel setHidden:YES];
            }
            break;
        }
        case 5:
        {
            [p6NameLabel setText:p.playerName];
            [p6BetLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.bet]]]];
            [p6BalanceLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.balance]]]];
            if(p.sidePot == 0){
                [p6SidePotTitle setHidden:YES];
                [p6SidePotLabel setHidden:YES];
            }
            break;
        }
        default:
            break;
    }
}

-(void)updateSidePotLabelForPlayer:(Player *)p {
    switch (p.seatNumber) {
        case 0:
        {
            [p1SidePotLabel setText:[moneyFormatter stringFromNumber:[[NSNumber alloc] initWithFloat:p.sidePot]]];
            if(p1SidePotLabel.hidden == YES && p.sidePot > 0){
                p1SidePotTitle.hidden = NO;
                p1SidePotLabel.hidden = NO;
            }
            else if(p1SidePotLabel.hidden == NO && p.sidePot < 0){
                p1SidePotTitle.hidden = YES;
                p1SidePotLabel.hidden = YES;
                
            }
            break;
        }
        case 1:
        {
            [p2SidePotLabel setText:[moneyFormatter stringFromNumber:[[NSNumber alloc] initWithFloat:p.sidePot]]];
            if(p2SidePotLabel.hidden == YES && p.sidePot > 0){
                p2SidePotTitle.hidden = NO;
                p2SidePotLabel.hidden = NO;
            }
            else if(p2SidePotLabel.hidden == NO && p.sidePot < 0){
                p2SidePotTitle.hidden = YES;
                p2SidePotLabel.hidden = YES;
            }
            break;
        }
        case 2:
        {
            [p3SidePotLabel setText:[moneyFormatter stringFromNumber:[[NSNumber alloc] initWithFloat:p.sidePot]]];
            if(p3SidePotLabel.hidden == YES && p.sidePot > 0){
                p3SidePotTitle.hidden = NO;
                p3SidePotLabel.hidden = NO;
            }
            else if(p3SidePotLabel.hidden == NO && p.sidePot < 0){
                p3SidePotTitle.hidden = YES;
                p3SidePotLabel.hidden = YES;
            }
            break;
        }
        case 3:
        {
            [p4SidePotLabel setText:[moneyFormatter stringFromNumber:[[NSNumber alloc] initWithFloat:p.sidePot]]];
            if(p4SidePotLabel.hidden == YES && p.sidePot > 0){
                p4SidePotTitle.hidden = NO;
                p4SidePotLabel.hidden = NO;
            }
            else if(p4SidePotLabel.hidden == NO && p.sidePot < 0){
                p4SidePotTitle.hidden = YES;
                p4SidePotLabel.hidden = YES;
            }
            break;
        }
        case 4:
        {
            [p5SidePotLabel setText:[moneyFormatter stringFromNumber:[[NSNumber alloc] initWithFloat:p.sidePot]]];
            if(p5SidePotLabel.hidden == YES && p.sidePot > 0){
                p5SidePotTitle.hidden = NO;
                p5SidePotLabel.hidden = NO;
            }
            else if(p5SidePotLabel.hidden == NO && p.sidePot < 0){
                p5SidePotTitle.hidden = YES;
                p5SidePotLabel.hidden = YES;
            }
            break;
        }
        case 5:
        {
            [p6SidePotLabel setText:[moneyFormatter stringFromNumber:[[NSNumber alloc] initWithFloat:p.sidePot]]];
            if(p6SidePotLabel.hidden == YES && p.sidePot > 0){
                p6SidePotTitle.hidden = NO;
                p6SidePotLabel.hidden = NO;
            }
            else if(p6SidePotLabel.hidden == NO && p.sidePot < 0){
                p6SidePotTitle.hidden = YES;
                p6SidePotLabel.hidden = YES;
            }
            break;
        }
        default:
            break;
    }
}

-(void)clearAllSidePots {
    [sidePotArray removeAllObjects];
    [p1SidePotTitle setHidden:YES];
    [p1SidePotLabel setHidden:YES];
    [p2SidePotTitle setHidden:YES];
    [p2SidePotLabel setHidden:YES];
    [p3SidePotTitle setHidden:YES];
    [p3SidePotLabel setHidden:YES];
    [p4SidePotTitle setHidden:YES];
    [p4SidePotLabel setHidden:YES];
    [p5SidePotTitle setHidden:YES];
    [p5SidePotLabel setHidden:YES];
    [p6SidePotTitle setHidden:YES];
    [p6SidePotLabel setHidden:YES];
}

-(void)updateServerPotValue:(float)newPot {
    potValue = newPot;
    [potValueLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:potValue]]]];
}

-(void)updateServerCurrentBet:(float)newCurrentBet {
    currentBet = newCurrentBet;
    [currentBetLabel setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:currentBet]]]];
}

-(void)sendClientsUpdatedCurrentBet:(float)newCurrentBet {
    for (Player *p in peerArray) {
        NSMutableArray *updatedCurrentBetArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(8)], nil];
        [updatedCurrentBetArray addObject:[[NSNumber alloc] initWithFloat:newCurrentBet]];
        
        NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:updatedCurrentBetArray];
        
        [p sendData:dataToSend];
    }
}

-(void)sendClientsUpdatedPot:(float)newPot {
    for (Player *p in peerArray) {
        NSMutableArray *updatedCurrentPot = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(9)], nil];
        [updatedCurrentPot addObject:[[NSNumber alloc] initWithFloat:newPot]];
        
        NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:updatedCurrentPot];
        
        [p sendData:dataToSend];
    }
}

-(void)sendClientsUpdatedPot:(float)newPot AndCurrentBet:(float)newCurrentBet {
    for (Player *p in peerArray) {
        NSMutableArray *potAndBetArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(10)], nil];
        [potAndBetArray addObject:[[NSNumber alloc] initWithFloat:self.potValue]];
        [potAndBetArray addObject:[[NSNumber alloc] initWithFloat:self.currentBet]];
        
        NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:potAndBetArray];
        
        [p sendData:dataToSend];
    }
}

-(void)dealCards {
    cardDeck = [[Deck alloc] initWithDeck:[Deck getSuffledDeck]];
    
    //go through each player
    for(int i=0; i< peerArray.count; i++){
        Player *temp = [peerArray objectAtIndex:i];
        
        //0 in protocol means deal cards
        NSMutableArray *playerCards = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:0], nil];
        temp.hand = [[NSMutableArray alloc] init];
        NSLog(@"%@ sent cards. %@",temp.peerID, temp.playerName);
        for (int j=0; j<2; j++) {
            Card *c = [cardDeck drawCardFromDeck];
            [playerCards addObject:c];
            [temp.hand addObject:c];
        }
        
        
        
        NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:playerCards];
        
        [temp sendData: dataToSend];
    }
}

-(void)flop {
    bettingRound = 1;
    NSLog(@"Betting Round = 1");
    NSMutableArray *playerCards = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:2], nil];
    
    for (int j=0; j<3; j++) {
        Card *c = [cardDeck drawCardFromDeck];
        [playerCards addObject:c];
        [tableCards addObject:c];
        
        switch (j) {
            case 0:
            {
                //self.flop1ImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c getCardValue], [c getCardSuit]]];
                flop1Card.frame = offScreenFrame;
                flop1Card.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c getCardValue], [c getCardSuit]]];
                
                flop1Card.hidden = NO;
                
                //Show both these cards on screen probably one at a time
                [UIView animateWithDuration:1
                                      delay:0
                                    options:UIViewAnimationCurveLinear
                                 animations:^{
                                     flop1Card.center = flop1ImageView.center;
                                 }
                                 completion:^(BOOL finished){
                                     
                                 }];
                break;
            }
            case 1:
            {
                //self.flop2ImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c getCardValue], [c getCardSuit]]];
                flop2Card.frame = offScreenFrame;
                flop2Card.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c getCardValue], [c getCardSuit]]];
                
                flop2Card.hidden = NO;
                
                //Show both these cards on screen probably one at a time
                [UIView animateWithDuration:1
                                      delay:0.5
                                    options:UIViewAnimationCurveLinear
                                 animations:^{
                                     flop2Card.center = flop2ImageView.center;
                                 }
                                 completion:^(BOOL finished){
                                     
                                 }];
                
                break;
                
            }
            case 2:
            {
                //self.flop3ImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c getCardValue], [c getCardSuit]]];
                flop3Card.frame = offScreenFrame;
                flop3Card.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c getCardValue], [c getCardSuit]]];
                
                flop3Card.hidden = NO;
                
                //Show both these cards on screen probably one at a time
                [UIView animateWithDuration:1
                                      delay:1
                                    options:UIViewAnimationCurveLinear
                                 animations:^{
                                     flop3Card.center = flop3ImageView.center;
                                 }
                                 completion:^(BOOL finished){
                                     
                                 }];
                break;
            }
            default:
                break;
        }
            
    }
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:playerCards];
    
    for(int i=0; i< peerArray.count; i++){
        Player *temp = [peerArray objectAtIndex:i];
        
        [temp sendData: dataToSend];
    }
}

-(void)turn {
    bettingRound = 2;
    
    NSMutableArray *playerCards = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(3)], nil];
    
    Card *c = [cardDeck drawCardFromDeck];
    [playerCards addObject:c];
    [tableCards addObject:c];
    
    turnCard.frame = offScreenFrame;
    turnCard.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c getCardValue], [c getCardSuit]]];
    
    turnCard.hidden = NO;
    
    //Show both these cards on screen probably one at a time
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         turnCard.center = turnImageView.center;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    //self.turnImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c getCardValue], [c getCardSuit]]];
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:playerCards];
    
    for(int i=0; i< peerArray.count; i++){
        Player *temp = [peerArray objectAtIndex:i];
        
        [temp sendData: dataToSend];
    }
}

-(void)river {
    bettingRound = 3;
    
    NSMutableArray *playerCards = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(4)], nil];
    
    Card *c = [cardDeck drawCardFromDeck];
    [playerCards addObject:c];
    [tableCards addObject:c];
    
    riverCard.frame = offScreenFrame;
    riverCard.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c getCardValue], [c getCardSuit]]];
    
    riverCard.hidden = NO;
    
    //Show both these cards on screen probably one at a time
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         riverCard.center = riverImageView.center;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    //self.riverImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c getCardValue], [c getCardSuit]]];
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:playerCards];
    
    for(int i=0; i< peerArray.count; i++){
        Player *temp = [peerArray objectAtIndex:i];
        
        [temp sendData: dataToSend];
    }
}

-(void)decideWinner{
    NSMutableArray *winnersArray = [[NSMutableArray alloc] init];
    NSString *winnersNames = nil;
    if([self checkIfOnePlayerLeft] == -1 || [self checkIfOnePlayerLeft] == 2){
        NSLog(@"betRightArray.count = %i",betRightArray.count);
        
        for (Player *p in betRightArray) {
            p.handRank = [self calculateHandRankForPlayer:p];
        }
        
        NSSortDescriptor *handRankSorter = [[NSSortDescriptor alloc] initWithKey:@"handRank" ascending:NO];
        NSArray *sortDescriptors = [NSArray arrayWithObject:handRankSorter];
        [betRightArray sortUsingDescriptors:sortDescriptors];
        float overallPotLeft = potValue;
        for (int i = 0; i<betRightArray.count; i++) {
            if(overallPotLeft > 0){
                int currentIndex = i;
                int tieCount = 0;
                int sidePotInTieCount = 0;
                
                Player *curr = [betRightArray objectAtIndex:currentIndex];
                
                NSLog(@"%@, hand rank: %i, side pot: %f",curr.playerName, curr.handRank, curr.sidePot);
                if(curr.sidePot > 0) sidePotInTieCount++;
                
                NSMutableArray *tiedArray = [[NSMutableArray alloc] initWithObjects:curr, nil];
                // check for tie and how many players involved
                while(currentIndex != betRightArray.count-1){
                    Player *next = [betRightArray objectAtIndex:currentIndex+1];
                    //[self calculateHandRankForPlayer:next];
                    // check if next Player tied with curr Player
                    if(curr.handRank == next.handRank){
                        [tiedArray addObject:next];
                        // increment tieCount (number of people involved in tie)
                        tieCount++;
                        currentIndex++;
                        if(next.sidePot > 0)
                            sidePotInTieCount++;
                    }
                    else {
                        break;
                    }
                }
                //tie occured
                if(tieCount > 0){
                    if(sidePotInTieCount > 0){
                        NSSortDescriptor *sidePotSorter = [[NSSortDescriptor alloc] initWithKey:@"sidePot" ascending:YES];
                        NSArray *sidePotSortDescriptors = [NSArray arrayWithObject:sidePotSorter];
                        [tiedArray sortUsingDescriptors:sidePotSortDescriptors];
                    }
                    int peopleEligibleForPot = tiedArray.count;
                    float regularPlayerWinnings = 0;
                    
                    // go through and find side pot players and divide their side pot by regularPlayerInTieCount+1 (winningsFromSidePot)
                    // add winningsFromSidePot to regularPlayerWinnings
                    // increase sidePotPlayer.balance and set sidePotPlayer.winnings by/to winningsFromSidePot
                    for(Player *tiedPlayer in tiedArray){
                        [winnersArray addObject:tiedPlayer];
                        // check if tied player has a side pot
                        if(tiedPlayer.sidePot > 0) {
                            // player has side pot
                            
                            float sidePotValue = tiedPlayer.sidePot;
                            float winningsFromSidePot = sidePotValue / peopleEligibleForPot + regularPlayerWinnings;
                            
                            // add winnings to regularPlayerWinnings
                            regularPlayerWinnings += winningsFromSidePot;
                            
                            // decrease overallPotValue by sidePotValue (since those winnings have been dispersed)
                            overallPotLeft -= sidePotValue;
                            
                            tiedPlayer.balance += winningsFromSidePot;
                            tiedPlayer.winnings = winningsFromSidePot;
                            
                            peopleEligibleForPot--;
                        }
                    }
                    regularPlayerWinnings += (overallPotLeft / peopleEligibleForPot);
                    
                    // go through and give regular players (no side pot) their winnings
                    for (Player *winner in tiedArray) {
                        if(winner.sidePot == 0){
                            winner.balance += regularPlayerWinnings;
                            winner.winnings = regularPlayerWinnings;
                            overallPotLeft -= regularPlayerWinnings;
                        }
                    }
                }
                //no tie
                else {
                    if (curr.sidePot > 0) {
                        [winnersArray addObject:curr];
                        if(overallPotLeft >= curr.potAtSidePotSet){
                            curr.balance += curr.potAtSidePotSet;
                            curr.winnings = curr.potAtSidePotSet;
                            overallPotLeft -= curr.potAtSidePotSet;
                        }
                        else {
                            curr.balance += overallPotLeft;
                            curr.winnings = overallPotLeft;
                            overallPotLeft = 0;
                        }
                    }
                    else {
                        [winnersArray addObject:curr];
                        curr.balance += overallPotLeft;
                        curr.winnings = overallPotLeft;
                        overallPotLeft = 0;
                    }
                }
            
            }
            else {
                break;
            }
        }
        //}
    }
    else if([self checkIfOnePlayerLeft] == 1){ // if everyone else folds
        for (Player *p in peerArray) {
            if(p.fold != YES){
                [winnersArray addObject:p];
                p.winnings = potValue;
                p.balance += potValue;
            }
        }
    }
    for(Player *winner in winnersArray){
        winner.winHand = YES;
        NSNumber *winAmount = [[NSNumber alloc] initWithFloat:winner.winnings];
        if(winnersNames == nil){
            winnersNames = [NSString stringWithFormat:@"%@ wins pot of %@", winner.playerName, [moneyFormatter stringFromNumber:winAmount]];
        }
        else {
            winnersNames = [NSString stringWithFormat:@"%@\n%@ wins pot of %@", winnersNames, winner.playerName, [moneyFormatter stringFromNumber:winAmount]];
        }
        [self updatePlayerSeatLabel:winner];
    }
    
    
    
    gameStatusLabel.text = winnersNames;
    
//wining sound
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"win", CFSTR ("wav"), NULL);
    
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURLRef,  &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    NSData *dataToSend;
    
    
    for(int i=0; i< peerArray.count; i++){
        Player *temp = [peerArray objectAtIndex:i];
        if(temp.winHand){
            NSMutableArray *winnerData = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(20)], nil];
            [winnerData addObject:[[NSNumber alloc] initWithFloat:temp.winnings]];
            
            dataToSend = [NSKeyedArchiver archivedDataWithRootObject:winnerData];
            [temp sendData: dataToSend];
        }
        else {
            NSMutableArray *loserData = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(21)], nil];
            [loserData addObject:winnersNames];
            dataToSend = [NSKeyedArchiver archivedDataWithRootObject:loserData];
            [temp sendData: dataToSend];
        }
        
    }
    handStarted = NO;
    
    // check if more than 1 eligible player (players with balance > 0)
    int playersEligible = 0;
    Player *gameWinner;
    for (Player *p in peerArray) {
        if(p.balance > 0){
            playersEligible++;
            gameWinner = p;
        }
    }
    if(playersEligible > 1){
        [startHandButton setEnabled:YES];
    }
    else {
        NSString *gameWinnerMessage = [NSString stringWithFormat:@"%@ wins the game and winnings of %@",gameWinner.playerName, [moneyFormatter stringFromNumber:[NSNumber numberWithFloat:gameWinner.balance]]];
        UIAlertView *gameOverAlert = [[UIAlertView alloc] initWithTitle:@"Game Over!"
                                                        message:gameWinnerMessage
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [gameOverAlert show];
    }
}

-(NSInteger)calculateHandRankForPlayer:(Player *)p {
    handEvaluator = [[SevenEval alloc] init];
    NSMutableArray *playerCards = p.hand;
    [playerCards addObjectsFromArray:tableCards];

    Card *c1 = [playerCards objectAtIndex:0];
    Card *c2 = [playerCards objectAtIndex:1];
    Card *c3 = [playerCards objectAtIndex:2];
    Card *c4 = [playerCards objectAtIndex:3];
    Card *c5 = [playerCards objectAtIndex:4];
    Card *c6 = [playerCards objectAtIndex:5];
    Card *c7 = [playerCards objectAtIndex:6];
    
    NSInteger handRank = [handEvaluator rankOfSeven:[c1 getCardRank] :[c2 getCardRank] :[c3 getCardRank] :[c4 getCardRank] :[c5 getCardRank] :[c6 getCardRank] :[c7 getCardRank]];
    
    return handRank;
}

- (Player *) getPlayerWithPeerID:(NSString *)pID {
    Player *playerToReturn;
    for (int i=0; i<peerArray.count; i++) {
        Player *p = [peerArray objectAtIndex:i];
        if(p.peerID == pID){
            playerToReturn = p;
        }
    }

    return playerToReturn;
}

-(void)receivedCheck:(Player *) playerBetting {
    NSString* str = [NSString stringWithFormat:@"Check receieved from %@",playerBetting.playerName];
    [gameStatusLabel setText:str];
    
    [betRightArray addObject:playerBetting];
    [betWrongArray removeObject:playerBetting];
    
    NSString *statusMessage = [NSString stringWithFormat:@"%@ checked the bet.",playerBetting.playerName];
    
    [self sendStatusMessageUpdate:statusMessage];
}

-(void)receivedCall:(Player *) playerBetting {
    NSString* str = [NSString stringWithFormat:@"Call receieved from %@",playerBetting.playerName];
    [gameStatusLabel setText:str];
    
    // check if any side pots exist in betting round
    if(sidePotArray.count > 0){
        for (Player *sidePotPlayer in sidePotArray) {
            sidePotPlayer.sidePot += sidePotPlayer.bet;
            sidePotPlayer.potAtSidePotSet += sidePotPlayer.bet;
            
            [self updateSidePotLabelForPlayer:sidePotPlayer];
            
            NSMutableArray *sidePotUpdate = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(22)], nil];
            [sidePotUpdate addObject:[[NSNumber alloc] initWithFloat:sidePotPlayer.potAtSidePotSet]];
            
            NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:sidePotUpdate];
            
            [sidePotPlayer sendData: dataToSend];
        }
    }
    
    // update server pot value / label
    [self updateServerPotValue:potValue+(currentBet - playerBetting.bet)];
    
    // send updated Pot to clients
    [self sendClientsUpdatedPot:potValue];
    
    //remove amount bet from players balance
    playerBetting.balance -= (currentBet-playerBetting.bet);
    
    // add to players bet
    playerBetting.bet = currentBet;
    
    [self updatePlayerSeatLabel:playerBetting];
    
    [betRightArray addObject:playerBetting];
    [betWrongArray removeObject:playerBetting];
    
    NSString *statusMessage = [NSString stringWithFormat:@"%@ called the bet.",playerBetting.playerName];
    
    [self sendStatusMessageUpdate:statusMessage];

}

-(void)receivedRaise:(Player *) playerBetting data:(NSMutableArray *)dataReceived {
    NSString* str = [NSString stringWithFormat:@"Raise receieved from %@",playerBetting.playerName];
    [gameStatusLabel setText:str];
    
    float currentPlayerBet = [(NSNumber*)[dataReceived objectAtIndex:1] floatValue];
    
    // check if any side pots exist in betting round
    if(sidePotArray.count > 0){
        for (Player *sidePotPlayer in sidePotArray) {
            sidePotPlayer.sidePot += sidePotPlayer.bet;
            sidePotPlayer.potAtSidePotSet += sidePotPlayer.bet;
            
            [self updateSidePotLabelForPlayer:sidePotPlayer];
            
            NSMutableArray *sidePotUpdate = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(22)], nil];
            [sidePotUpdate addObject:[[NSNumber alloc] initWithFloat:sidePotPlayer.potAtSidePotSet]];
            
            NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:sidePotUpdate];
            
            [sidePotPlayer sendData: dataToSend];
        }
    }
    
    float prevLeadBet = currentBet;
    
    // update server current bet / label
    [self updateServerCurrentBet:currentPlayerBet];
    
    // update server pot value / label
    [self updateServerPotValue:potValue + (currentBet-playerBetting.bet)];
    
    // update clients current bet / pot values
    [self sendClientsUpdatedPot:potValue AndCurrentBet:currentBet];
    
    //remove amount bet from players balance
    playerBetting.balance -= (currentBet-playerBetting.bet);
    
    NSString *statusMessage = [NSString stringWithFormat:@"%@ raised the bet by %@.",playerBetting.playerName,[moneyFormatter stringFromNumber:[[NSNumber alloc] initWithFloat:currentBet-prevLeadBet]]];

    // add to players bet
    playerBetting.bet = currentBet;
    
    [self updatePlayerSeatLabel:playerBetting];
    
    for(int i=0; i<betRightArray.count; i++){
        [betWrongArray addObject:[betRightArray objectAtIndex:i]];
    }
    [betRightArray removeAllObjects];
    [betRightArray addObject:playerBetting];
    [betWrongArray removeObject:playerBetting];
    
    [self sendStatusMessageUpdate:statusMessage];

}

-(void)receivedFold:(Player *) playerBetting {
    NSString* str = [NSString stringWithFormat:@"Fold receieved from %@",playerBetting.playerName];
    [gameStatusLabel setText:str];
    [playerBetting setFold:YES];
    [foldArray addObject:playerBetting];
    [betWrongArray removeObject:playerBetting];
    
    switch (playerBetting.seatNumber) {
        case 0:
        {
            p1SeatImageView.image = [UIImage imageNamed:@"seatBorderFolded.png"];
            break;
        }
        case 1:
        {
            p2SeatImageView.image = [UIImage imageNamed:@"seatBorderFolded.png"];
            break;
        }
        case 2:
        {
            p3SeatImageView.image = [UIImage imageNamed:@"seatBorderFolded.png"];
            break;
        }
        case 3:
        {
            p4SeatImageView.image = [UIImage imageNamed:@"seatBorderFolded.png"];
            break;
        }
        case 4:
        {
            p5SeatImageView.image = [UIImage imageNamed:@"seatBorderFolded.png"];
            break;
        }
        case 5:
        {
            p6SeatImageView.image = [UIImage imageNamed:@"seatBorderFolded.png"];
            break;
        }
            
        default:
            break;
    }
    
    NSString *statusMessage = [NSString stringWithFormat:@"%@ folded.",playerBetting.playerName];
    
    [self sendStatusMessageUpdate:statusMessage];
}

-(void)receivedAllIn:(Player *) playerBetting data:(NSMutableArray *)dataReceived {
    NSString* str = [NSString stringWithFormat:@"All in bet receieved from %@, side pot created",playerBetting.playerName];
    [gameStatusLabel setText:str];
    NSNumber *betReceived;
    if(dataReceived.count > 1){
        betReceived = [dataReceived objectAtIndex:1];
    }
    else {
        betReceived = [dataReceived objectAtIndex:0];
    }
    
    float allInPlayerBet = [betReceived floatValue];
    float beginningOfRoundPotValue = potValue - (betRightArray.count * currentBet);
    NSLog(@"beginningOfRoundPotValue = %f",beginningOfRoundPotValue);
    
    [self updateServerPotValue:potValue + (allInPlayerBet-playerBetting.bet)];
    
    [self sendClientsUpdatedPot:potValue];
    
    playerBetting.bet = allInPlayerBet;
    playerBetting.balance = 0;
    playerBetting.allIn = YES;
    NSLog(@"potAtLastSidePotSet before changing = %f", potAtLastSidePotSet);
    
    
    float sidePotValue = (beginningOfRoundPotValue + ((betRightArray.count+1) * allInPlayerBet)) - potAtLastSidePotSet;
    NSLog(@"(%f + (%i+1 * %f)) - %f = %f",beginningOfRoundPotValue,betRightArray.count,allInPlayerBet,potAtLastSidePotSet,sidePotValue);
    NSLog(@"sidePotValue = %f",sidePotValue);
    
    potAtLastSidePotSet = beginningOfRoundPotValue + ((betRightArray.count+1) * allInPlayerBet);
    NSLog(@"potAtLastSidePotSet after changing = %f", potAtLastSidePotSet);
    
    
    playerBetting.sidePot = sidePotValue;
    playerBetting.potAtSidePotSet = potAtLastSidePotSet;
    
    [self updateSidePotLabelForPlayer:playerBetting];
    
    [betRightArray addObject:playerBetting];
    [sidePotArray addObject:playerBetting];
    [betWrongArray removeObject:playerBetting];
    
    NSLog(@"betRight count:%i",betRightArray.count);
    NSLog(@"sidePot count:%i",sidePotArray.count);
    
    NSMutableArray *sidePotUpdate = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(22)], nil];
    [sidePotUpdate addObject:[[NSNumber alloc] initWithFloat:playerBetting.potAtSidePotSet]];
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:sidePotUpdate];
    
    [playerBetting sendData: dataToSend];
    
    NSString *statusMessage = [NSString stringWithFormat:@"%@ went all in. Side pot created.",playerBetting.playerName];
    
    [self sendStatusMessageUpdate:statusMessage];

}

//This function gets called after any data has been received and checks to ensure that betting needs to continue
- (void) btDataReceived {
    NSInteger isOnePlayerLeft = [self checkIfOnePlayerLeft];
    NSLog(@"one player left: %i",isOnePlayerLeft);
    // everyone folded but one player || if everyone is folded/allIn but one player
    if(isOnePlayerLeft == 1){
        bettingRound = 3;
        [self bettingDone];
    }
    
    // everyone besides one player either folded or is allIn
    else if(isOnePlayerLeft == 2){
        NSLog(@"One player left w/ side pots involved");
        switch (bettingRound) {
            case 0:
                [self flop];
                [self turn];
                [self river];
                bettingRound = 3;
                [self bettingDone];
                break;
            case 1:
                [self turn];
                [self river];
                bettingRound = 3;
                [self bettingDone];
                break;
            case 2:
                [self river];
                bettingRound = 3;
                [self bettingDone];
                break;
            case 3:
                [self bettingDone];
                break;
                
            default:
                break;
        }
    }
    
    else{
        if(betWrongArray.count > 0){
            [self sendBetRequest];
        }
        else if(betWrongArray.count == 0){
            [self bettingDone];
        }
    }

}

-(void)setLabelsFont {
    [potValueLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:25]];
    [currentBetLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:25]];
    [potTitleLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:30]];
    [betTitleLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:30]];
    [gameStatusLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:20]];
    
    [p1BalanceLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p1BetLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p1NameLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:20]];
    [p1SidePotLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p1SidePotTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p1BalanceTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p1BetTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    
    [p2BalanceLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p2BetLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p2NameLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:20]];
    [p2SidePotLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p2SidePotTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p2BalanceTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p2BetTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    
    [p3BalanceLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p3BetLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p3NameLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:20]];
    [p3SidePotLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p3SidePotTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p3BalanceTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p3BetTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    
    [p4BalanceLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p4BetLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p4NameLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:20]];
    [p4SidePotLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p4SidePotTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p4BalanceTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p4BetTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    
    [p5BalanceLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p5BetLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p5NameLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:20]];
    [p5SidePotLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p5SidePotTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p5BalanceTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p5BetTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    
    [p6BalanceLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p6BetLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p6NameLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:20]];
    [p6SidePotLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p6SidePotTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p6BalanceTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
    [p6BetTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:17]];
}

-(void)moveSmallBlindChipToPlayer:(Player *)sBlindPlayer {
    CGRect newFrame;
    CGAffineTransform transform = CGAffineTransformMakeRotation(0);
    int distanceFromSeat = 10;
    switch (sBlindPlayer.seatNumber) {
        case 0:
        {
            CGFloat xCoord = p1SeatView.frame.origin.x + p1SeatView.frame.size.width + distanceFromSeat;
            CGFloat yCoord = p1SeatView.center.y - (smallBlindChip.frame.size.height/2);
            transform = CGAffineTransformMakeRotation(3.14159);
            newFrame = CGRectMake(xCoord, yCoord, smallBlindChip.frame.size.width, smallBlindChip.frame.size.height);
            break;
        }
        case 1:
        {
            CGFloat xCoord = p2SeatView.center.x - (smallBlindChip.frame.size.height/2);
            CGFloat yCoord = p2SeatView.frame.origin.y + p2SeatView.frame.size.height + distanceFromSeat;
            transform = CGAffineTransformMakeRotation(3.14159/2);
            newFrame = CGRectMake(xCoord, yCoord, smallBlindChip.frame.size.width, smallBlindChip.frame.size.height);
            break;
        }
        case 2:
        {
            CGFloat xCoord = p3SeatView.frame.origin.x + p3SeatView.frame.size.width + distanceFromSeat;
            CGFloat yCoord = p3SeatView.center.y - (smallBlindChip.frame.size.height/2);
            newFrame = CGRectMake(xCoord, yCoord, smallBlindChip.frame.size.width, smallBlindChip.frame.size.height);
            break;
        }
        case 3:
        {
            CGFloat xCoord = p4SeatView.frame.origin.x + p4SeatView.frame.size.width + distanceFromSeat;
            CGFloat yCoord = p4SeatView.center.y - (smallBlindChip.frame.size.height/2);
            newFrame = CGRectMake(xCoord, yCoord, smallBlindChip.frame.size.width, smallBlindChip.frame.size.height);
            break;
        }
        case 4:
        {
            CGFloat xCoord = p5SeatView.center.x - (smallBlindChip.frame.size.height/2);
            CGFloat yCoord = p5SeatView.frame.origin.y - distanceFromSeat - smallBlindChip.frame.size.height;
            transform = CGAffineTransformMakeRotation(-3.14159/2);
            newFrame = CGRectMake(xCoord, yCoord, smallBlindChip.frame.size.width, smallBlindChip.frame.size.height);
            break;
        }
        case 5:
        {
            CGFloat xCoord = p6SeatView.frame.origin.x + p6SeatView.frame.size.width + distanceFromSeat;
            CGFloat yCoord = p6SeatView.center.y - (smallBlindChip.frame.size.height/2);
            transform = CGAffineTransformMakeRotation(3.14159);
            newFrame = CGRectMake(xCoord, yCoord, smallBlindChip.frame.size.width, smallBlindChip.frame.size.height);
            break;
        }
        default:
            break;
    }
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         smallBlindChip.frame = newFrame;
                         smallBlindChip.transform = transform;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
}
-(void)moveBigBlindChipToPlayer:(Player *)bBlindPlayer {
    CGRect newFrame;
    CGAffineTransform transform = CGAffineTransformMakeRotation(0);
    int distanceFromSeat = 10;
    switch (bBlindPlayer.seatNumber) {
        case 0:
        {
            CGFloat xCoord = p1SeatView.frame.origin.x + p1SeatView.frame.size.width + distanceFromSeat;
            CGFloat yCoord = p1SeatView.center.y - (bigBlindChip.frame.size.height/2);
            transform = CGAffineTransformMakeRotation(3.14159);
            newFrame = CGRectMake(xCoord, yCoord, bigBlindChip.frame.size.width, bigBlindChip.frame.size.height);
            break;
        }
        case 1:
        {
            CGFloat xCoord = p2SeatView.center.x - (bigBlindChip.frame.size.height/2);
            CGFloat yCoord = p2SeatView.frame.origin.y + p2SeatView.frame.size.height + distanceFromSeat;
            transform = CGAffineTransformMakeRotation(3.14159/2);
            newFrame = CGRectMake(xCoord, yCoord, bigBlindChip.frame.size.width, bigBlindChip.frame.size.height);
            break;
        }
        case 2:
        {
            CGFloat xCoord = p3SeatView.frame.origin.x + p3SeatView.frame.size.width + distanceFromSeat;
            CGFloat yCoord = p3SeatView.center.y - (bigBlindChip.frame.size.height/2);
            newFrame = CGRectMake(xCoord, yCoord, bigBlindChip.frame.size.width, bigBlindChip.frame.size.height);
            break;
        }
        case 3:
        {
            CGFloat xCoord = p4SeatView.frame.origin.x + p4SeatView.frame.size.width + distanceFromSeat;
            CGFloat yCoord = p4SeatView.center.y - (bigBlindChip.frame.size.height/2);
            newFrame = CGRectMake(xCoord, yCoord, bigBlindChip.frame.size.width, bigBlindChip.frame.size.height);
            break;
        }
        case 4:
        {
            CGFloat xCoord = p5SeatView.center.x - (bigBlindChip.frame.size.height/2);
            CGFloat yCoord = p5SeatView.frame.origin.y - distanceFromSeat - bigBlindChip.frame.size.height;
            transform = CGAffineTransformMakeRotation(-3.14159/2);
            newFrame = CGRectMake(xCoord, yCoord, bigBlindChip.frame.size.width, bigBlindChip.frame.size.height);
            break;
        }
        case 5:
        {
            CGFloat xCoord = p6SeatView.frame.origin.x + p6SeatView.frame.size.width + distanceFromSeat;
            CGFloat yCoord = p6SeatView.center.y - (bigBlindChip.frame.size.height/2);
            transform = CGAffineTransformMakeRotation(3.14159);
            newFrame = CGRectMake(xCoord, yCoord, bigBlindChip.frame.size.width, bigBlindChip.frame.size.height);
            break;
        }
        default:
            break;
    }
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         bigBlindChip.frame = newFrame;
                         bigBlindChip.transform = transform;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(IBAction)toggleMenu:(id)sender {
    if(endGameButton.hidden){
        [self showOptionsMenu];
    }
    else {
        [self hideOptionsMenu];
    }
}

-(void)showOptionsMenu {
    /*
    CGPoint centerPoint = self.view.center;
    CGRect newFrame = CGRectMake(self.view.center.x - optionsView.frame.size.width/2, -(optionsView.frame.size.height)-50, optionsView.frame.size.width, optionsView.frame.size.height);
    optionsView.frame = newFrame;
    optionsView.hidden = YES;
    
    [self.view addSubview:optionsView];
    optionsView.hidden = NO;
    NSLog(@"options center: (%f,%f)",optionsView.center.x, optionsView.center.y);
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         optionsView.center = centerPoint;
                     }
                     completion:^(BOOL finished){
                         startHandButton.enabled = NO;
                     }];
     */
    
    CGRect newFrame = CGRectMake(self.view.center.x - endGameButton.frame.size.width/2, startHandButton.frame.origin.y + startHandButton.frame.size.height + 15, endGameButton.frame.size.width, endGameButton.frame.size.height);
    newFrame.origin.y += 600;
    endGameButton.frame = newFrame;
    endGameButton.hidden = NO;
    
    newFrame.origin.y -= 600;
    
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationCurveEaseIn
                     animations:^{
                         endGameButton.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         startHandButton.enabled = NO;
                     }];
    
    
}
-(void)hideOptionsMenu {
    /*
    CGRect offFrame = CGRectMake(self.view.center.x - optionsView.frame.size.width/2, (self.view.frame.size.height)+50, optionsView.frame.size.width, optionsView.frame.size.height);
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         optionsView.frame = offFrame;
                     }
                     completion:^(BOOL finished){
                         CGRect newFrame = CGRectMake(self.view.center.x - optionsView.frame.size.width/2, -(optionsView.frame.size.height)-50, optionsView.frame.size.width, optionsView.frame.size.height);
                         optionsView.frame = newFrame;
                         if (handStarted) {
                         } else {
                             startHandButton.enabled = YES;
                         }
                     }];
     */
    
    CGRect offFrame = endGameButton.frame;
    offFrame.origin.y += 600;
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         endGameButton.frame = offFrame;
                     }
                     completion:^(BOOL finished){
                         startHandButton.enabled = YES;
                         endGameButton.hidden = YES;
                     }];
}

-(IBAction)endGame:(id)sender {
    // send winnings report
    
    for (Player *p in peerArray) {
        NSString *endGameMessage = [NSString stringWithFormat:@"Your winnings: %@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:p.balance]]];
        
        NSMutableArray *endGameArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(50)], nil];
        [endGameArray addObject:endGameMessage];
        
        NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:endGameArray];
        
        [p sendData:dataToSend];
    }
    
    // add home screen to view
    
    ViewController_iPad *homeScreen = [[ViewController_iPad alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    homeScreen.view.hidden = NO;
    homeScreen.menuView.hidden = NO;
    homeScreen.settingsView.hidden = NO;
    
    [peerArray removeAllObjects];
    [btController.btSession disconnectFromAllPeers];
    
    // animate game screen out
    NSLog(@"TableView size: %fx%f",self.tableView.frame.size.width,self.tableView.frame.size.height);
    CGRect newFrame = self.tableView.frame;
    newFrame.origin.y += newFrame.size.height + 50;
    tableView.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         self.tableView.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         [tableView removeFromSuperview];
                         //homeScreen.view.frame = self.view.frame;
                         //[self.view addSubview:homeScreen.view];
                         //homeScreen.menuView.hidden = NO;
                         [self.view bringSubviewToFront:homeScreen.menuView];
                     }];
    
    // go back to home screen
    
    [self presentModalViewController:homeScreen animated:YES];
    
    /*
    NSLog(@"menu center: (%f,%f)",homeScreen.menuView.center.x, homeScreen.menuView.center.y);
    newFrame = homeScreen.menuView.frame;
    newFrame.origin.x -= (newFrame.size.width + 50);
    homeScreen.menuView.frame = newFrame;
    newFrame.origin.x += (newFrame.size.width + 50);
    
    [UIView animateWithDuration:1
                          delay:1
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         homeScreen.menuView.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
     */
}

-(void)sendStatusMessageUpdate:(NSString *)message {
    NSMutableArray *checkUpdate = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(23)], nil];
    [checkUpdate addObject:message];
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:checkUpdate];
    
    for (Player *p in peerArray) {
        [p sendData: dataToSend];
    }
}



@end
