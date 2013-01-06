//
//  ViewController_iPad.m
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 9/6/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import "ViewController_iPad.h"
#import "Player.h"
#import <GameKit/GameKit.h>

@implementation ViewController_iPad

@synthesize playerCell = _playerCell;
@synthesize playersTableView = _playersTableView;
@synthesize rulesTextView, helpTextView, aboutTextView, handCombosView;
@synthesize rulesTitle, helpTitle, aboutTitle;

@synthesize moneyFormatter;
@synthesize peerArray;
@synthesize chipSet;
@synthesize menuView;
@synthesize rulesView;
@synthesize settingsView;
@synthesize helpView;
@synthesize aboutView;
@synthesize bigBlindTextField;
@synthesize createGameButton;
@synthesize aboutButton;
@synthesize titleLabel, handCombosTitleLabel;
@synthesize startGameButton, smallChipButton, bigChipButton;
@synthesize gameTitleLabel, playersLabel, smallBlindLabel, bigBlindLabel, startingBalanceLabel;
@synthesize balanceTextField;
@synthesize helpButton;
@synthesize smallBlindTextField;
@synthesize chipSetControl;
@synthesize chip1, chip2, chip3, chip4, chip5;
@synthesize smallChipSetSelected;
@synthesize btIndicator;


@synthesize btController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [self setFonts];
    
    [helpButton.titleLabel setFont:[UIFont fontWithName:@"American Captain" size:45]];
    [helpButton setTitleColor:[UIColor colorWithRed:135/255.0 green:99/255.0 blue:64/255.0 alpha:1] forState:UIControlStateNormal];
    [helpButton setTitleColor:[UIColor colorWithRed:94/255.0 green:69/255.0 blue:45/255.0 alpha:1] forState:UIControlStateHighlighted];
    [helpButton setTitleColor:[UIColor colorWithRed:148/255.0 green:140/255.0 blue:130/255.0 alpha:1] forState:UIControlStateDisabled];
    [helpButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [aboutButton.titleLabel setFont:[UIFont fontWithName:@"American Captain" size:45]];
    [aboutButton setTitleColor:[UIColor colorWithRed:135/255.0 green:99/255.0 blue:64/255.0 alpha:1] forState:UIControlStateNormal];
    [aboutButton setTitleColor:[UIColor colorWithRed:94/255.0 green:69/255.0 blue:45/255.0 alpha:1] forState:UIControlStateHighlighted];
    [aboutButton setTitleColor:[UIColor colorWithRed:148/255.0 green:140/255.0 blue:130/255.0 alpha:1] forState:UIControlStateDisabled];
    [aboutButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    [startGameButton.titleLabel setFont:[UIFont fontWithName:@"American Captain" size:45]];
    [startGameButton setTitleColor:[UIColor colorWithRed:78.0/255.0 green:149.0/255.0 blue:69.0/255.0 alpha:1] forState:UIControlStateNormal];
    [startGameButton setTitleColor:[UIColor colorWithRed:66/255.0 green:122/255.0 blue:59/255.0 alpha:1] forState:UIControlStateHighlighted];
    [startGameButton setTitleColor:[UIColor colorWithRed:123.0/255.0 green:146.0/255.0 blue:120.0/255.0 alpha:1] forState:UIControlStateDisabled];
    [startGameButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [startGameButton.titleLabel setFont:[UIFont fontWithName:@"American Captain" size:45]];
    [startGameButton setTitleColor:[UIColor colorWithRed:78.0/255.0 green:149.0/255.0 blue:69.0/255.0 alpha:1] forState:UIControlStateNormal];
    [startGameButton setTitleColor:[UIColor colorWithRed:66/255.0 green:122/255.0 blue:59/255.0 alpha:1] forState:UIControlStateHighlighted];
    [startGameButton setTitleColor:[UIColor colorWithRed:123.0/255.0 green:146.0/255.0 blue:120.0/255.0 alpha:1] forState:UIControlStateDisabled];
    [startGameButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [smallChipButton.titleLabel setFont:[UIFont fontWithName:@"American Captain" size:30]];
    [smallChipButton setTitleColor:[UIColor colorWithRed:78.0/255.0 green:149.0/255.0 blue:69.0/255.0 alpha:1] forState:UIControlStateNormal];
    [smallChipButton setTitleColor:[UIColor colorWithRed:66/255.0 green:122/255.0 blue:59/255.0 alpha:1] forState:UIControlStateHighlighted];
    [smallChipButton setTitleColor:[UIColor colorWithRed:123.0/255.0 green:146.0/255.0 blue:120.0/255.0 alpha:1] forState:UIControlStateDisabled];
    [smallChipButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [bigChipButton.titleLabel setFont:[UIFont fontWithName:@"American Captain" size:30]];
    [bigChipButton setTitleColor:[UIColor colorWithRed:78.0/255.0 green:149.0/255.0 blue:69.0/255.0 alpha:1] forState:UIControlStateNormal];
    [bigChipButton setTitleColor:[UIColor colorWithRed:66/255.0 green:122/255.0 blue:59/255.0 alpha:1] forState:UIControlStateHighlighted];
    [bigChipButton setTitleColor:[UIColor colorWithRed:123.0/255.0 green:146.0/255.0 blue:120.0/255.0 alpha:1] forState:UIControlStateDisabled];
    [bigChipButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-felt.png"]];
    self.menuView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lg-stitched-leather.png"]];
    
    // Prevent screen from going to sleep, thus
    // preventing unwanted Bluetooth disconnection
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    peerArray = [[NSMutableArray alloc] init];

    [self.settingsView setAlpha:0];
    [self initMenu];
    
    
	// Do any additional setup after loading the view.
    moneyFormatter = [[NSNumberFormatter alloc] init];
    [moneyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [smallBlindTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:0.05]]]];
    [bigBlindTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:0.10]]]];
    [balanceTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:5.00]]]];
    
    smallChipSetSelected = 1;
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    NSIndexPath *selection = [playersTableView indexPathForSelectedRow];
    
    smallChipButton.enabled = NO;
	if (selection)
		[playersTableView deselectRowAtIndexPath:selection animated:YES];
    
    
    // init rulesView interface elements
    [rulesTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:45]];
    [rulesTitle setText:@"Texas Hold'em\nRules"];
    [rulesTextView setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:30]];
    [rulesTextView setTextColor:[UIColor whiteColor]];
    rulesTextView.alpha = 0.5;
    rulesTitle.alpha = 0.5;
    rulesTextView.text = [NSString stringWithFormat:@"1)  The two players directly left of the dealer put out blind bets.\n\tFirst Player -> Small Blind\n\tSecond Player -> Big Blind\n\n2)  Following the blind bets, each player is dealt two cards face down, known as the pocket cards.\n\n3)  The player left of the big blind begins betting. They may choose to call/raise/fold."];
    
    // init poker hand interface elements
    [handCombosTitleLabel setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:42]];
    
    for (int i = 0, j = 0; i<10; i++) {
        handComboView *comboView;
        
        if(i <= 4){
            comboView = [[handComboView alloc] initWithFrame:CGRectMake(0, handCombosTitleLabel.frame.size.height + 115 * i, 360, 115)];
        }
        else {
            comboView = [[handComboView alloc] initWithFrame:CGRectMake(360, handCombosTitleLabel.frame.size.height + 115 * j, 360, 115)];
            j++;
        }
        [comboView setComboBasedOnNumber:i];
        [self.handCombosView addSubview:comboView];
    }
    
    
    
    
    
    // init helpView interface elements
    [helpTitle setText:@"PokerPad\nHelp"];
    [helpTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:45]];
    [helpTextView setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:30]];
    [helpTextView setTextColor:[UIColor whiteColor]];
    helpTextView.alpha = 0.5;
    helpTitle.alpha = 0.5;
    helpTextView.text = [NSString stringWithFormat:@"1)  Create a Game\n\t-  Press the PokerPad logo upon launch to create a game.\n\t-  From there, a settings screen will appear, allowing you to modify some game settings and to see who has joined the game.\n\t-  Once enough players have joined, the start game button will highlight, allowing you to start the game.\n\n2)  Dealing a Hand\n\t-  Simply press the start hand button to deal a hand.\n\t-  From there, all the bet handling and remaining dealing is automated by the iPad until the start of another hand."];
    
    // init aboutView interface elements
    [aboutTitle setText:@"About\nPokerPad"];
    [aboutTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:45]];
    aboutTitle.alpha = 0.5;
    [aboutTextView setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:35]];
    [aboutTextView setTextColor:[UIColor whiteColor]];
    aboutTextView.alpha = 0.5;
    
    aboutTextView.text = [NSString stringWithFormat:@"Designed and Developed by:\nMatt Wahlig\nDanny Franklin\nMatthew Johnson\nMingyao Zhu\nRyan Burr"];
    
}

- (void) test {
    NSLog(@"Peer count is currently: %d", peerArray.count);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [peerArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([peerArray count] == 0){
        UITableViewCell *cell = [[UITableViewCell alloc] init];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		return cell;
    }
    
    static NSString *playerIdentifier = @"playerIdentifier";
    
    //PlayerTableCell *cell = (PlayerTableCell *)[playersTableView dequeueReusableCellWithIdentifier:playerIdentifier];
    UITableViewCell *cell = [self.playersTableView dequeueReusableCellWithIdentifier:playerIdentifier];
    if(cell == nil) {
        //[[NSBundle mainBundle] loadNibNamed:@"PlayerTableCell" owner:self options:nil];
        //cell = _playerCell;
        cell = [[UITableViewCell alloc] init];
        cell.showsReorderControl = YES;
        //_playerCell = nil;
    }
    
    NSLog(@"Log row: %d peerCount: %d", indexPath.row, peerArray.count);
    
    Player *tempPlayer = [peerArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:tempPlayer.playerName];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setAlpha:0.5];
    [cell.textLabel setFont:[UIFont fontWithName:@"Comfortaa" size:20]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void) initMenu {
    
    CGRect tempFrame = self.menuView.frame;
    tempFrame.size.width *= 2;
    
    self.menuView.frame = tempFrame;
    self.menuView.center = self.view.center;
    [self alignMenuButtons];
}

- (void) alignMenuButtons {
    //self.titleLabel.center = CGPointMake(self.menuView.frame.size.width / 2, self.titleLabel.center.y);
    self.createGameButton.center = CGPointMake(self.menuView.frame.size.width / 2, self.createGameButton.center.y);
    self.helpButton.center = CGPointMake(self.menuView.frame.size.width / 2, self.helpButton.center.y);
    self.aboutButton.center = CGPointMake(self.menuView.frame.size.width / 2, self.aboutButton.center.y);

}

- (IBAction) createGame:(id)sender {
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"black.png"]];
    //bt sound
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"bt", CFSTR ("mp3"), NULL);
    
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURLRef,  &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    pp.image = [UIImage imageNamed:@"pokerpad_icon.png"];
    
    
    
    self.titleLabel.alpha = 0;

    
    //creat game animation
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.createGameButton.transform = CGAffineTransformMakeScale(2,2);
    [UIView commitAnimations];

    
    //playersTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    /*
    [UIView animateWithDuration:.8f animations:^{
        CGRect newBounds = self.menuView.bounds;
        if (newBounds.size.width > 400)
        {
        [self.settingsView setAlpha:100];
        newBounds.size.width -= 200;
        
        self.menuView.bounds = newBounds;
        
        self.menuView.center = CGPointMake(132, self.menuView.center.y);
        [self alignMenuButtons];
        }
        if (self.createGameButton.alpha == 1) {
            self.createGameButton.alpha=0;
            self.createGameButton.enabled = NO;
        }
     
    }];
     */
    
    
    // move menuView off screen
    if (self.createGameButton.alpha == 1) {
        self.createGameButton.alpha=0;
        self.createGameButton.enabled = NO;
    }
    CGRect newFrame = menuView.frame;

    newFrame.origin.y -= 3000;
    [UIView beginAnimations:@"MoveMenuViewUp" context:NULL];
    [UIView setAnimationDuration:5];
    
    
    
    
    menuView.frame = newFrame;
    
        
    [UIView commitAnimations];
    
    
    // resize menuView
    newFrame = menuView.frame;
    newFrame.size.width = 244;
    newFrame.size.height = self.view.frame.size.height;
    menuView.frame = newFrame;
    //menuView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Leather5.png"]];
    menuView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sm-stitched-leather.png"]];
    self.menuView.center = CGPointMake(122, self.menuView.center.y);
    
    [UIView beginAnimations:@"MoveMenuViewDown" context:NULL];
    [UIView setAnimationDuration:.8f];
    
    newFrame = menuView.frame;
    newFrame.origin.y += 3000;
    menuView.frame = newFrame;
    [self alignMenuButtons];
    
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationTransitionCurlDown];
    [UIView commitAnimations];
    
    newFrame = settingsView.frame;
    newFrame.origin.x += 3000;
    settingsView.frame = newFrame;
    
    
    [UIView beginAnimations:@"ShowSettingsView" context:NULL];
    [UIView setAnimationDuration:.8f];
    
    newFrame = settingsView.frame;
    newFrame.origin.x -= 3000;
    settingsView.frame = newFrame;
    [self.settingsView setAlpha:100];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView commitAnimations];

    
    //buttons appear
    [UIView beginAnimations:@"Showbbs" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(showHideDidStop:finished:context:)];
    
    pp.alpha = 1;
    
    [UIView commitAnimations];
    
    //[UIView animateWithDuration:.9f animations:^{ [self.settingsView setAlpha:100]; }];
    
    btController = [[ServerBluetoothController alloc] init];
    
    [btController setViewController:self];
    
    [btController startBT];
    [btController setPeerArray:peerArray];
    
    [UIView beginAnimations:@"Showbbs" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(showHideDidStop:finished:context:)];
    
    self.helpButton.alpha=1;
    self.aboutButton.alpha =1;
    
    // Commit the changes and perform the animation.
    
    [UIView commitAnimations];
    
    [self checkIfGameIsReady];
}

-(IBAction) editingEnded:(id)sender {
    
    UITextField *temp = sender;
    float newValue = [temp.text floatValue];
    
    [temp setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:newValue]]]];
    
    [sender resignFirstResponder];
}

-(void)checkIfGameIsReady {
    BOOL isGameReady = YES;
    
    // check if there are at least 2 players
    if(peerArray.count < 2){
        isGameReady = NO;
    }
    // check if small/big blind and starting balance values are set
    else if(smallBlindTextField.text.length == 0 || bigBlindTextField.text.length == 0 || startingBalanceLabel.text.length == 0) {
        isGameReady = NO;
    }
    
    if(isGameReady){
        startGameButton.enabled = YES;
    } else {
        startGameButton.enabled = NO;
    }
}

-(IBAction)startGame:(id)sender {
    //Transition to game screen
    /*
    if([peerArray count] < 2)
    {
        return;
    }
    */
    NSString *smBlindString = smallBlindTextField.text;
    NSString *bgBlindString = bigBlindTextField.text;
    NSString *balString = balanceTextField.text;
    NSNumber *balanceVal = [moneyFormatter numberFromString:balString];
    NSInteger seatNumber = 0;
    
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"bt", CFSTR ("mp3"), NULL);
    
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURLRef,  &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    //animation - not working
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    gameTitleLabel.frame = CGRectMake(gameTitleLabel.frame.origin.x - 400, gameTitleLabel.frame.origin.x, gameTitleLabel.frame.size.width, gameTitleLabel.frame.size.height);
    [UIView commitAnimations];  
    
    if(gameViewController == nil){
        gameViewController = [[GameScreenViewController alloc] initWithNibName:@"GameScreenViewController" bundle:nil];
    }
    for (Player *p in peerArray) {
        p.seatNumber = seatNumber;
        p.balance = [balanceVal floatValue];
        seatNumber++;
    }

    if(smallChipSetSelected == 1){
        NSNumber *c1 = [[NSNumber alloc] initWithFloat:.05];
        NSNumber *c2 = [[NSNumber alloc] initWithFloat:.1];
        NSNumber *c3 = [[NSNumber alloc] initWithFloat:.25];
        NSNumber *c4 = [[NSNumber alloc] initWithFloat:.5];
        NSNumber *c5 = [[NSNumber alloc] initWithFloat:1];
        NSMutableArray *smallChips = [[NSMutableArray alloc] initWithObjects:c1,c2,c3,c4,c5, nil];
        chipSet = smallChips;
    } else {
        NSNumber *c1 = [[NSNumber alloc] initWithFloat:.5];
        NSNumber *c2 = [[NSNumber alloc] initWithFloat:1];
        NSNumber *c3 = [[NSNumber alloc] initWithFloat:5];
        NSNumber *c4 = [[NSNumber alloc] initWithFloat:10];
        NSNumber *c5 = [[NSNumber alloc] initWithFloat:25];
        NSMutableArray *bigChips = [[NSMutableArray alloc] initWithObjects:c1,c2,c3,c4,c5, nil];
        chipSet = bigChips;
    }
    
    /*
    CGAffineTransform transform = CGAffineTransformMakeRotation(3.14159/2);
    gameViewController.p2SeatView.transform = transform;
    CGRect original = gameViewController.p2SeatView.frame;
    CGRect newLocation = CGRectMake(20, (self.view.bounds.size.height/2)-(original.size.height/2), original.size.width, original.size.height);
    
    gameViewController.p2SeatView.frame = newLocation;
    */
    
    btController.accepting = NO;
    
    btController.gameScreenController = gameViewController;
    gameViewController.btController = btController;
    gameViewController.peerArray = peerArray;
    gameViewController.chipSet = chipSet;
    
    // Initialize Blind Values and Blind Indices
    gameViewController.smallBlindValue = [[moneyFormatter numberFromString:smBlindString] floatValue];
    gameViewController.bigBlindValue = [[moneyFormatter numberFromString:bgBlindString] floatValue];
    gameViewController.smallBlindIndex = 0;
    gameViewController.bigBlindIndex = 1;
    
    for (Player *temp in peerArray) {
        [temp setGameScreen:gameViewController];
    }
    
    NSMutableArray *gameStartInfo = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:(-1)], nil];
    [gameStartInfo addObject:balanceVal];
    [gameStartInfo addObject:[[NSNumber alloc] initWithInteger:smallChipSetSelected]];
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:gameStartInfo];
    
    for (Player *p in peerArray) {
        [p sendData:dataToSend];
    }
    
    CGRect newFrame = menuView.frame;
    newFrame.origin.x -= 3000;
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         menuView.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    newFrame = settingsView.frame;
    newFrame.origin.x += 3000;
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         settingsView.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    newFrame = gameViewController.view.frame;
    newFrame.origin.y -= 3000;
    
    gameViewController.view.frame = newFrame;
    
    [self.view addSubview:gameViewController.view];
    
    newFrame.origin.y += 3000;
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         gameViewController.view.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         gameViewController.viewLoaded = YES;
                     }];
/*
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.view addSubview:gameViewController.view];
                    }
                    completion:NULL];
 */
}

-(IBAction)help:(id)sender {
    /*
    AUimageView.alpha = 0;
    
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"bt", CFSTR ("mp3"), NULL);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURLRef,  &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    [UIView beginAnimations:@"ShowHelpView" context:nil];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView setAnimationDuration:2.0];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(showHideDidStop:finished:context:)];
    
    
    
    // Make the animatable changes.
    
    secondimageView.alpha = 0.8;
    
    
    
    // Commit the changes and perform the animation.
    
    [UIView commitAnimations];
     */
    
}

-(IBAction)rebroadcast:(id)sender {
    if(btController.btSession.available == NO)
        [btController.btSession setAvailable:YES];
    else
        [btController.btSession setAvailable:NO];
}

-(IBAction)aboutUs:(id)sender {
    
    secondimageView.alpha = 0;
    
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"bt", CFSTR ("mp3"), NULL);
    
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURLRef,  &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    [UIView beginAnimations:@"ShowHelpView" context:nil];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView setAnimationDuration:2.0];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(showHideDidStop:finished:context:)];
    
    
    
    // Make the animatable changes.
    
    AUimageView.alpha = 0.8;
    
    
    
    // Commit the changes and perform the animation.
    
    [UIView commitAnimations];

}

-(IBAction)selectSmallChipSet:(id)sender {
    smallChipSetSelected = 1;
    [chip1 setImage:[UIImage imageNamed:@"5cents-small.png"]];
    [chip2 setImage:[UIImage imageNamed:@"10cents-small.png"]];
    [chip3 setImage:[UIImage imageNamed:@"25cents-small.png"]];
    [chip4 setImage:[UIImage imageNamed:@"50cents-small.png"]];
    [chip5 setImage:[UIImage imageNamed:@"1dollar-small.png"]];
    
    [smallBlindTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:0.05]]]];
    [bigBlindTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:0.10]]]];
    [balanceTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:5.00]]]];
    smallChipButton.enabled = NO;
    bigChipButton.enabled = YES;
}
-(IBAction)selectBigChipSet:(id)sender {
    smallChipSetSelected = 0;
    [chip1 setImage:[UIImage imageNamed:@"50cents-big.png"]];
    [chip2 setImage:[UIImage imageNamed:@"1dollar-big.png"]];
    [chip3 setImage:[UIImage imageNamed:@"5dollar-big.png"]];
    [chip4 setImage:[UIImage imageNamed:@"10dollar-big.png"]];
    [chip5 setImage:[UIImage imageNamed:@"25dollar-big.png"]];
    
    [smallBlindTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:0.50]]]];
    [bigBlindTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:1.00]]]];
    [balanceTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:20.00]]]];
    smallChipButton.enabled = YES;
    bigChipButton.enabled = NO;
}


-(IBAction)chipSetChange:(id)sender {
    switch (self.chipSetControl.selectedSegmentIndex) {
        case 0:
        {
            smallChipSetSelected = 1;
            [chip1 setImage:[UIImage imageNamed:@"5cents-small.png"]];
            [chip2 setImage:[UIImage imageNamed:@"10cents-small.png"]];
            [chip3 setImage:[UIImage imageNamed:@"25cents-small.png"]];
            [chip4 setImage:[UIImage imageNamed:@"50cents-small.png"]];
            [chip5 setImage:[UIImage imageNamed:@"1dollar-small.png"]];
            
            [smallBlindTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:0.05]]]];
            [bigBlindTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:0.10]]]];
            [balanceTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:5.00]]]];
            break;
        }
        case 1:
        {
            smallChipSetSelected = 0;
            [chip1 setImage:[UIImage imageNamed:@"50cents-big.png"]];
            [chip2 setImage:[UIImage imageNamed:@"1dollar-big.png"]];
            [chip3 setImage:[UIImage imageNamed:@"5dollar-big.png"]];
            [chip4 setImage:[UIImage imageNamed:@"10dollar-big.png"]];
            [chip5 setImage:[UIImage imageNamed:@"25dollar-big.png"]];
            
            [smallBlindTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:0.50]]]];
            [bigBlindTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:1.00]]]];
            [balanceTextField setText:[NSString stringWithFormat:@"%@",[moneyFormatter stringFromNumber:[NSNumber numberWithFloat:20.00]]]];
            break;
        }
            
        default:
            break;
    }
}

-(void) setFonts {
    [titleLabel setFont:[UIFont fontWithName:@"Comfortaa" size:20]];
    [gameTitleLabel setFont:[UIFont fontWithName:@"American Captain" size:65]];
    [gameTitleLabel setTextColor:[UIColor colorWithRed:78.0/255.0 green:149.0/255.0 blue:69.0/255.0 alpha:1]];
    [playersLabel setFont:[UIFont fontWithName:@"Comfortaa" size:28]];
    [smallBlindLabel setFont:[UIFont fontWithName:@"Comfortaa" size:20]];
    [bigBlindLabel setFont:[UIFont fontWithName:@"Comfortaa" size:20]];
    [startingBalanceLabel setFont:[UIFont fontWithName:@"Comfortaa" size:20]];
    [smallBlindTextField setFont:[UIFont fontWithName:@"Comfortaa" size:17]];
    [bigBlindTextField setFont:[UIFont fontWithName:@"Comfortaa" size:17]];
    [balanceTextField setFont:[UIFont fontWithName:@"Comfortaa" size:17]];
}

-(IBAction)enableTableEdit:(id)sender {
    /*
    if(playersTableView.editing == NO)
        [playersTableView setEditing:YES animated:YES];
    else
        [playersTableView setEditing:NO animated:NO];
     */
    playersTableView.editing = YES;
}

-(IBAction)showHelp:(id)sender {
    [helpButton setEnabled:NO];
    [aboutButton setEnabled:NO];
    
    CGRect settingsFrame = settingsView.frame;
    
    CGRect newFrame = settingsFrame;
    
    newFrame.origin.y += (newFrame.size.height + 50);
    
    helpView.frame = newFrame;
    
    [self.view addSubview:helpView];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         settingsView.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationTransitionCurlUp
                     animations:^{
                         helpView.frame = settingsFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(IBAction)hideHelp:(id)sender {
    CGRect settingsFrame = settingsView.frame;
    
    CGRect newFrame = settingsFrame;
    
    newFrame.origin.y -= (newFrame.size.height + 50);
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         helpView.frame = settingsFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         settingsView.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [helpButton setEnabled:YES];
    [aboutButton setEnabled:YES];
}

-(IBAction)showRules:(id)sender {
    
    [helpButton setEnabled:NO];
    [aboutButton setEnabled:NO];
    
    CGRect settingsFrame = settingsView.frame;
    
    CGRect newFrame = settingsFrame;
    
    newFrame.origin.y += (newFrame.size.height + 50);
    
    handCombosView.frame = newFrame;
    
    [self.view addSubview:handCombosView];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         settingsView.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationTransitionCurlUp
                     animations:^{
                         handCombosView.frame = settingsFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(IBAction)hideRules:(id)sender {
        
    CGRect settingsFrame = settingsView.frame;
    
    CGRect newFrame = settingsFrame;
    
    newFrame.origin.y -= (newFrame.size.height + 50);
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         handCombosView.frame = settingsFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         settingsView.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    
    [helpButton setEnabled:YES];
    [aboutButton setEnabled:YES];

}

-(IBAction)showAbout:(id)sender {
    [helpButton setEnabled:NO];
    [aboutButton setEnabled:NO];
    
    CGRect settingsFrame = settingsView.frame;
    
    CGRect newFrame = settingsFrame;
    
    newFrame.origin.y += (newFrame.size.height + 50);
    
    aboutView.frame = newFrame;
    
    [self.view addSubview:aboutView];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         settingsView.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationTransitionCurlUp
                     animations:^{
                         aboutView.frame = settingsFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}
-(IBAction)hideAbout:(id)sender {
    CGRect settingsFrame = settingsView.frame;
    
    CGRect newFrame = settingsFrame;
    
    newFrame.origin.y -= (newFrame.size.height + 50);
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         aboutView.frame = settingsFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         settingsView.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    
    [helpButton setEnabled:YES];
    [aboutButton setEnabled:YES];
}





@end
