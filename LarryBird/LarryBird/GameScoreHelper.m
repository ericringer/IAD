//
//  GameScoreHelper.m
//  LarryBird
//
//  Created by eric ringer on 6/25/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import "GameScoreHelper.h"

@implementation GameScoreHelper

@synthesize mySceneDelegate;

-(void)setScores: (int)Score{
    
    if (Score>[self getScore]) {
        
        score =[self getScore];
        score = Score;
        
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"score"];
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
}


-(int)getScore{
    
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"score"]intValue];
}

-(int)getTotalScore{
    
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"totalScore"] intValue];
}

-(void)setScore:(int)Score{
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:Score] forKey:@"totalScore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
