//
//  LarryBirdNavigationViewController.m
//  LarryBird
//
//  Created by eric ringer on 6/16/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import "LarryBirdNavigationViewController.h"
#import "GameKitHelper.h"

@interface LarryBirdNavigationViewController ()

@end

@implementation LarryBirdNavigationViewController

/*-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //registering the PresentAuthenticationView Controller
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(showAuthenticationViewController)
     name:PresentAuthenticationViewController object:nil];
    
    [[GameKitHelper sharedGameKitHelper] authenticateLocalPlayer];
    
}

//present the authenticationViewController over the top view controller
-(void)showAuthenticationViewController{

    GameKitHelper *gameKitHelper = [GameKitHelper sharedGameKitHelper];
    
    [self.topViewController presentViewController:gameKitHelper.authenticationViewController animated:YES completion:nil];
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
