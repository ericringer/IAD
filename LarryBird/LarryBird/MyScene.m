//
//  MyScene.m
//  LarryBird
//
//  Created by eric ringer on 5/6/14.
//  Copyright (c) 2014 eric ringer. All rights reserved.
//

#import "MyScene.h"
#import "GameOverScene.h"
#import "GameKitHelper.h"


//categories
static const uint32_t ballCategory   = 0x1;
static const uint32_t birdCategory   = 0x1 << 1;
static const uint32_t blueCategory   = 0x1 << 2;
static const uint32_t greenCategory  = 0x1 << 3;
static const uint32_t orangeCategory = 0x1 << 4;
static const uint32_t pinkCategory   = 0x1 << 5;

NSDictionary *leaderboardIDs;

@implementation MyScene

//static vectors for the cloud image
static const float CLOUD_VELOCITY = 100.0;
static inline CGPoint CGPointAdd(const CGPoint a, CGPoint b){
    
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b){
    
    return CGPointMake(a.x * b, a.y * b);
}


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:135.0/255 green:206.0/255.0 blue:250.0/255.0 alpha:1.0];
        
        
        [self initalizingCloudScrolling];
        [self initalizingMountainScrolling];
        
        leaderboardIDs = @{[NSString stringWithFormat:@"%d", score]:
                               @"com.ericringer.LarryBird_wins"};
        
        
        SKTextureAtlas *leverAtlas = [SKTextureAtlas atlasNamed:@"lever"];
        SKTexture *lever1 = [leverAtlas textureNamed:@"lever1.png"];
        SKTexture *lever2 = [leverAtlas textureNamed:@"lever2.png"];
        lever = [SKSpriteNode spriteNodeWithTexture:lever1];
        lever.position = CGPointMake(50, 50);
        
        NSArray *leverArray = @[lever1, lever2];
        leverAnimation = [SKAction animateWithTextures:leverArray timePerFrame:1.0];
        
        [self addChild:lever];
        
        //run lever animation
        [lever runAction:leverAnimation];
        
        //add heart sprites
        heart = [SKSpriteNode spriteNodeWithImageNamed:@"heart"];
        heart.position = CGPointMake(95, 300);
        heart.name = @"heart";
        [self addChild:heart];
        
        heart1 = [SKSpriteNode spriteNodeWithImageNamed:@"heart"];
        heart1.position = CGPointMake(60, 300);
        [self addChild:heart1];
        
        heart2 = [SKSpriteNode spriteNodeWithImageNamed:@"heart"];
        heart2.position = CGPointMake(25, 300);
        [self addChild:heart2];
        
        //by default isHit bool is NO
        isHit = NO;
        speed = 20;
        
        //by default score and values are set to 0
        score = 0;
        blueValue = 0;
        greenValue = 0;
        orangeValue = 0;
        pinkValue = 0;
        scoreTotal = score;
        
        //set physics world to have no gravity
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        //lets delegate know when sprites collide
        self.physicsWorld.contactDelegate = self;
        
        [self addBird];
        [self performSelector:@selector(addBall) withObject:nil afterDelay:2.0];
        
        [self addBlueFruit];
        [self performSelector:@selector(addBlueFruit) withObject:nil afterDelay:3.0];
        
        [self addGreenFruit];
        [self performSelector:@selector(addGreenFruit) withObject:nil afterDelay:5.0];
        
        [self addOrangeFruit];
        [self performSelector:@selector(addOrangeFruit) withObject:nil afterDelay:4.0];
        
        [self addPinkFruit];
        [self performSelector:@selector(addPinkFruit) withObject:nil afterDelay:7.0];
        
        [self setUpJump];
        
        //score label
        scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        scoreLabel.text = @"Score: 0";
        scoreLabel.fontSize = 30;
        scoreLabel.fontColor = [UIColor blackColor];
        scoreLabel.position = CGPointMake(10, CGRectGetMidY(self.frame) - 10);
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        [self addChild:scoreLabel];
        
     }
    
    return self;
}

-(void)initalizingCloudScrolling{
    
    for (int i = 0; i < 2; i++){
        
        //add cloud image and position
        SKSpriteNode *cloud = [SKSpriteNode spriteNodeWithImageNamed:@"clouds"];
        cloud.position = CGPointMake(i * cloud.size.width, 230);
        cloud.anchorPoint = CGPointZero;
        cloud.name = @"clouds";
        [self addChild:cloud];
    
        if(cloud.position.x <= -1){
            
            //remove cloud image
            [cloud removeFromParent];
        }
    }
}

-(void)initalizingMountainScrolling{
    
    for (int i = 0; i < 2; i++){
        
        //add mountain image
        SKSpriteNode *mountain = [SKSpriteNode spriteNodeWithImageNamed:@"mountains"];
        mountain.position = CGPointMake(i * mountain.frame.size.width, 0);
        mountain.anchorPoint = CGPointZero;
        mountain.name = @"mountains";
        
        [self addChild:mountain];
    }
}

//sets postion and velocity of cloud image
-(void)moveClouds{

    [self enumerateChildNodesWithName:@"clouds" usingBlock:^(SKNode *node, BOOL *stop) {
        
        SKSpriteNode *cloud = (SKSpriteNode *)node;
        CGPoint cloudVelocity = CGPointMake(-CLOUD_VELOCITY, 0);
        CGPoint cloudsToMove = CGPointMultiplyScalar(cloudVelocity, runTime);
        
        cloud.position = CGPointAdd(cloud.position, cloudsToMove);
        
        if(cloud.position.x <= -cloud.size.width){
        
            cloud.position = CGPointMake(cloud.position.x + cloud.size.width*2, cloud.position.y);
        }
    }];
}


-(void)addBird{
    bird = [SKSpriteNode spriteNodeWithImageNamed:@"bird"];
    bird.position = CGPointMake(300,65);
    bird.name = @"bird";
    
    //add physics
    bird.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bird.size];
    bird.physicsBody.dynamic = NO;
    bird.physicsBody.usesPreciseCollisionDetection = YES;
    bird.physicsBody.categoryBitMask = birdCategory;
    bird.physicsBody.collisionBitMask = ballCategory | blueCategory | greenCategory | orangeCategory | pinkCategory;
    bird.physicsBody.contactTestBitMask = ballCategory | blueCategory | greenCategory | orangeCategory | pinkCategory;
    
    [self addChild:bird];
}



-(void)movingBird{
    
    //make bird move
    SKAction *move = [SKAction moveByX:1.0 y:0 duration:5.0];
    [bird runAction:move];
}


-(void)setUpJump{
    
    //make bird jump up and land
    SKAction *jump  = [SKAction moveByX:0 y:210 duration:0.3];
    SKAction *jump2 = [SKAction moveByX:0 y:40 duration:0.3];
    SKAction *land  = [SKAction moveByX:0 y:-250 duration:0.4];
    SKAction *done  = [SKAction performSelector:@selector(jumpDone) onTarget:self];
    
    jumpMovement = [SKAction sequence:@[jump, jump2, land, done]];
    
}

//bird is done jumping
-(void)jumpDone{
    
    isJumping = NO;
    
}

-(void)didCollideWithBird:(SKSpriteNode*)balls{
    
    NSLog(@"Hit");
    
    [self doesHit];
    
    //removes ball when it hits the bird
    [ball removeFromParent];
}

-(void)didHitBlue:(SKSpriteNode*)blueFruit{
    
    NSLog(@"Got blue!");
    
    score = score + blueValue + 5;
    
    [self fruitHits];
    
    [blue removeFromParent];
}

-(void)didHitGreen:(SKSpriteNode*)greenFruit{
    
    NSLog(@"No green!");
    
    score = score + greenValue - 10;
    
    [self fruitHits];
    
    [green removeFromParent];
}

-(void)didHitOrange:(SKSpriteNode*)orangeFruit{
    
    NSLog(@"Yes orange!");
    
    score = score + orangeValue + 10;
    
    [self fruitHits];
    
    [orange removeFromParent];
}

-(void)didHitPink:(SKSpriteNode*)pinkFruit{
    
    NSLog(@"Yes pink!");
    
    score = score + pinkValue + 20;
    
    [self fruitHits];
    
    [pink removeFromParent];
}

//detect contact
-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    
    if(collision == (birdCategory | ballCategory)){
        
        [self didCollideWithBird:ball];
    }
    
    if(collision == (birdCategory | blueCategory)){
        
        [self didHitBlue:blue];
    }
    
    if(collision == (birdCategory | greenCategory)){
    
        [self didHitGreen:green];
    }
    
    if(collision == (birdCategory | orangeCategory)){
    
        [self didHitOrange:orange];
    }
    
    if(collision ==(birdCategory | pinkCategory)){
    
        [self didHitPink:pink];
    }
}

//Add ball and start point of where the ball appears
-(void)addBall{
    CGPoint startPoint = CGPointMake(1100, 50);
    ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
    ball.position = CGPointMake(startPoint.x, startPoint.y);
    ball.name = @"ball";
    
    //add physics to ball
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width/2];
    ball.physicsBody.dynamic = YES;
    ball.physicsBody.categoryBitMask = ballCategory;
    ball.physicsBody.contactTestBitMask = birdCategory;
    ball.physicsBody.collisionBitMask = 0;
    ball.physicsBody.usesPreciseCollisionDetection = YES;
    
    //add ball sprite
    [self addChild:ball];
    
    float randomNum = arc4random_uniform(3) + 3;
    [self performSelector:@selector(addBall) withObject:nil afterDelay:randomNum];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for(UITouch *touch in touches){
        
        pauseButton = [SKSpriteNode spriteNodeWithImageNamed:@"pauseButton"];
        CGPoint location = [touch locationInNode:self];
        
        pauseButton.position = CGPointMake(70, 125);
        
        //add pause button image
        [self addChild:pauseButton];
        
        if([pauseButton containsPoint:location]){
            
            //pause game
            self.scene.view.paused = YES;
        }
        else{
            
            playButton = [SKSpriteNode spriteNodeWithImageNamed:@"playButton"];
            CGPoint location = [touch locationInNode:self];
            playButton.position = CGPointMake(25, 125);
            
            //add play button image
            [self addChild:playButton];
            
            if([playButton containsPoint:location]){
            
            //restart game
            self.scene.view.paused = NO;
            
            }
      }
    }
    
    if(isJumping == NO){
        
        isJumping = YES;
        
        bird = (SKSpriteNode*)[self childNodeWithName:@"bird"];
        
        //run jump movement
        [bird runAction:jumpMovement];
        
        //add jump sound effect
        SKAction *jump = [SKAction playSoundFileNamed:@"jump.wav" waitForCompletion:NO];
        [bird runAction:jump];
        
     }
    
    [lever runAction:leverAnimation];
    
}

-(void)addBlueFruit{

    CGPoint startPoint = CGPointMake(1100, 90);
    blue = [SKSpriteNode spriteNodeWithImageNamed:@"blueFruit"];
    blue.position = CGPointMake(startPoint.x, startPoint.y);
    blue.name = @"blue";
    
    [self addChild:blue];
    
    //add physics to blue fruit
    blue.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:blue.size.width];
    blue.physicsBody.dynamic = YES;
    blue.physicsBody.categoryBitMask = blueCategory;
    blue.physicsBody.contactTestBitMask = birdCategory;
    blue.physicsBody.collisionBitMask = 0;
    blue.physicsBody.usesPreciseCollisionDetection = YES;
    
    float randomNum = arc4random_uniform(3) + 3;
    [self performSelector:@selector(addBlueFruit) withObject:nil afterDelay:randomNum];
}

-(void)addGreenFruit{
    
    CGPoint startPoint = CGPointMake(1100, 120);
    green = [SKSpriteNode spriteNodeWithImageNamed:@"greenFruit"];
    green.position = CGPointMake(startPoint.x, startPoint.y);
    green.name = @"green";
    [self addChild:green];
    
    //add physics to green fruit
    green.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:green.size.width];
    green.physicsBody.dynamic = YES;
    green.physicsBody.categoryBitMask = greenCategory;
    green.physicsBody.contactTestBitMask = birdCategory;
    green.physicsBody.collisionBitMask = 0;
    green.physicsBody.usesPreciseCollisionDetection = YES;
    
    float randomNum = arc4random_uniform(3) + 3;
    [self performSelector:@selector(addGreenFruit) withObject:nil afterDelay:randomNum];
}

-(void)addOrangeFruit{
    
    CGPoint startPoint = CGPointMake(1100, 150);
    orange = [SKSpriteNode spriteNodeWithImageNamed:@"orangeFruit"];
    orange.position = CGPointMake(startPoint.x, startPoint.y);
    orange.name = @"orange";
    [self addChild:orange];
    
    //add physics to orange fruit
    orange.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:orange.size.width];
    orange.physicsBody.dynamic = YES;
    orange.physicsBody.categoryBitMask = orangeCategory;
    orange.physicsBody.contactTestBitMask = birdCategory;
    orange.physicsBody.collisionBitMask = 0;
    orange.physicsBody.usesPreciseCollisionDetection = YES;
    
    float randomNum = arc4random_uniform(3) + 3;
    [self performSelector:@selector(addOrangeFruit) withObject:nil afterDelay:randomNum];
}

-(void)addPinkFruit{
    
    CGPoint startPoint = CGPointMake(1100, 220);
    pink = [SKSpriteNode spriteNodeWithImageNamed:@"pinkFruit"];
    pink.position = CGPointMake(startPoint.x, startPoint.y);
    pink.name = @"pink";
    
    [self addChild:pink];
    
    //add physics to pink fruit
    pink.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:pink.size.width];
    pink.physicsBody.dynamic = YES;
    pink.physicsBody.categoryBitMask = pinkCategory;
    pink.physicsBody.contactTestBitMask = birdCategory;
    pink.physicsBody.collisionBitMask = 0;
    pink.physicsBody.usesPreciseCollisionDetection = YES;
    
    float randomNum = arc4random_uniform(3) + 3;
    [self performSelector:@selector(addPinkFruit) withObject:nil afterDelay:randomNum];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    //check to see if bird sprite exists
   SKNode *birdNode = [self childNodeWithName:@"bird"];
    
    if(birdNode != nil){
    
        if( [birdNode isKindOfClass:[SKSpriteNode class]] ){
        
            bird = (SKSpriteNode*)birdNode;
    
        }
    }
    
    [self enumerateChildNodesWithName:@"ball" usingBlock:^(SKNode *node, BOOL *stop) {
        
        if(node.position.x <= 0 || node.position.y <= 0){
            
            //removes ball when it goes off screen
            [node removeFromParent];
         
        }else{
            
            //make ball roll straight
            node.position = CGPointMake(node.position.x - speed, node.position.y);
        }
        
        //check for collision
        if([bird intersectsNode:node] && isHit == NO){
            
            [self doesHit];
        }
    }];
    
    //run movingBird method
    //[self movingBird];
    
                                               
    if(lastUpdateTime){
        
        runTime = currentTime - lastUpdateTime;
    }else{
        
        runTime = 0;
    }
    
    lastUpdateTime = currentTime;
    
    //run moveClouds method
    [self moveClouds];
    
    [self enumerateChildNodesWithName:@"blue" usingBlock:^(SKNode *blueNode, BOOL *stop) {
        
        if(blueNode.position.x <= 0 || blueNode.position.y <= 0){
            
            //removes ball when it goes off screen
            [blueNode removeFromParent];
            
        }else{
            
            speed = 15;
            //make ball roll straight
            blueNode.position = CGPointMake(blueNode.position.x - speed, blueNode.position.y);
        }
    }];
    
    [self enumerateChildNodesWithName:@"green" usingBlock:^(SKNode *greenNode, BOOL *stop) {
        
        if(greenNode.position.x <= 0 || greenNode.position.y <= 0){
            
            //removes green fruit when it goes off screen
            [greenNode removeFromParent];
            
        }else{
            
            speed = 15;
            //make ball roll straight
            greenNode.position = CGPointMake(greenNode.position.x - speed, greenNode.position.y);
        }
    }];
    
    [self enumerateChildNodesWithName:@"orange" usingBlock:^(SKNode *orangeNode, BOOL *stop) {
        
        if(orangeNode.position.x <= 0 || orangeNode.position.y <= 0){
            
            //removes green fruit when it goes off screen
            [orangeNode removeFromParent];
            
        }else{
            
            speed = 15;
            //make ball roll straight
            orangeNode.position = CGPointMake(orangeNode.position.x - speed, orangeNode.position.y);
        }
    }];
    
    [self enumerateChildNodesWithName:@"pink" usingBlock:^(SKNode *pinkNode, BOOL *stop) {
        
        if(pinkNode.position.x <= 0 || pinkNode.position.y <= 0){
            
            //removes pink fruit when it goes off screen
            [pinkNode removeFromParent];
            
        }else{
            
            speed = 20;
            //make ball roll straight
            pinkNode.position = CGPointMake(pinkNode.position.x - speed, pinkNode.position.y);
        }
    }];
    
    scoreLabel.text = [NSString stringWithFormat:@"Score: %d", score];
    
}


-(void)doesHit{
    
    isHit = YES;
    
    hitCount ++;
    
    //pushes bird back if hit with ball
    SKAction *push = [SKAction moveByX:-25 y:0 duration: 0.2];
    
    [bird runAction:push];
    
    [self performSelector:@selector(ballHit) withObject:nil afterDelay:1.0];
    
    //turns bird red when hit with ball
    SKAction *turnRed = [SKAction sequence:@[
                                            [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:1.0 duration:0.5],
                                            [SKAction colorizeWithColorBlendFactor:0.0 duration:0.5],
                                            [SKAction performSelector:@selector(ballHit) onTarget:self]
                                            ]];
    
    [bird runAction:turnRed];
    
    //add hurt sound effect
    SKAction *hurtSound = [SKAction playSoundFileNamed:@"hurtsound.mp3" waitForCompletion:NO];
    
    //play sound effect
    [bird runAction:hurtSound];
    
    //run birdHits method
    [self birdHits];
    
}

-(void)fruitHits{

    if (score == 100){
        
        //show game over scene
        SKScene *endGame = [[GameOverScene alloc] initWithSize:self.size gameOver:NO];
        
        //transition of restart
        SKTransition *reStart = [SKTransition doorsOpenVerticalWithDuration:5.0];
        [self.view presentScene:endGame transition:reStart];
        
    }
    
}

-(void)birdHits{
    
    //when bird gets hit with ball remove heart
    if( hitCount == 1){
        
        score = score - 5;
        [heart removeFromParent];
      
    }else if (hitCount == 2){
        
        score = score - 10;
        //remove second heart
        [heart1 removeFromParent];
    
    }else if (hitCount == 3){
        
        score = score - 20;
        //remove third heart
        [heart2 removeFromParent];
        [self ballHit];
    }
}

-(void)ballHit{
    
    //bird has not been hit by the ball
    isHit = NO;
    
    //if bird is hit 3 times with ball game starts over
    if (hitCount == 3){
        
        //show gameoverscene
        SKScene *endGame = [[GameOverScene alloc] initWithSize:self.size gameOver:YES];
        
        
        //transition of restart
        SKTransition *reStart = [SKTransition doorsOpenVerticalWithDuration:5.0];
        [self.view presentScene:endGame transition:reStart];
        
        [self reportScoreToGameCenter];
        
    }
}

//reports score to game center
-(void)reportScoreToGameCenter{

    [[GameKitHelper sharedGameKitHelper] reportScore:scoreTotal forLeaderboardID:leaderboardIDs[[NSString stringWithFormat:@"%d", scoreTotal]]];
}


@end
