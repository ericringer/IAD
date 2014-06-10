//
//  GameOverScene.m
//  LarryBird
//
//  Created by eric ringer on 5/14/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import "GameOverScene.h"
#import "MyScene.h"
#import "IntroScene.h"

@implementation GameOverScene

-(id)initWithSize:(CGSize)size gameOver:(BOOL)gameOver{
    
    if(self = [super initWithSize:size]){
        
        self.backgroundColor =[SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        //message
        NSString *message;
        if(gameOver == YES){
        
            message = [NSString stringWithFormat:@"Game Over!"];
            
            
            //game over sound effect
            SKAction *gameOverSound = [SKAction playSoundFileNamed:@"gameover.wav" waitForCompletion:NO];
            
            //play game over sound effect
            [self runAction:gameOverSound];
            
        }else{
            
            message = @"You Won!";
        }
        
        //label
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = message;
        label.fontSize = 40;
        label.fontColor = [SKColor blueColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
        
        NSString * retryMessage;
        retryMessage = @"Replay Game";
        SKLabelNode *retryButton = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        retryButton.text = retryMessage;
        retryButton.fontColor = [SKColor blueColor];
        retryButton.position = CGPointMake(self.size.width/2, 125);
        retryButton.name = @"retry";
        [retryButton setScale:.5];
        
        [self addChild:retryButton];
        
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"retry"]) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        
        MyScene * scene = [MyScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: reveal];
        
    }else if ([node.name isEqualToString:@"menu"]) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        
        IntroScene * scene = [IntroScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: reveal];
        
    }
}

@end
