//
//  ScoreScene.h
//  LarryBird
//
//  Created by eric ringer on 6/23/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "IntroScene.h"
#import "AppDelegate.h"

@interface ScoreScene : SKScene

+(ScoreScene *)scene;

@property (nonatomic, retain)NSMutableArray *scoreArray;

@end
