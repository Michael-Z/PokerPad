//
//  PlayerTableCell.m
//  PokerPadPrototype
//
//  Created by Matthew Wahlig on 9/14/12.
//  Copyright (c) 2012 PokerPad. All rights reserved.
//

#import "PlayerTableCell.h"

@implementation PlayerTableCell

@synthesize playerNameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
