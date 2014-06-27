//
//  GameScoreHelper.h
//  LarryBird
//
//  Created by eric ringer on 6/25/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"

@protocol GameScoreHelperDelegate <NSObject>

@end

@interface GameScoreHelper : NSObject{

    id <GameScoreHelperDelegate> mySceneDelegate;
    
    int score;
    
}

    
-(int)getScore;
-(void)setScore:(int)Score;

@property (nonatomic, retain) id <GameScoreHelperDelegate> mySceneDelegate;

@end
