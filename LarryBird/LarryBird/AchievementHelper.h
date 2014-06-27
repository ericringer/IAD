//
//  AchievementHelper.h
//  LarryBird
//
//  Created by eric ringer on 6/24/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface AchievementHelper : NSObject

+(GKAchievement *)blueFruitAchievement;
+(GKAchievement *)pinkFruitAchievement;
+(GKAchievement *)greenFruitAchievement;
+(GKAchievement *)firstWinAchievement;

@end
