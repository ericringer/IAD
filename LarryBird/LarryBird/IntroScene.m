//
//  IntroScene.m
//  LarryBird
//
//  Created by eric ringer on 5/17/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import "IntroScene.h"
#import "MyScene.h"
#import "CIScene.h"
#import "GameKitHelper.h"


@implementation IntroScene

-(id)initWithSize:(CGSize)size{
    
    if (self = [super initWithSize:size]){
        
        self.backgroundColor =[SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];

        NSString *message;
        message = @"Larry Bird";
    
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = message;
        label.fontSize = 40;
        label.fontColor = [SKColor blueColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
        
        NSString *startMessage;
        startMessage = @"Start Game";
        SKLabelNode *startButton = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        startButton.text = startMessage;
        startButton.fontColor = [SKColor blueColor];
        startButton.position = CGPointMake(self.size.width/2, 100);
        startButton.name = @"start";
        [startButton setScale:.5];
        
        [self addChild:startButton];
        
    }
    
    NSString *creditMessage;
    creditMessage = @"Credits & Instructions";
    SKLabelNode *creditButton = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    creditButton.text = creditMessage;
    creditButton.fontColor = [SKColor blueColor];
    creditButton.position = CGPointMake(self.size.width/2, 50);
    creditButton.name = @"credits";
    [creditButton setScale:.5];
    
    [self addChild:creditButton];
    
    NSString *gameCenter;
    gameCenter = @"Game Center";
    SKLabelNode *gcButton = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    gcButton.text = gameCenter;
    gcButton.fontColor = [SKColor blueColor];
    gcButton.position = CGPointMake(self.size.width/2, 75);
    gcButton.name = @"gamecenter";
    [gcButton setScale:.5];
    
    [self addChild:gcButton];
    
    
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"start"]) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        MyScene *scene = [MyScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: reveal];
        
    }else if ([node.name isEqualToString:@"credits"]){
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        CIScene *ciScene = [CIScene sceneWithSize:self.view.bounds.size];
        ciScene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:ciScene transition: reveal];
    }else if ([node.name isEqualToString:@"gamecenter"]){
        
        [self showGameCenterViewController];
        
    }
}

-(void)showGameCenterViewController{
    
    GKGameCenterViewController *gameCenterViewController = [[GKGameCenterViewController alloc] init];
    
    //set delegate
    gameCenterViewController.gameCenterDelegate = self;
    
    //[gameCenterViewController presentViewController:gameCenterViewController animated:YES completion:nil];
}

-(void)gameCenterViewControllerDidFinish: (GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES
                                                 completion:nil];
}

@end
