//
//  GameKitHelper.h
//  LarryBird
//
//  Created by eric ringer on 6/15/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

//#import <Foundation/Foundation.h>
@import GameKit;

extern NSString *const PresentAuthenticationViewController;

@interface GameKitHelper : NSObject

@property (nonatomic, readonly) UIViewController *authenticationViewController;
@property (nonatomic, readonly) NSError *lastError;

+(instancetype)sharedGameKitHelper;
-(void)authenticateLocalPlayer;
-(void)showGameCenterViewController: (UIViewController *)viewController;
-(void)reportScore:(int64_t)score forLeaderboardID:(NSString*)leaderboardID;


@end
