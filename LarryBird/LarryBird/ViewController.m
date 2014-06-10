//
//  ViewController.m
//  LarryBird
//
//  Created by eric ringer on 5/6/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import "ViewController.h"
#import "IntroScene.h"

@implementation ViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    // Configure the view.
    SKView *skView = (SKView *)self.view;
    CGSize viewSize = self.view.bounds.size;
    
    if (!skView.scene){
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene *scene = [IntroScene sceneWithSize:viewSize];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
   }
}

-(BOOL)prefersStatusBarHidden{

    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
