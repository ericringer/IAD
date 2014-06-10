//
//  CIScene.m
//  LarryBird
//
//  Created by eric ringer on 5/24/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import "CIScene.h"
#import "IntroScene.h"

@implementation CIScene


-(id)initWithSize:(CGSize)size{
    
    if (self = [super initWithSize:size]){
        
        self.backgroundColor =[SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        NSString *credits = @"Credits:";
        SKLabelNode *creditLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        creditLabel.text = credits;
        creditLabel.fontSize = 40;
        creditLabel.fontColor = [SKColor blueColor];
        creditLabel.position = CGPointMake(self.size.width/2, 280);
        [self addChild:creditLabel];
        
        NSString *programmer;
        programmer = @"Game Created By: Eric Ringer";
        SKLabelNode *programmerLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        programmerLabel.text = programmer;
        programmerLabel.fontColor = [SKColor blueColor];
        programmerLabel.position = CGPointMake(self.size.width/2, 250);
        programmerLabel.name = @"programmer";
        [programmerLabel setScale:.5];
        [self addChild:programmerLabel];
        
        NSString *art;
        art = @"Game Art: www.gameelves.com";
        SKLabelNode *artLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        artLabel.text = art;
        artLabel.fontColor = [SKColor blueColor];
        artLabel.position = CGPointMake(self.size.width/2, 200);
        artLabel.name = @"art";
        [artLabel setScale:.5];
        [self addChild:artLabel];
        
        NSString *instructions = @"Instructions:";
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = instructions;
        label.fontSize = 40;
        label.fontColor = [SKColor blueColor];
        label.position = CGPointMake(self.size.width/2, 125);
        [self addChild:label];
        
        NSString *instructionMessage;
        instructionMessage = @"Tap the screen to make Larry jump over the ball!";
        SKLabelNode *instructionLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        instructionLabel.text = instructionMessage;
        instructionLabel.fontColor = [SKColor blueColor];
        instructionLabel.position = CGPointMake(self.size.width/2, 100);
        instructionLabel.name = @"credits";
        [instructionLabel setScale:.5];
        [self addChild:instructionLabel];
        
        
        NSString *mainMenu;
        mainMenu = @"Return to Main Menu";
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
    
    if ([node.name isEqualToString:@"menu"]) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        
        IntroScene *scene = [IntroScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: reveal];
        
    }
}

@end
