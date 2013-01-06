//
//  Card.m
//  cardTest
//
//  Created by Matthew Wahlig on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize suit;
@synthesize value;
@synthesize rank;

-(id)init {
    self = [super init];
    if(self) {
        self->suit = nil;
        self->value = 0;
        self->rank = 0;
    }
    
    return self;
}

-(id)initWithSuit:(NSString*)s AndValue:(NSInteger)v AndRank:(NSInteger)r {
    self = [super init];
    if(self) {
        self->suit = s;
        self->value = v;
        self->rank = r;
    }
    
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:suit];
    [aCoder encodeObject:[NSNumber numberWithInteger:value]];
    [aCoder encodeObject:[NSNumber numberWithInteger:rank]];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    suit = [aDecoder decodeObject];
    value = [[aDecoder decodeObject] integerValue];
    rank = [[aDecoder decodeObject] integerValue];
    
    return self;
}

-(NSString*)getCardSuit {
    return suit;
}
-(NSInteger)getCardValue {
    return value;
}
-(NSInteger)getCardRank {
    return rank;
}

-(void)setSuit:(NSString *)s{
    self.suit = s;
}

@end
