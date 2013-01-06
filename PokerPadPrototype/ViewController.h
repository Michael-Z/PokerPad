//
//  ViewController.h
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 9/6/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <AVFoundation/AVFoundation.h>
//#import <GameKit/GameKit.h>
#import "PlayerGameScreenViewController.h"
#import "ClientBluetoothController.h"
#import "MBProgressHUD.h"

@class PlayerGameScreenViewController;
@class ClientBluetoothController;
@interface ViewController : UIViewController <UITextFieldDelegate> {
    
    /* Interface Elements */
    
    int verticalOffset;
    IBOutlet UIButton *joinGameButton;
    IBOutlet UITextField *nameField;

    IBOutlet UIImageView *logo;
    
    IBOutlet UIView *centerView, *helpView, *aboutView;
    
    MBProgressHUD *HUD;
    
    /* Bluetooth Elements */
    
    //GKSession *btSession;
    
    BOOL connected;
    NSTimer *connectionTimer;
    
    PlayerGameScreenViewController *gameViewController;
    
    ClientBluetoothController *btController;
    
    /* helpView UI Elements */
    
    IBOutlet UILabel *helpTitle;
    IBOutlet UITextView *helpTextView;
    IBOutlet UIButton *helpBackButton;
    
    /* aboutView UI Elements */
    
    IBOutlet UILabel *aboutTitle;
    IBOutlet UITextView *aboutTextView;
    
}


@property (nonatomic, retain) NSTimer *connectionTimer;
@property (nonatomic, retain) IBOutlet UIButton *joinGameButton;
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) ClientBluetoothController *btController;
@property (nonatomic, retain) UIView *centerView, *helpView, *aboutView;
@property (nonatomic, retain) IBOutlet UILabel *helpTitle, *aboutTitle;
@property (nonatomic, retain) IBOutlet UITextView *helpTextView, *aboutTextView;

@property (nonatomic, retain) IBOutlet UIButton *helpButton;
@property (nonatomic, retain) IBOutlet UIButton *aboutButton;


//@property (nonatomic, retain) GKSession *btSession;

@property (nonatomic, assign) BOOL connected;

-(IBAction) joinGame:(id)sender;
-(IBAction) editingEnded:(id)sender;

-(IBAction)help:(id)sender;

-(IBAction)aboutUs:(id)sender;

-(void) startGame;

- (void)textFieldDidBeginEditing;

- (void)textFieldDidEndEditing;

-(IBAction)showAbout:(id)sender;
-(IBAction)hideAbout:(id)sender;


-(IBAction)showHelp:(id)sender;
-(IBAction)hideHelp:(id)sender;


@end

