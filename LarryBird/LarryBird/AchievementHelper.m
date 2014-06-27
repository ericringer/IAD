//
//  AchievementHelper.m
//  LarryBird
//
//  Created by eric ringer on 6/24/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import "AchievementHelper.h"

//achievement ids
static NSString* const blueFruitAchievementID = @"blue_fruit";
static NSString* const pinkFruitAchievementID = @"pink_fruit";
static NSString* const greenFruitAchievementID = @"green_fruit";
static NSString* const firstWinAchievementID = @"first_win";

@implementation AchievementHelper

//get for first win completion achievement
+(GKAchievement *)firstWinAchievement{
    
    NSString *achievementID = firstWinAchievementID;
    
    GKAchievement *winAchievement = [[GKAchievement alloc]initWithIdentifier:achievementID];
    
    winAchievement.percentComplete = 100;
    winAchievement.showsCompletionBanner = YES;
    
    return winAchievement;
}

//get for collecting 10 blue fruits incremental achievement
+(GKAchievement *)blueFruitAchievement{

    NSString *blueAchievement = blueFruitAchievementID;
    
    GKAchievement *bfAchievement = [[GKAchievement alloc] initWithIdentifier:blueAchievement];
    
    bfAchievement.percentComplete = 100;
    bfAchievement.showsCompletionBanner = YES;
    
    return bfAchievement;
}

//get for collecting 10 pink fruits incremental achievement
+(GKAchievement *)pinkFruitAchievement{
    
    NSString *pinkAchievement = pinkFruitAchievementID;
    
    GKAchievement *pfAchievement = [[GKAchievement alloc] initWithIdentifier:pinkAchievement];
    
    pfAchievement.percentComplete = 100;
    pfAchievement.showsCompletionBanner = YES;
    
    return pfAchievement;
}

//get for collecting 10 green fruits negative achievement
+(GKAchievement *)greenFruitAchievement{
    
    NSString *greenAchievement = greenFruitAchievementID;
    
    GKAchievement *gfAchievement = [[GKAchievement alloc] initWithIdentifier:greenAchievement];
    
    gfAchievement.percentComplete = 100;
    gfAchievement.showsCompletionBanner = YES;
    
    return gfAchievement;
}

@end
