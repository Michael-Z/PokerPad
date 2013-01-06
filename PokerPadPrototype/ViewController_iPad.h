//
//  ViewController_iPad.h
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 9/6/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "PlayerTableCell.h"
#import "Player.h"
#import "GameScreenViewController.h"
#import "ServerBluetoothController.h"
#import "handComboView.h"
#import "ATSDragToReorderTableViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <dispatch/dispatch.h>

@class GameScreenViewController;
@class ServerBluetoothController;
@interface ViewController_iPad : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    /* Views */
    IBOutlet UIImageView *pp;

    IBOutlet UIImageView *imageView;
    IBOutlet UIImageView *secondimageView;
    IBOutlet UIImageView *AUimageView;
    IBOutlet UIView *menuView;
    IBOutlet UIView *settingsView;
    IBOutlet UIView *rulesView;
    IBOutlet UIView *handCombosView;
    IBOutlet UIView *helpView;
    IBOutlet UIView *aboutView;
    
    GameScreenViewController *gameViewController;
    ATSDragToReorderTableViewController *tableViewController;
    
    /* menuView Interface Elements */
    
    //IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *createGameButton;
    IBOutlet UIButton *helpButton;
    IBOutlet UIButton *aboutButton;
    
    /* settingsView Interface Elements */

    IBOutlet UIButton *startGameButton, *smallChipButton, *bigChipButton;
    IBOutlet UIButton *btIndicator;
    IBOutlet UITableView *playersTableView;
    PlayerTableCell *playerCell;
    UITextField *balanceTextField;
    UITextField *smallBlindTextField;
    UITextField *bigBlindTextField;
    IBOutlet UILabel *titleLabel, *handCombosTitleLabel;
    IBOutlet UILabel *gameTitleLabel, *playersLabel;
    IBOutlet UILabel *smallBlindLabel, *bigBlindLabel, *startingBalanceLabel;
    
    IBOutlet UISegmentedControl *chipSetControl;
    IBOutlet UIImageView *chip1;
    IBOutlet UIImageView *chip2;
    IBOutlet UIImageView *chip3;
    IBOutlet UIImageView *chip4;
    IBOutlet UIImageView *chip5;
    
    NSInteger smallChipSetSelected;
    
    /* rulesView Interface Elements */
    
    UILabel *rulesTitle;
    UITextView *rulesTextView;
    
    /* help View Interface Elements */
    
    UILabel *helpTitle;
    UITextView *helpTextView;
    
    /* aboutView Interface Elements */
    
    UILabel *aboutTitle;
    UITextView *aboutTextView;
    
    /* Bluetooth Elements */
    ServerBluetoothController *btController;
    
    /* Data Elements */
    NSMutableArray *peerArray;
    NSMutableArray *chipSet;
    
    NSNumberFormatter *moneyFormatter;
    
}

//@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIView *menuView;
@property (nonatomic, retain) UIView *settingsView;
@property (nonatomic, retain) UIView *rulesView, *handCombosView;
@property (nonatomic, retain) UIView *helpView;
@property (nonatomic, retain) UIView *aboutView;

@property (nonatomic, retain) UILabel *titleLabel, *handCombosTitleLabel;
@property (nonatomic, retain) UILabel *gameTitleLabel, *playersLabel, *smallBlindLabel, *bigBlindLabel, *startingBalanceLabel;

@property (nonatomic, retain) UIButton *createGameButton;
@property (nonatomic, retain) UIButton *helpButton;
@property (nonatomic, retain) UIButton *aboutButton;
@property (nonatomic, retain) UIButton *btIndicator;

@property (nonatomic, retain) UIButton *startGameButton, *smallChipButton, *bigChipButton;

@property (nonatomic, retain) IBOutlet UILabel *rulesTitle, *helpTitle, *aboutTitle;
@property (nonatomic, retain) IBOutlet UITextView *rulesTextView, *helpTextView, *aboutTextView;

@property (nonatomic, retain) IBOutlet UITableView *playersTableView;
@property (nonatomic, assign) IBOutlet PlayerTableCell *playerCell;

@property (nonatomic, retain) IBOutlet UITextField *balanceTextField;
@property (nonatomic, retain) IBOutlet UITextField *smallBlindTextField;
@property (nonatomic, retain) IBOutlet UITextField *bigBlindTextField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *chipSetControl;
@property (nonatomic, retain) IBOutlet UIImageView *chip1, *chip2, *chip3, *chip4, *chip5;

@property (nonatomic) NSInteger smallChipSetSelected;

@property (nonatomic, retain) NSMutableArray *peerArray;
@property (nonatomic, retain) NSMutableArray *chipSet;


@property (nonatomic, retain) NSNumberFormatter *moneyFormatter;

@property (nonatomic, retain) ServerBluetoothController *btController;


-(IBAction)createGame:(id)sender;

-(IBAction)help:(id)sender;

-(IBAction)aboutUs:(id)sender;

-(void)initMenu;
-(void)alignMenuButtons;

-(IBAction)numOfPlayersChange:(id)sender;

-(IBAction)chipSetChange:(id)sender;
-(IBAction)selectSmallChipSet:(id)sender;
-(IBAction)selectBigChipSet:(id)sender;

-(void)setFonts;

-(IBAction)editingEnded:(id)sender;

/* Bluetooth Methods */
-(void)checkIfGameIsReady;
-(IBAction)startGame:(id)sender;

- (void) test;
-(IBAction)enableTableEdit:(id)sender;
-(IBAction)rebroadcast:(id)sender;

-(IBAction)showAbout:(id)sender;
-(IBAction)hideAbout:(id)sender;


-(IBAction)showHelp:(id)sender;
-(IBAction)hideHelp:(id)sender;

-(IBAction)showRules:(id)sender;
-(IBAction)hideRules:(id)sender;


@end
