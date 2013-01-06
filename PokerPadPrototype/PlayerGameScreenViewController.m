//
//  PlayerGameScreenViewController.m
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 9/25/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import "PlayerGameScreenViewController.h"
#import "Player.h"
#import <QuartzCore/QuartzCore.h>

@implementation PlayerGameScreenViewController

//@synthesize btSession;
@synthesize playerName;
@synthesize playerCards;
@synthesize dealerCards;
@synthesize chipSet;
@synthesize btController;
@synthesize moneyFormatter;
@synthesize gameStatusLabel;
@synthesize playerBetTitle, potTitle, balanceTitle, tableBetTitle;
@synthesize balanceLabel;
@synthesize potLabel;
@synthesize sidePotLabel;
@synthesize playerBetLabel;
@synthesize tableBetLabel;

@synthesize c1Image, c2Image;
@synthesize blindChip;
@synthesize card1ImageView;
@synthesize card2ImageView;
@synthesize dealCardImageView;
@synthesize wasPreviousBlind;

@synthesize flop1ImageView;
@synthesize flop2ImageView;
@synthesize flop3ImageView;
@synthesize turnImageView;
@synthesize riverImageView;

@synthesize potValue;
@synthesize sidePotValue;
@synthesize playerBet;
@synthesize betToStayIn;
@synthesize balance;
@synthesize betIncrease;
@synthesize tableBet;

@synthesize checkBetButton;
@synthesize foldButton;
@synthesize bet5Button;
@synthesize chip1;
@synthesize chip2;
@synthesize chip3;
@synthesize chip4;
@synthesize chip5;

@synthesize resetBetButton;
@synthesize betToStayInLabel;

#define TITLE_FONT_SIZE 28

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        potValue = 0;
        playerBet = 0;
        betToStayIn = 0;
        balance = 0;
        betIncrease = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor clearColor]];
    //[chip1 setImage:[UIImage imageNamed:@"5cents_d"] forState:UIControlStateDisabled];
    //[chip3 setImage:[UIImage imageNamed:@"25cents_d"] forState:UIControlStateDisabled];
    //[resetBetButton setImage:[UIImage imageNamed:@"reset_bet_d"] forState:UIControlStateDisabled];
    
    CGRect offScreenCard = CGRectMake(self.view.center.x - (c1Image.frame.size.width / 2), -(c1Image.frame.size.height + 30), c1Image.frame.size.width, c1Image.frame.size.height);
    
    c1Image.frame = offScreenCard;
    c2Image.frame = offScreenCard;
    
    [self.view addSubview:c1Image];
    [self.view addSubview:c2Image];
    
    wasPreviousBlind = NO;
    
    [blindChip setHidden:YES];
    CGRect offScreenChip = blindChip.frame;
    offScreenChip.origin.x -= (10 + blindChip.frame.size.width);
    blindChip.frame = offScreenChip;
    
    [self disableBettingButtons];
    
    [checkBetButton.titleLabel setFont:[UIFont fontWithName:@"American Captain" size:36]];
    [checkBetButton setTitleColor:[UIColor colorWithRed:78.0/255.0 green:149.0/255.0 blue:69.0/255.0 alpha:1] forState:UIControlStateNormal];
    [checkBetButton setTitleColor:[UIColor colorWithRed:66/255.0 green:122/255.0 blue:59/255.0 alpha:1] forState:UIControlStateHighlighted];
    [checkBetButton setTitleColor:[UIColor colorWithRed:123.0/255.0 green:146.0/255.0 blue:120.0/255.0 alpha:1] forState:UIControlStateDisabled];
    [checkBetButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    [foldButton.titleLabel setFont:[UIFont fontWithName:@"American Captain" size:36]];
    [foldButton setTitleColor:[UIColor colorWithRed:78.0/255.0 green:149.0/255.0 blue:69.0/255.0 alpha:1] forState:UIControlStateNormal];
    [foldButton setTitleColor:[UIColor colorWithRed:66/255.0 green:122/255.0 blue:59/255.0 alpha:1] forState:UIControlStateHighlighted];
    [foldButton setTitleColor:[UIColor colorWithRed:123.0/255.0 green:146.0/255.0 blue:120.0/255.0 alpha:1] forState:UIControlStateDisabled];
    [foldButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [tableBetTitle setFont:[UIFont fontWithName:@"American Captain" size:TITLE_FONT_SIZE]];
    [tableBetTitle setTextColor:[UIColor colorWithRed:78.0/255.0 green:149.0/255.0 blue:69.0/255.0 alpha:1]];
    
    [tableBetLabel setFont:[UIFont fontWithName:@"Comfortaa" size:tableBetLabel.font.pointSize]];
    
    [playerBetTitle setFont:[UIFont fontWithName:@"American Captain" size:TITLE_FONT_SIZE]];
    [playerBetTitle setTextColor:[UIColor colorWithRed:78.0/255.0 green:149.0/255.0 blue:69.0/255.0 alpha:1]];
    
    [playerBetLabel setFont:[UIFont fontWithName:@"Comfortaa" size:playerBetLabel.font.pointSize]];
    
    [betToStayInLabel setFont:[UIFont fontWithName:@"Comfortaa" size:betToStayInLabel.font.pointSize]];
    
    [potTitle setFont:[UIFont fontWithName:@"American Captain" size:TITLE_FONT_SIZE]];
    [potTitle setTextColor:[UIColor colorWithRed:78.0/255.0 green:149.0/255.0 blue:69.0/255.0 alpha:1]];
    
    [potLabel setFont:[UIFont fontWithName:@"Comfortaa" size:potLabel.font.pointSize]];
    
    [sidePotLabel setFont:[UIFont fontWithName:@"Comfortaa" size:sidePotLabel.font.pointSize]];
    [balanceTitle setFont:[UIFont fontWithName:@"American Captain" size:TITLE_FONT_SIZE]];
    [balanceTitle setTextColor:[UIColor colorWithRed:78.0/255.0 green:149.0/255.0 blue:69.0/255.0 alpha:1]];
    [balanceLabel setFont:[UIFont fontWithName:@"Comfortaa" size:balanceLabel.font.pointSize]];
    [gameStatusLabel setFont:[UIFont fontWithName:@"Comfortaa" size:gameStatusLabel.font.pointSize]];
    
    moneyFormatter = [[NSNumberFormatter alloc] init];
    [moneyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    [gameStatusLabel setText:@"Waiting for game to start"];
    
    btController.gameController = self;
    //[btSession setDataReceiveHandler:self withContext:nil];
    self.card1ImageView.image = [UIImage imageNamed:@"card-placeholder.png"];
    self.card2ImageView.image = [UIImage imageNamed:@"card-placeholder.png"];
    self.flop1ImageView.image = [UIImage imageNamed:@"flop-placeholder.png"];
    self.flop2ImageView.image = [UIImage imageNamed:@"flop-placeholder.png"];
    self.flop3ImageView.image = [UIImage imageNamed:@"flop-placeholder.png"];
    self.turnImageView.image = [UIImage imageNamed:@"turn-placeholder.png"];
    self.riverImageView.image = [UIImage imageNamed:@"river-placeholder.png"];
    //UIImage *patternImage = [UIImage imageNamed:@"Felt.png"];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* Client logic functions. Called from bluetooth class */
-(void)gameStartedWithBalance:(float)newBalance AndChipSetFlag:(NSInteger)chipSetFlag{
    
    [gameStatusLabel setText:@"Balances set, game started."];
    [self setBalance:newBalance];
    [self setPotValue:0];
    [self setPlayerBet:0];
    [self setTableBet:0];
    [self setBetToStayIn:0];
    [self setBetIncrease:0];
    
    if(chipSetFlag == 1){
        NSNumber *c1 = [[NSNumber alloc] initWithFloat:.05];
        NSNumber *c2 = [[NSNumber alloc] initWithFloat:.1];
        NSNumber *c3 = [[NSNumber alloc] initWithFloat:.25];
        NSNumber *c4 = [[NSNumber alloc] initWithFloat:.5];
        NSNumber *c5 = [[NSNumber alloc] initWithFloat:1];
        NSMutableArray *smallChips = [[NSMutableArray alloc] initWithObjects:c1,c2,c3,c4,c5, nil];
        chipSet = smallChips;
    } else {
        [chip1 setImage:[UIImage imageNamed:@"50cents-big.png"] forState:UIControlStateNormal];
        [chip2 setImage:[UIImage imageNamed:@"1dollar-big.png"] forState:UIControlStateNormal];
        [chip3 setImage:[UIImage imageNamed:@"5dollar-big.png"] forState:UIControlStateNormal];
        [chip4 setImage:[UIImage imageNamed:@"10dollar-big.png"] forState:UIControlStateNormal];
        [chip5 setImage:[UIImage imageNamed:@"25dollar-big.png"] forState:UIControlStateNormal];
        
        NSNumber *c1 = [[NSNumber alloc] initWithFloat:.5];
        NSNumber *c2 = [[NSNumber alloc] initWithFloat:1];
        NSNumber *c3 = [[NSNumber alloc] initWithFloat:5];
        NSNumber *c4 = [[NSNumber alloc] initWithFloat:10];
        NSNumber *c5 = [[NSNumber alloc] initWithFloat:25];
        NSMutableArray *bigChips = [[NSMutableArray alloc] initWithObjects:c1,c2,c3,c4,c5, nil];
        chipSet = bigChips;
    }
    [self disableBettingButtons];
    
    [self updateLabels];
}

-(void)blindNotificationBigBlind:(BOOL)isBigBlind withBlind:(float)blindVal {
    
    if(isBigBlind)
    {
        float bBlind = blindVal;
        balance -= bBlind;
        playerBet = bBlind;
        [self showBlindChip:1];
        /*
        NSString* str = [[NSString alloc] initWithFormat:@"You are big blind.\nYou have bet: %@\nYour new balance:%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:bBlind]],[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:balance]]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Big Blind"
                                                        message:str
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
         */
    }
    else
    {
        float sBlind = blindVal;
        balance -= sBlind;
        playerBet = sBlind;
        [self showBlindChip:0];
        /*
        NSString* str = [[NSString alloc] initWithFormat:@"You are small blind.\nYou have bet: %@\nYour new balance:%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:sBlind]] ,[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:balance]]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Small Blind"
                                                        message:str
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
         */

    }
    [self updateLabels];
}

-(void)newDealReceivedWithCardArray:(NSMutableArray*)twoCards {
    CGRect offScreenCard = CGRectMake(self.view.center.x - (c1Image.frame.size.width / 2), -(c1Image.frame.size.height + 30), c1Image.frame.size.width, c1Image.frame.size.height);
    playerCards = twoCards;
    [dealerCards removeAllObjects];
    self.flop1ImageView.image = [UIImage imageNamed:@"flop-placeholder.png"];
    self.flop2ImageView.image = [UIImage imageNamed:@"flop-placeholder.png"];
    self.flop3ImageView.image = [UIImage imageNamed:@"flop-placeholder.png"];
    self.turnImageView.image = [UIImage imageNamed:@"turn-placeholder.png"];
    self.riverImageView.image = [UIImage imageNamed:@"river-placeholder.png"];
    
    int delay = 0;
    /*
    if(!c1Image.hidden && !c2Image.hidden){
        delay += 1;
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationCurveLinear
                         animations:^{
                             c1Image.frame = offScreenCard;
                             c2Image.frame = offScreenCard;
                         }
                         completion:^(BOOL finished){
                             c1Image.hidden = YES;
                             c2Image.hidden = YES;
                         }];
    }
    */
    [sidePotLabel setHidden:YES];
    
    Card *c1 = [playerCards objectAtIndex:0];
    Card *c2 = [playerCards objectAtIndex:1];
    
    
    //newFrame.origin.y -= 600;
    c1Image.frame = offScreenCard;
    c1Image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c1 getCardValue], [c1 getCardSuit]]];
    
    c1Image.hidden = NO;
    
    //Show both these cards on screen probably one at a time
    [UIView animateWithDuration:1
                          delay:delay
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         c1Image.center = card1ImageView.center;
                     }
                     completion:^(BOOL finished){
                         //card1ImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c1 getCardValue], [c1 getCardSuit]]];
                         //dealCardImageView.hidden = YES;
                     }];
    
    
    
    c2Image.frame = offScreenCard;
    
    c2Image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c2 getCardValue], [c2 getCardSuit]]];
    
    c2Image.hidden = NO;
    
    [UIView animateWithDuration:1
                          delay:(delay+0.5)
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         c2Image.center = card2ImageView.center;
                     }
                     completion:^(BOOL finished){
                         //card2ImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [c2 getCardValue], [c2 getCardSuit]]];
                     }];
    
    //dealCardImageView.hidden = YES;
    //dealCardImageView.frame = offScreenCard;
}

-(void)betRequestReceived{
    
    /*
    if(tableBet == 0 && playerBet == 0)
    {
        [checkBetButton.titleLabel setText:@"Check"];
        //[checkBetButton.imageView setImage:[UIImage imageNamed:@"check-button.png"]];
    }
    else if (playerBet == tableBet || playerBet < tableBet)
    {
        [checkBetButton.titleLabel setText:@"Call"];
        //[checkBetButton.imageView setImage:[UIImage imageNamed:@"call-button.png"]];
    }
    else if (playerBet > tableBet)
    {
        [checkBetButton.titleLabel setText:@"Raise"];
        [checkBetButton.imageView setImage:[UIImage imageNamed:@"raise-button.png"]];
    }
     */
    [self updateBetButtonState];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bet Request"
                                                    message:@"Your turn to bet."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    betIncrease = 0;
    
    [self enableBettingButtons];
}

-(void)flopReceivedWithCardArray:(NSMutableArray*)threeCards {
    [self newBetRound];
    
    dealerCards = threeCards;
    
    Card *flop1 = [dealerCards objectAtIndex:0];
    Card *flop2 = [dealerCards objectAtIndex:1];
    Card *flop3 = [dealerCards objectAtIndex:2];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    
    [flop1ImageView.layer addAnimation:transition forKey:nil];
    [flop2ImageView.layer addAnimation:transition forKey:nil];
    [flop3ImageView.layer addAnimation:transition forKey:nil];
    
    //Show these three cards on screen
    self.flop1ImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [flop1 getCardValue], [flop1 getCardSuit]]];
    self.flop2ImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [flop2 getCardValue], [flop2 getCardSuit]]];
    self.flop3ImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [flop3 getCardValue], [flop3 getCardSuit]]];
    /*
    if(tableBet == 0 && playerBet == 0)
    {
        [checkBetButton.imageView setImage:[UIImage imageNamed:@"check-button.png"]];
    }
    else if (playerBet == tableBet || playerBet < tableBet)
    {
        [checkBetButton.imageView setImage:[UIImage imageNamed:@"call-button.png"]];
    }
    else if (playerBet > tableBet)
    {
        [checkBetButton.imageView setImage:[UIImage imageNamed:@"raise-button.png"]];
    }
     */
    
    [self updateBetButtonState];
}

-(void)turnReceivedWithCard:(Card *)nextCard {
    [self newBetRound];
    
    [dealerCards addObject:nextCard];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    
    [turnImageView.layer addAnimation:transition forKey:nil];
    
    //show this card on screen
    self.turnImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [nextCard getCardValue], [nextCard getCardSuit]]];
    /*
    if(tableBet == 0 && playerBet == 0)
    {
        [checkBetButton.imageView setImage:[UIImage imageNamed:@"check-button.png"]];
    }
    else if (playerBet == tableBet || playerBet < tableBet)
    {
        [checkBetButton.imageView setImage:[UIImage imageNamed:@"call-button.png"]];
    }
    else if (playerBet > tableBet)
    {
        [checkBetButton.imageView setImage:[UIImage imageNamed:@"raise-button.png"]];
    }
     */
    [self updateBetButtonState];
}

-(void)riverReceivedWithCard:(Card *)nextCard {
    [self newBetRound];
    
    [dealerCards addObject:nextCard];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    
    [riverImageView.layer addAnimation:transition forKey:nil];
    
    //show this card on screen
    self.riverImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.png", [nextCard getCardValue], [nextCard getCardSuit]]];
    /*
    if(tableBet == 0 && playerBet == 0)
    {
        [checkBetButton.imageView setImage:[UIImage imageNamed:@"check-button.png"]];
    }
    else if (playerBet == tableBet || playerBet < tableBet)
    {
        [checkBetButton.imageView setImage:[UIImage imageNamed:@"call-button.png"]];
    }
    else if (playerBet > tableBet)
    {
        [checkBetButton.imageView setImage:[UIImage imageNamed:@"raise-button.png"]];
    }
     */
    [self updateBetButtonState];
}

-(void)wonHandWithPot:(float)potAmount {
    balance += potAmount;
    [self updateLabels];
    NSString *message = [NSString stringWithFormat:@"You won %@!\nYour new balance: %@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:potAmount]],[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:balance]]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Win!"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
-(void)lostHandToPlayer:(NSString *)winnerName {
    NSString *message = winnerName;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Lose!"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void)winOrLoseReceivedWithValue:(NSMutableArray*)status {
    
    int winStatus = [[status objectAtIndex:0] intValue];
    int amountWon = [[status objectAtIndex:1] intValue];
    
    if(winStatus) //win
    {
        //add the winnings to chip count
        chipCount += amountWon;
        
        wLImageView.animationImages = [NSArray arrayWithObjects:
                                     [UIImage imageNamed:@"win1.png"],
                                     [UIImage imageNamed:@"win2.png"],
                                     [UIImage imageNamed:@"win3.png"],
                                     nil];
        wLImageView.animationDuration = 2;
        wLImageView.animationRepeatCount=1;
        [wLImageView startAnimating];
        [self.view addSubview:wLImageView];

    }
    else //lose
    {
        //display you lose to user
        self.wLImageView.image = [UIImage imageNamed:@"lose.png"];
        wLImageView.animationDuration = 2;
        [self.view addSubview:wLImageView];
        //No need to update their current chip count as it already depleted whenever they bet
    }
    
    //clear out the card values and show nothing there
    //i.e. hide the card views
    
}

-(void)newBetRound {
    betIncrease = 0;
    playerBet = 0;
    betToStayIn = 0;
    tableBet = 0;
    
    [self updateLabels];
}

-(void)updateNewPot:(float)newPot {
    potValue = newPot;
    
    [self updateLabels];
}

-(void)updateSidePot:(float)newSidePot {
    [sidePotLabel setText:[NSString stringWithFormat:@"Your side pot: %@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:newSidePot]]]];
    if(sidePotLabel.hidden == YES){
        sidePotLabel.hidden = NO;
    }
    
}

-(void)updateCurrentBet:(float)newBet {
    tableBet = newBet;
    betToStayIn = newBet - playerBet;
    betIncrease = 0;
    NSLog(@"Log updated.");
    [self updateLabels];
}

-(void)updateLabels {
    [tableBetLabel setText:[NSString stringWithFormat:@"%@", [moneyFormatter stringFromNumber:[NSNumber numberWithFloat:tableBet]]]];
    [playerBetLabel setText:[NSString stringWithFormat:@"%@", [moneyFormatter stringFromNumber:[NSNumber numberWithFloat:playerBet]]]];
    [potLabel setText:[NSString stringWithFormat:@"%@", [moneyFormatter stringFromNumber:[NSNumber numberWithFloat:potValue]]]];
    [balanceLabel setText:[NSString stringWithFormat:@"%@", [moneyFormatter stringFromNumber:[NSNumber numberWithFloat:balance]]]];
    [betToStayInLabel setText:[NSString stringWithFormat:@"Bet %@ more to call.", [moneyFormatter stringFromNumber:[NSNumber numberWithFloat:betToStayIn]]]];
    
    if(betToStayIn > 0){
        [betToStayInLabel setHidden:NO];
    }
    else {
        [betToStayInLabel setHidden:YES];
    }
    /*
        
    if(tableBet == 0 && playerBet == 0)
    {
        [checkBetButton.imageView setImage:[UIImage imageNamed:@"check-button.png"]];
    }
    else if (playerBet == tableBet || playerBet < tableBet)
    {
        [checkBetButton.imageView setImage:[UIImage imageNamed:@"call-button.png"]];
    }
    else if (playerBet > tableBet)
    {
        [checkBetButton.imageView setImage:[UIImage imageNamed:@"raise-button.png"]];
    }*/
    [self updateBetButtonState];
}

-(IBAction)increaseBet:(id)sender {
    UIButton *chipPressed = sender;
    NSInteger chipTag = chipPressed.tag;
    NSNumber *chip;
    float chipAmount = 0;
    
    chip = [chipSet objectAtIndex:chipTag];
    chipAmount = [chip floatValue];
    
    playerBet += chipAmount;
    betIncrease += chipAmount;
    balance -= chipAmount;
    betToStayIn = tableBet - playerBet;
    if(betToStayIn < 0){
        betToStayIn = 0 ;
    }
    
    
    if(balance < [(NSNumber*)[chipSet objectAtIndex:0] floatValue]){
        [chip1 setEnabled:NO];
        [chip2 setEnabled:NO];
        [chip3 setEnabled:NO];
        [chip4 setEnabled:NO];
        [chip5 setEnabled:NO];
    }
    else if (balance < [(NSNumber*)[chipSet objectAtIndex:1] floatValue]){
        [chip1 setEnabled:YES];
        [chip2 setEnabled:NO];
        [chip3 setEnabled:NO];
        [chip4 setEnabled:NO];
        [chip5 setEnabled:NO];
    }
    else if(balance < [(NSNumber*)[chipSet objectAtIndex:2] floatValue]){
        [chip1 setEnabled:YES];
        [chip2 setEnabled:YES];
        [chip3 setEnabled:NO];
        [chip4 setEnabled:NO];
        [chip5 setEnabled:NO];
    }
    else if(balance < [(NSNumber*)[chipSet objectAtIndex:3] floatValue]){
        [chip1 setEnabled:YES];
        [chip2 setEnabled:YES];
        [chip3 setEnabled:YES];
        [chip4 setEnabled:NO];
        [chip5 setEnabled:NO];
    }
    else if(balance < [(NSNumber*)[chipSet objectAtIndex:4] floatValue]){
        [chip1 setEnabled:YES];
        [chip2 setEnabled:YES];
        [chip3 setEnabled:YES];
        [chip4 setEnabled:YES];
        [chip5 setEnabled:NO];
    }

    
    [self updateLabels];
}

-(IBAction)sendBetAction:(id)sender {
    [self disableBettingButtons];
    NSMutableArray *betActionArray;
    // check bet
    if(tableBet == 0 && playerBet == 0) {
        betActionArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(0)], nil];
    }
    // call bet
    else if(playerBet == tableBet || (tableBet > playerBet && balance - betToStayIn >= 0)){
        // make player bet equal to tableBet
        if(playerBet < tableBet){
            balance -= betToStayIn;
            playerBet = tableBet;
        }
        
        betToStayIn = 0;
        betIncrease = 0;
        betActionArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(1)], nil];
    }
    // raise bet
    else if(playerBet > tableBet) {
        betToStayIn = 0;
        betIncrease = 0;
        betActionArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(2)], nil];
        [betActionArray addObject:[[NSNumber alloc] initWithFloat:playerBet]];
    }
    // bet all of balance, notify server to make side pot
    else if (playerBet < tableBet && balance - betToStayIn < 0) {
        // increase player bet by entire balance
        playerBet += balance;
        
        // set player balance to 0
        balance = 0;
        
        betActionArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(3)], nil];
        [betActionArray addObject:[[NSNumber alloc] initWithFloat:playerBet]];
    }
    
    [btController sendData:betActionArray];
    
    [self updateLabels];
}

-(IBAction)resetBet:(id)sender {
    playerBet -= betIncrease;
    balance += betIncrease;
    betToStayIn = tableBet - playerBet;
    betIncrease = 0;
    [self enableBettingButtons];
    [self updateLabels];
}

-(IBAction)foldHand:(id)sender {
    [self disableBettingButtons];
    
    //[self newBetRound];
    
    NSMutableArray *betActionArray;
    betActionArray = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(4)], nil];
    
    [btController sendData:betActionArray];
}

-(void)enableBettingButtons {
    //NSLog(@"chip1: %f, chip2: %f, chip3: %f, chip4: %f",chip1.tag/100.0, chip2.tag/100.0, chip3.tag/100.0, chip4.tag/100.0);
    if(balance < [(NSNumber*)[chipSet objectAtIndex:0] floatValue]){
        [chip1 setEnabled:NO];
        [chip2 setEnabled:NO];
        [chip3 setEnabled:NO];
        [chip4 setEnabled:NO];
        [chip5 setEnabled:NO];
    }
    else if (balance < [(NSNumber*)[chipSet objectAtIndex:1] floatValue]){
        [chip1 setEnabled:YES];
        [chip2 setEnabled:NO];
        [chip3 setEnabled:NO];
        [chip4 setEnabled:NO];
        [chip5 setEnabled:NO];
    }
    else if(balance < [(NSNumber*)[chipSet objectAtIndex:2] floatValue]){
        [chip1 setEnabled:YES];
        [chip2 setEnabled:YES];
        [chip3 setEnabled:NO];
        [chip4 setEnabled:NO];
        [chip5 setEnabled:NO];
    }
    else if(balance < [(NSNumber*)[chipSet objectAtIndex:3] floatValue]){
        [chip1 setEnabled:YES];
        [chip2 setEnabled:YES];
        [chip3 setEnabled:YES];
        [chip4 setEnabled:NO];
        [chip5 setEnabled:NO];
    }
    else if(balance < [(NSNumber*)[chipSet objectAtIndex:4] floatValue]){
        [chip1 setEnabled:YES];
        [chip2 setEnabled:YES];
        [chip3 setEnabled:YES];
        [chip4 setEnabled:YES];
        [chip5 setEnabled:NO];
    }
    else {
        [chip1 setEnabled:YES];
        [chip2 setEnabled:YES];
        [chip3 setEnabled:YES];
        [chip4 setEnabled:YES];
        [chip5 setEnabled:YES];
    }
    
    [checkBetButton setEnabled:YES];
    [foldButton setEnabled:YES];
    [resetBetButton setEnabled:YES];
}

-(void)disableBettingButtons {
    [chip1 setEnabled:NO];
    [chip2 setEnabled:NO];
    [chip3 setEnabled:NO];
    [chip4 setEnabled:NO];
    [chip5 setEnabled:NO];
    [checkBetButton setEnabled:NO];
    [foldButton setEnabled:NO];
    [resetBetButton setEnabled:NO];
}

-(void)gameEnded:(NSString *)message {
    gameOverAlertView = [[UIAlertView alloc] initWithTitle:@"Game Ended"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [gameOverAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView == gameOverAlertView){
        NSLog(@"got the right alertview");
        ViewController *homeScreen = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
        homeScreen.view.hidden = NO;
        homeScreen.centerView.hidden = NO;
        homeScreen.nameField.text = playerName;
        homeScreen.joinGameButton.enabled = YES;
        
        // animate game screen out
        CGRect newFrame = self.view.frame;
        newFrame.origin.y += newFrame.size.height + 50;
        self.view.backgroundColor = [UIColor clearColor];
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationCurveEaseOut
                         animations:^{
                             self.view.frame = newFrame;
                         }
                         completion:^(BOOL finished){
                             [self.view removeFromSuperview];
                             //homeScreen.view.frame = self.view.frame;
                             //[self.view addSubview:homeScreen.view];
                             //homeScreen.menuView.hidden = NO;
                             [self.view bringSubviewToFront:homeScreen.centerView];
                         }];
        [self presentModalViewController:homeScreen animated:YES];
    }
    

}
     
-(void) updateBetButtonState {
    if(tableBet == 0 && playerBet == 0)
    {
        [checkBetButton.titleLabel setText:@"Check"];
        //[checkBetButton.imageView setImage:[UIImage imageNamed:@"check-button.png"]];
    }
    else if (playerBet == tableBet || playerBet < tableBet)
    {
        [checkBetButton.titleLabel setText:@"Call"];
        //[checkBetButton.imageView setImage:[UIImage imageNamed:@"call-button.png"]];
    }
    else if (playerBet > tableBet)
    {
        [checkBetButton.titleLabel setText:@"Raise"];
        //[checkBetButton.imageView setImage:[UIImage imageNamed:@"raise-button.png"]];
    }
}

-(void) showBlindChip:(int)blindFlag {
    CGRect onScreenChip = CGRectMake(5, card1ImageView.center.y - blindChip.frame.size.height/2, 45, 45);
    
    if (blindFlag == 0) {
        blindChip.image = [UIImage imageNamed:@"smallBlindChip-iphone.png"];
    }
    else {
        blindChip.image = [UIImage imageNamed:@"bigBlindChip-iphone.png"];
    }
    
    blindChip.hidden = NO;
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(3.14159*2);
    
    [UIView animateWithDuration:1
                          delay:1
                        options:UIViewAnimationCurveEaseIn
                     animations:^{
                         blindChip.frame = onScreenChip;
                         blindChip.transform = transform;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void) hideBlindChip {
    CGRect offScreenChip = blindChip.frame;
    
    offScreenChip.origin.x -= (10 + blindChip.frame.size.width);
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(3.14159*2);
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         self.blindChip.frame = offScreenChip;
                         self.blindChip.transform = transform;
                     }
                     completion:^(BOOL finished){
                         [self.blindChip setHidden:YES];
                     }];
}

@end
