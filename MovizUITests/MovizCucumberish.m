//
//  MovizCucumberish.m
//  MovizUITests
//
//  Created by Li Hao Lai on 13/2/21.
//

#import "MovizUITests-Swift.h"

__attribute__((constructor))
void CucumberishInit()
{
    [CucumberishInitializer CucumberishSwiftInit];
}
