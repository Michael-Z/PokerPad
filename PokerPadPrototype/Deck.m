//
//  Deck.m
//  cardTest
//
//  Created by Matthew Wahlig on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Deck.h"

@implementation Deck
+ (Deck*) getSuffledDeck {
    Deck *d = [[Deck alloc] init];
    
    for(NSInteger j = 1; j <= 4; j++) {
        NSInteger r = j-1;
        NSString* suit;
        switch (j) {
            case 1:
                suit = @"s";
                break;
            case 2:
                suit = @"h";
                break;
            case 3:
                suit = @"d";
                break;
            case 4:
                suit = @"c";
                break;
            default:
                break;
        }
        for(NSInteger i = 14; i >= 2;i--) {
            Card *c = [[Card alloc] initWithSuit: suit AndValue: i AndRank: r];
            if(c) {
                [d->cards addObject: c];
                r=r+4;
            }
        }
    }
    
    return [Deck shuffle: d];
}

+ (Deck*) shuffle: (Deck*) deckToBeShuffled {
    srandom(time(NULL));
    NSUInteger count = [deckToBeShuffled->cards count];
    for (NSUInteger i = 0; i < count; ++i) {
        int elements = count - i;
        int n = (random() % elements) + i;
        [deckToBeShuffled->cards exchangeObjectAtIndex:i withObjectAtIndex:n];
    }    
    
    return deckToBeShuffled;
}

- (id) init {
    self = [super init];
    self->cards = [[NSMutableArray alloc] init];
    self->cardsLeft = 51; // actually 52, but 0-51 = 52
    return self;
}

- (Deck*) initWithDeck: (Deck*) allocatedDeck {
    if(allocatedDeck) self = allocatedDeck;
    return self;
}

- (Card*) getCardAtIndex: (int) index {
    return [cards objectAtIndex: index];
}

- (Card*) drawCardFromDeck {
    int r = arc4random() % cardsLeft;
    
    Card *c = [cards objectAtIndex:r];
    [cards removeObjectAtIndex:r];
    
    cardsLeft--;
    
    return c;
    
}
@end
