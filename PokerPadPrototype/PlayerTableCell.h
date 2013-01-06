//
//  PlayerTableCell.h
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 9/14/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerTableCell : UITableViewCell {
    UILabel *playerNameLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *playerNameLabel;

@end
