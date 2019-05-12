//
//  ThreadExample.m
//  TestSet
//
//  Created by Osmar Hernández on 05/10/18.
//  Copyright © 2018 Osmar Hernández. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyObject: NSObject
+(void) aMethod: (id)param;
@end

@implementation MyObject
+(void) aMethod:(id)param {
    int x;
    for (x = 0; x < 50; ++x) {
        printf("Object Thread says x is %i \n", x);
        usleep(1);
    }
}
@end

int main(int argc, char *argv[]) {
    int x;
    [NSThread detachNewThreadSelector:@selector(aMethod:) toTarget:[MyObject class] withObject:nil];
    
    for (x = 0; x < 50; ++x) {
        printf("Main thread says x is %i \n", x);
        usleep(1);
    }
    
    return 0;
}
