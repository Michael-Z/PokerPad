//
//  Card.h
//  cardTest
//
//  Created by Matthew Wahlig on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject <NSCoding> {
@private
    NSString *suit; // HEART, DIAMOND, SPADE, CLUB
    NSInteger value; // ACE, 2, 3, ..., 10, JACK, QUEEN, KING
    NSInteger rank; // 
}

@property (retain, nonatomic) NSString *suit;
@property (nonatomic) NSInteger value;
@property (nonatomic) NSInteger rank;


-(id)init;
-(Card*)initWithSuit:(NSString*)s AndValue:(NSInteger)v AndRank:(NSInteger)r;

-(void)setSuit:(NSString *)s;

-(NSString*) getCardSuit;
-(NSInteger) getCardValue;
-(NSInteger) getCardRank;
@end
