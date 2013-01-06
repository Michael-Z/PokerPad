//
//  Deck.h
//  cardTest
//
//  Created by Matthew Wahlig on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject {
@private
    NSMutableArray* cards;
    NSInteger cardsLeft;
}

+ (Deck*) getSuffledDeck;
+ (Deck*) shuffle: (Deck*) deckToBeShuffled;
- (id) init;
- (Deck*) initWithDeck: (Deck*) allocatedDeck;
- (Card*) getCardAtIndex: (int) index;
- (Card*) drawCardFromDeck;

@end
