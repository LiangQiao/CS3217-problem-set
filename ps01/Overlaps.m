//
//  Overlaps.m
//  
//  CS3217 || Assignment 1
//  Name: <Qiao Liang>
//

#import <Foundation/Foundation.h>
// Import PERectangle here
#import "PERectangle.h"

// define structure Rectangle
// <definition for struct Rectangle here>
 struct Rectangle{
    int originX;
    int originY;
    int width;
    int height;
} ;

int overlaps(struct Rectangle rect1, struct Rectangle rect2) {
    // EFFECTS: returns 1 if rectangles overlap and 0 otherwise
    
    //Algorithm for overlaps:
    //if the two rectangle are NOT overlaping, they must meet ONE OR BOTH of the
    //following CONDITIONs:
    //A: they are horizontally separated.
    //B: they are vertically separated.
    
    //otherwise they overlap
    
    //NOT overlaping
    if((rect1.originX+rect1.width<rect2.originX||rect2.originX+rect2.width<rect1.originX)||(rect1.originY-rect1.height>rect2.originY||rect2.originY-rect2.height>rect1.originY)) return 0;
    else return 1;
  

}


int main (int argc, const char * argv[]) {
	
	/* Problem 1 code (C only!) */
	// declare rectangle 1 and rectangle 2
    struct Rectangle rect1;
    struct Rectangle rect2;

	// input origin for rectangle 1
    printf("Input <x y> coordinates for the origin of the first rectangle:");
    scanf("%i %i",&rect1.originX,&rect1.originY);
	
	// input size (width and height) for rectangle 1
    printf("Input width and height of the first rectangle:");
	scanf("%i %i",&rect1.width,&rect1.height);
	// input origin for rectangle 2
	printf("Input <x y> coordinates for the origin of the second rectangle:");
    scanf("%i %i",&rect2.originX,&rect2.originY);
	// input size (width and height) for rectangle 2
    printf("Input width and height of the second rectangle:");
	scanf("%i %i",&rect2.width,&rect2.height);
	// check if overlapping and write message
   
    if(overlaps(rect1,rect2)==1)
        printf("The two rectangles are overlapping! \n");
    else
        printf("The two rectangles are not overlapping! \n");
     
	/* Problem 2 code (Objective-C) */
	// declare rectangle 1 and rectangle 2 objects
    NSRect tempRect1 = NSMakeRect(rect1.originX,rect1.originY,rect1.width,rect1.height);
    PERectangle* rectangleObj1 = [[PERectangle alloc] initWithRect:tempRect1];
    NSRect tempRect2 = NSMakeRect(rect2.originX,rect2.originY,rect2.width,rect2.height);
    PERectangle* rectangleObj2 = [[PERectangle alloc] initWithRect:tempRect2];
	// input rotation for rectangle 1
    int rotation1;
    int rotation2;
    printf("Input rotation angle for the first rectangle: ");
    scanf("%i",&rotation1);
	// input rotation for rectangle 2
    printf("Input rotation angle for the second rectangle: ");

    scanf("%i",&rotation2);
	// rotate rectangle objects
    
	[rectangleObj1 rotate:(CGFloat)rotation1 ];
   
    [rectangleObj2 rotate: (CGFloat)rotation2];
	// check if rectangle objects overlap and write message
    if([rectangleObj1 overlapsWithRect:rectangleObj2])
        printf("The two rectangles are overlapping! \n");
    else
        printf("The two rectangles are not overlapping! \n");
	// clean up
    [rectangleObj1 release];
    [rectangleObj2 release];  
	// exit program
    
    if(test()==1)
        printf("pass!");
	return 0;
}

// This is where you should put your test cases to test that your implementation is correct. 
int test() {
  // EFFECTS: returns 1 if all test cases are successfully passed and 0 otherwise
    NSRect tempRect1;
    NSRect tempRect2;
    PERectangle* rectangleObj1;
    PERectangle* rectangleObj2;
    int case1 = 0;
    int case2 = 0;
    int case3 = 0;
    int case4 = 0;
    int case5 = 0;
    int case6 = 0;
    
    BOOL before = NO;
    BOOL after = NO;
    //case 1: no collision -> no collision after rotaion
    tempRect1 = NSMakeRect(0,0,100,100);
    tempRect2 = NSMakeRect(101,0,100,100);
    rectangleObj1 = [[PERectangle alloc] initWithRect:tempRect1];
    rectangleObj2 = [[PERectangle alloc] initWithRect:tempRect2];
    before = [rectangleObj1 overlapsWithRect:rectangleObj2];
    
    [rectangleObj1 rotate:0];
    [rectangleObj2 rotate:90];
    
    after = [rectangleObj1 overlapsWithRect:rectangleObj2];
    if(before == NO&&after==NO)
        case1 = 1;
    else
        NSLog(@"case 1 failed.");
    
    [rectangleObj1 release];
    [rectangleObj2 release]; 
    //case 2: no collision -> collision after rotaion
    tempRect1 = NSMakeRect(0,0,100,100);
    tempRect2 = NSMakeRect(101,0,100,100);
    rectangleObj1 = [[PERectangle alloc] initWithRect:tempRect1];
    rectangleObj2 = [[PERectangle alloc] initWithRect:tempRect2];
    before = [rectangleObj2 overlapsWithRect:rectangleObj1];
    
    [rectangleObj1 rotate:0];
    [rectangleObj2 rotate:-45];
    
    after = [rectangleObj2 overlapsWithRect:rectangleObj1];
    if(before == NO&&after==YES)
        case2 = 1;
    else
        NSLog(@"case 2 failed.");
    [rectangleObj1 release];
    [rectangleObj2 release];
    //case 3: collision -> still collision after rotation
    tempRect1 = NSMakeRect(0,0,100,100);
    tempRect2 = NSMakeRect(-1,-1,100,100);
    rectangleObj1 = [[PERectangle alloc] initWithRect:tempRect1];
    rectangleObj2 = [[PERectangle alloc] initWithRect:tempRect2];
    before = [rectangleObj1 overlapsWithRect:rectangleObj2];
    
    [rectangleObj1 rotate:0];
    [rectangleObj2 rotate:90];
    
    after = [rectangleObj1 overlapsWithRect:rectangleObj2];
    if(before == YES&&after==YES)
        case3 = 1;
    else
        NSLog(@"case 3 failed.");
    [rectangleObj1 release];
    [rectangleObj2 release];
    //case 4: collision -> no collision after rotation
    tempRect1 = NSMakeRect(0,0,100,100);
    tempRect2 = NSMakeRect(99,-99,100,100);
    rectangleObj1 = [[PERectangle alloc] initWithRect:tempRect1];
    rectangleObj2 = [[PERectangle alloc] initWithRect:tempRect2];
    before = [rectangleObj1 overlapsWithRect:rectangleObj2];
    
    [rectangleObj1 rotate:45];
    [rectangleObj2 rotate:45];
    
    after = [rectangleObj1 overlapsWithRect:rectangleObj2];
    if(before == YES&&after==NO)
        case4 = 1;
    else
        NSLog(@"case 4 failed.");
    [rectangleObj1 release];
    [rectangleObj2 release];
    //case 5: collision after rotation sharing one edge
    tempRect1 = NSMakeRect(0,0,100,100);
    tempRect2 = NSMakeRect(100,0,100,100);
    rectangleObj1 = [[PERectangle alloc] initWithRect:tempRect1];
    rectangleObj2 = [[PERectangle alloc] initWithRect:tempRect2];
    [rectangleObj1 rotate:360];
    [rectangleObj2 rotate:360];
    
    after = [rectangleObj1 overlapsWithRect:rectangleObj2];
    if(YES)
        case5 = 1;
    else
        NSLog(@"case 5 failed.");
    [rectangleObj1 release];
    [rectangleObj2 release];
    //case 6: collision after rotation after rotation without corners in the other
    tempRect1 = NSMakeRect(0,0,100,100);
    tempRect2 = NSMakeRect(0,0,100,100);
    rectangleObj1 = [[PERectangle alloc] initWithRect:tempRect1];
    rectangleObj2 = [[PERectangle alloc] initWithRect:tempRect2];
    before = [rectangleObj1 overlapsWithRect:rectangleObj2];
    
    [rectangleObj1 rotate:0];
    [rectangleObj2 rotate:90];
    
    after = [rectangleObj1 overlapsWithRect:rectangleObj2];
    if(before == YES&&after==YES)
        case6 = 1;
    else
        NSLog(@"case 6 failed.");
    [rectangleObj1 release];
    [rectangleObj2 release];
    
    
    
    return case1*case2*case3*case4*case5*case6;
}

/* 

Question 2(h)
========

<Your answer here>
 
Another representation can be proposed is to use the four corners or three corners while the last one can be calculated.
The advantage of this representation is that it is a lot easier when we need to deal with the outline of the rectangle more often like collision detection. Another advantage is that the new representation is actually more generic with or without rotation. 
The disadvantage may be the fact that this representation takes at least 50% more space than the origin and size representation and does not really highlight the position and size of the rectangle which have to be calculated when required.


Question 2(i): Reflection (Bonus Question)
==========================
(a) How many hours did you spend on each problem of this problem set?
 
<Your answer here>
the First C problem takes about 1.5 hours while the second takes more than 10 hours to finish and at least another 5 hours to debug.
(b) In retrospect, what could you have done better to reduce the time you spent solving this problem set?

<Your answer here>
 Read the requirement more carefully before I started coding. Write cleaner code.

(c) What could the CS3217 teaching staff have done better to improve your learning experience in this problem set?


<Your answer here>
 more Graphic representation of the definition of the rectangle will be very helpful.
*/
