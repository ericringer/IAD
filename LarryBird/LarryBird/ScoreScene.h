//
//  ScoreScene.h
//  LarryBird
//
//  Created by eric ringer on 6/23/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "IntroScene.h"
#import "MyScene.h"
#import "GameScoreHelper.h"


@interface ScoreScene : SKScene<GKGameCenterControllerDelegate> {
    
    GameScoreHelper *scoreHelper;
}

@end
