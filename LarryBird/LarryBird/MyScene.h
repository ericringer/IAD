//
//  MyScene.h
//  LarryBird
//

//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScoreHelper.h"
#import "AchievementHelper.h"

@interface MyScene : SKScene <SKPhysicsContactDelegate>
{
    
    bool isHit;
    bool isJumping;
    
    int speed;
    int hitCount;
    int position;
    int blueValue;
    int greenValue;
    int orangeValue;
    int pinkValue;
    
    NSTimeInterval lastUpdateTime;
    NSTimeInterval runTime;
    
    NSUInteger score;
    int scoreTotal;
    
    SKAction *jumpMovement;
    SKAction *leverAnimation;
    
    SKLabelNode *scoreLabel;
    
    SKSpriteNode *ball;
    SKSpriteNode *bird;
    SKSpriteNode *blue;
    SKSpriteNode *green;
    SKSpriteNode *orange;
    SKSpriteNode *pink;
    SKSpriteNode *playButton;
    SKSpriteNode *pauseButton;
    SKSpriteNode *heart;
    SKSpriteNode *heart1;
    SKSpriteNode *heart2;
    SKSpriteNode *lever;
    
    //GameScoreHelper *scoreHelper;
    AchievementHelper *achievementHelper;
    
}


@end
