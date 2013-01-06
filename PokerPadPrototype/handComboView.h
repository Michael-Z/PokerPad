//
//  handComboView.h
//  customViewObjects
//
//  Created by Matt Wahlig on 12/10/12.
//  Copyright (c) 2012 Matt Wahlig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface handComboView : UIView {
    UILabel *handTitle;
    UIButton *infoButton;
    UIImageView *comboCard1;
    UIImageView *comboCard2;
    UIImageView *comboCard3;
    UIImageView *comboCard4;
    UIImageView *comboCard5;
}

@property (nonatomic, retain) IBOutlet UILabel *handTitle;
@property (nonatomic, retain) IBOutlet UIButton *infoButton;
@property (nonatomic, retain) IBOutlet UIImageView *comboCard1, *comboCard2, *comboCard3, *comboCard4, *comboCard5;

- (void)setComboBasedOnNumber:(int) comboNumber;

@end
