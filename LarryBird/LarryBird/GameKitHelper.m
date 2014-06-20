//
//  GameKitHelper.m
//  LarryBird
//
//  Created by eric ringer on 6/15/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import "GameKitHelper.h"

@interface GameKitHelper()<GKGameCenterControllerDelegate>
@end

@implementation GameKitHelper

NSString *const PresentAuthenticationViewController = @"present_authentication_view_controller";

//singleton
+(instancetype)sharedGameKitHelper{
    
    static GameKitHelper *sharedGameKitHelper;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedGameKitHelper = [[GameKitHelper alloc] init];
    });
    
    return sharedGameKitHelper;
}

BOOL enableGameCenter;

-(id)init {

    self = [super init];
    if(self){
    
        enableGameCenter = YES;
    }else{
    
        enableGameCenter = NO;
    }
    
    return self;
}

-(void)gameCenterViewControllerDidFinish: (GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES
                                                 completion:nil];
}

//authenticate the local player
-(void)authenticateLocalPlayer{

    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        
        [self setLastError:error];
        
        if(viewController != nil){
        
            [self setAuthenticationViewController:viewController];
        
        //if the local player is already signed in to game center
        }else if ([GKLocalPlayer localPlayer].isAuthenticated){
        
            enableGameCenter = YES;
        }else{
        
            enableGameCenter = NO;
        }
    };
}

-(void)setAuthenticationViewController: (UIViewController *)authenticationViewController{

    if (authenticationViewController != nil) {
        _authenticationViewController = authenticationViewController;
        
        //sends notification
        [[NSNotificationCenter defaultCenter]
         postNotificationName:PresentAuthenticationViewController object:self];
    }
}

//track errors
-(void)setLastError:(NSError *)error{

    _lastError = [error copy];
    
    if (_lastError) {
        
        NSLog(@"ERROR: %@", [[_lastError userInfo] description]);
    }
}

//creates and displays the GameCenterViewController
-(void)showGameCenterViewController:(UIViewController *)viewController{

    if (!enableGameCenter) {
        NSLog(@"Local play is not authenticated"); }
    
    GKGameCenterViewController *gameCenterViewController = [[GKGameCenterViewController alloc] init];
    
    //set delegate
    gameCenterViewController.gameCenterDelegate = self;
    
    gameCenterViewController.viewState = GKGameCenterViewControllerStateDefault;
    
    [viewController presentViewController:gameCenterViewController animated:YES completion:nil];
}

//sends score to game center
-(void)reportScore:(int64_t)score forLeaderboardID:(NSString *)leaderboardID
{
    if (!enableGameCenter) {
        NSLog(@"Local play is not authenticated"); }
    
    GKScore *scoreReporter = [[GKScore alloc]
                              initWithLeaderboardIdentifier:leaderboardID]; scoreReporter.value = score; scoreReporter.context = 0;
    NSArray *scores = @[scoreReporter];
    
    [GKScore reportScores:scores withCompletionHandler:^(NSError *error) {
        [self setLastError:error]; }];
}

@end
