//
//  ScoreScene.m
//  LarryBird
//
//  Created by eric ringer on 6/23/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import "ScoreScene.h"


@implementation ScoreScene


-(id)initWithSize:(CGSize)size{
    
    if (self = [super initWithSize:size]){
        
        self.backgroundColor =[SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        scoreHelper = [[GameScoreHelper alloc] init];
        
        NSString *score;
        score = [NSString stringWithFormat:@"High Score: %d", [scoreHelper getScore]];
        SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        scoreLabel.text = score;
        scoreLabel.fontColor = [SKColor blueColor];
        scoreLabel.position = CGPointMake(self.size.width/2, 200);
        [self addChild:scoreLabel];
        
        NSString *gameCenter;
        gameCenter = @"Game Center";
        SKLabelNode *gameCenterButton = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        gameCenterButton.text = gameCenter;
        gameCenterButton.fontColor = [SKColor blueColor];
        gameCenterButton.position = CGPointMake(self.size.width/2, 150);
        gameCenterButton.name = @"Game Center";
        [gameCenterButton setScale:.5];
        [self addChild:gameCenterButton];
        
        NSString *mainMenu;
        mainMenu = @"Main Menu";
        SKLabelNode *menuButton = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        menuButton.text = mainMenu;
        menuButton.fontColor = [SKColor blueColor];
        menuButton.position = CGPointMake(self.size.width/2, 50);
        menuButton.name = @"menu";
        [menuButton setScale:.5];
        [self addChild:menuButton];
        
    }
    return self;
}

-(void)showGameCenterViewController{

    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc]init];
    
    if(gameCenterController != nil){
    
        gameCenterController.gameCenterDelegate = self;
        
        UIViewController *vc = self.view.window.rootViewController;
        
        [vc presentViewController: gameCenterController animated: YES completion:nil];
    }
}

-(void)gameCenterViewControllerDidFinish: (GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES
                                                 completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
     if ([node.name isEqualToString:@"menu"]) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        
        IntroScene * scene = [IntroScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: reveal];
        
     }else if ([node.name isEqualToString:@"Game Center"]){
     
         [self showGameCenterViewController];
     }
}


@end
