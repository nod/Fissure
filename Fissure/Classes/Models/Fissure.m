//
//  Fissure.m
//  Fissure
//
//  Created by Jason Fieldman on 4/22/14.
//  Copyright (c) 2014 fieldman.org. All rights reserved.
//

#import "Fissure.h"
#import "FissureScene.h"

#define CHECK_VALUE(_v) if (!dictionary[_v]) { EXLog(MODEL, WARN, @"Fissure dictionary missing parameter %@", _v ); }


@implementation Fissure

- (id) initWithDictionary:(NSDictionary*)dictionary forSceneSize:(CGSize)sceneSize {
	if ((self = [super init])) {
		
		self.position        = CGPointMake( [dictionary[@"px"] floatValue] * sceneSize.width, [dictionary[@"py"] floatValue] * sceneSize.height );
		float radius         = [dictionary[@"radius"] floatValue] * sceneSize.width;
		
		NSDictionary *colorDic = dictionary[@"color"];
		_color               = [UIColor colorWithRed:[colorDic[@"r"] floatValue] green:[colorDic[@"g"] floatValue] blue:[colorDic[@"b"] floatValue] alpha:[colorDic[@"a"] floatValue]];
		
		CHECK_VALUE(@"px");
		CHECK_VALUE(@"py");
		CHECK_VALUE(@"radius");
		
		self.zPosition = 1;
		
		self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
		self.physicsBody.dynamic = YES;
		self.physicsBody.categoryBitMask = PHYS_CAT_FISSURE;
		self.physicsBody.collisionBitMask = 0;
		self.physicsBody.contactTestBitMask = 0;
		
		/* Create the particle effect */
		SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"fissure" ofType:@"sks"]];
		emitter.particleColorSequence = [self sequenceForColor:_color];
		[self addChild:emitter];
		
	}
	return self;
}

- (SKKeyframeSequence*) sequenceForColor:(UIColor*)color {
	return [[SKKeyframeSequence alloc] initWithKeyframeValues:@[color, [UIColor colorWithWhite:0.4 alpha:0]] times:@[@(0), @(1)]];
}

@end