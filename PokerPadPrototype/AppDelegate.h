//
//  AppDelegate.h
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 9/6/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@class ViewController;
@class ViewController_iPad;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    GKSession *gameSession;
}

@property (nonatomic, retain) GKSession *gameSession;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) ViewController_iPad *viewController_iPad;

@end
