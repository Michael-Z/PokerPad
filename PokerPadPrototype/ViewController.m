//
//  ViewController.m
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 9/6/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import "ViewController.h"
#import "ViewController_iPad.h"
//#import <GameKit/GameKit.h>

@implementation ViewController

//@synthesize btSession;
@synthesize joinGameButton;
@synthesize nameField;
@synthesize connected;
@synthesize btController;
@synthesize centerView, helpView, aboutView;
@synthesize helpTitle, aboutTitle;
@synthesize helpTextView, aboutTextView;
@synthesize helpButton;
@synthesize aboutButton;
@synthesize connectionTimer;

#define kOFFSET_FOR_KEYBOARD 80.0

- (void)viewDidLoad
{
    NSLog(@"name field contents: '%@'",nameField.text);
    connected = NO;
    nameField.delegate = self;
    if([nameField.text length] <= 0) {
        [joinGameButton setEnabled:NO];
    }
    UIFont *cooperBlack = [UIFont fontWithName:@"CooperBeckerPosterBlack" size:nameField.font.pointSize];
    [nameField setFont:cooperBlack];
    //splash screen
    //self.centerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@".png"]];
    
    [super viewDidLoad];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f){
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iphone5-felt3.png"]];
        self.centerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stitched-leather-iphone5.png"]];
    } else {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iphone-felt.png"]];
        self.centerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stitched-leather-iphone.png"]];
    }
    
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;


	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
     return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITextFieldDelegate methods

/* Bluetooth Methods */

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

/* Custom Methods */

-(IBAction) joinGame:(id)sender {
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Finding Game";
    
    HUD.delegate = self;
    
    connectionTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(stopConnection:) userInfo:nil repeats:NO];

    self.btController = [[ClientBluetoothController alloc] init];
    
    self.btController.viewController = self;
    
    [self.btController joinGame:nameField.text];
    
    /*//if not connected, then connect
    if(connected)
    {
        [btSession disconnectFromAllPeers];
    }
    btSession = [[GKSession alloc] initWithSessionID:@"com.pokerpad.PokerPadPrototype" displayName:nameField.text sessionMode:GKSessionModeClient];
    btSession.delegate = self;
    btSession.available = YES;
    [btSession setDataReceiveHandler:btController withContext:nil];
    NSLog(@"Device: %@ | PeerID: %@",btSession.displayName,btSession.peerID);
    
    usleep(900000);
    
    NSArray *peers = [btSession peersWithConnectionState:GKPeerStateAvailable];
    
    if(peers.count > 0){
        [btSession connectToPeer:[peers objectAtIndex:0] withTimeout:10];
    }
    else {
        NSLog(@"No available server found.");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Status"
                                                        message:@"No available server found, try again."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }*/

}

-(void)stopConnection:(NSTimer *) theTimer {
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"failed.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"No Games Found";
    
    [HUD hide:YES afterDelay:2];
}

//textfield move when keyboard appear
-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    [joinGameButton setEnabled:NO];
    return YES;
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    // init helpView UI Elements
    [helpTitle setText:@"PokerPad\nHelp"];
    [helpTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:25]];
    helpTitle.alpha = 0.5;
    [helpTextView setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:15]];
    [helpTextView setTextColor:[UIColor whiteColor]];
    helpTextView.alpha = 0.5;
    helpTextView.text = [NSString stringWithFormat:@"1)  Create a Game\n\t-  Press the PokerPad logo upon launch to create a game.\n\t-  From there, a settings screen will appear, allowing you to modify some game settings and to see who has joined the game.\n\t-  Once enough players have joined, the start game button will highlight, allowing you to start the game.\n\n2)  Dealing a Hand\n\t-  Simply press the start hand button to deal a hand.\n\t-  From there, all the bet handling and remaining dealing is automated by the iPad until the start of another hand."];
    
    // init aboutView interface elements
    [aboutTitle setText:@"About\nPokerPad"];
    [aboutTitle setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:25]];
    aboutTitle.alpha = 0.5;
    [aboutTextView setFont:[UIFont fontWithName:@"CooperBeckerPosterBlack" size:15]];
    [aboutTextView setTextColor:[UIColor whiteColor]];
    aboutTextView.alpha = 0.5;
    
    aboutTextView.text = [NSString stringWithFormat:@"Designed and Developed by:\nMatt Wahlig\nDanny Franklin\nMatthew Johnson\nMingyao Zhu\nRyan Burr"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void) startGame {
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"Connected";
    
    [HUD hide:YES afterDelay:2];
    //Transition to game screen
    
    CGRect newFrame = centerView.frame;
    newFrame.origin.y -= 3000;
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationTransitionCurlUp
                     animations:^{
                         centerView.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    if(gameViewController == nil){
        gameViewController = [[PlayerGameScreenViewController alloc] initWithNibName:@"PlayerGameScreenViewController" bundle:nil];
    }
    [gameViewController setBtController:btController];
    gameViewController.playerName = nameField.text;
    // resize menuView
    
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
                         
                     }];
    
}

-(IBAction) screenTapped:(id)sender {
    [nameField resignFirstResponder];
    UITextField *name = nameField;
    if([name.text length] > 0 && [[name.text stringByTrimmingCharactersInSet:[NSCharacterSet alphanumericCharacterSet]] length] == 0){
        [joinGameButton setEnabled:YES];
    }
    else {
        [joinGameButton setEnabled:NO];
    }
}

-(IBAction) editingEnded:(id)sender {
    [sender resignFirstResponder];
    UITextField *name = sender;
    if([name.text length] > 0 && [[name.text stringByTrimmingCharactersInSet:[NSCharacterSet alphanumericCharacterSet]] length] == 0){
        [joinGameButton setEnabled:YES];
    }
    else {
        [joinGameButton setEnabled:NO];
    }
    
}


-(IBAction)showAbout:(id)sender {
    CGRect mainView = self.view.frame;
    
    CGRect newCenterView = centerView.frame;
    
    newCenterView.origin.y -= (newCenterView.size.height + 50);
    
    CGRect newFrame = mainView;
    
    newFrame.origin.y -= (newFrame.size.height + 50);
    
    aboutView.frame = newFrame;
    
    [self.view addSubview:aboutView];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         centerView.frame = newCenterView;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationTransitionCurlUp
                     animations:^{
                         aboutView.frame = mainView;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}
-(IBAction)hideAbout:(id)sender {
    //CGRect settingsFrame = settingsView.frame;
    CGRect newCenterView = centerView.frame;
    
    newCenterView.origin.y += (newCenterView.size.height + 50);
    
    CGRect newFrame = aboutView.frame;
    
    newFrame.origin.y -= (newFrame.size.height + 50);
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         aboutView.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         centerView.frame = newCenterView;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}
-(IBAction)showHelp:(id)sender {

    CGRect mainView = self.view.frame;
    
    CGRect newCenterView = centerView.frame;
    
    newCenterView.origin.y -= (newCenterView.size.height + 50);
    
    CGRect newFrame = mainView;
    
    newFrame.origin.y -= (newFrame.size.height + 50);
    
    helpView.frame = newFrame;
    
    [self.view addSubview:helpView];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         centerView.frame = newCenterView;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationTransitionCurlUp
                     animations:^{
                         helpView.frame = mainView;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}
-(IBAction)hideHelp:(id)sender {
    CGRect newCenterView = centerView.frame;
    
    newCenterView.origin.y += (newCenterView.size.height + 50);
    
    CGRect newFrame = helpView.frame;
    
    newFrame.origin.y -= (newFrame.size.height + 50);
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         helpView.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationTransitionCurlDown
                     animations:^{
                         centerView.frame = newCenterView;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}


@end
