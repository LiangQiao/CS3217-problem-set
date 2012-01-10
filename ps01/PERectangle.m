//
//  PERectangle.m
//  
//  CS3217 || Assignment 1
//  Name: <Qiao Liang>
//

#import "PERectangle.h"
#import <math.h>
@implementation PERectangle
// OVERVIEW: This class implements a rectangle and the associated
//             operations.
@synthesize origin = _origin;
@synthesize center ; // !! Property without a variable
@synthesize rotation = _rotation;
@synthesize width = _width;
@synthesize height = _height;
@synthesize corners;

- (CGPoint)center {
  // EFFECTS: returns the coordinates of the centre of mass for this
  // rectangle.∂
    CGPoint centerOfMass;
    
    centerOfMass.x = self.origin.x + self.width/2;
    centerOfMass.y = self.origin.y - self.height/2;
    
    return centerOfMass;

}

//!! help method here
- (CGPoint)rotatePoint:(CGPoint)oldPoint arount:(CGPoint)centerPoint degree:(CGFloat) rotationValue{
    //EFFECTS: rotating the oldPoint around the centerPoint for given degree
    //return the coordinate after rotation
    
    CGPoint relative,newPoint;
    relative.x = oldPoint.x - centerPoint.x;
    relative.y = oldPoint.y - centerPoint.y;
    double radian = rotationValue * 3.14159/180;
    newPoint.x = (relative.x*cos(radian) - relative.y*sin(radian))+ centerPoint.x;
    newPoint.y = (relative.x*sin(radian) + relative.y*cos(radian))+ centerPoint.y;
    
    return newPoint;
}

- (CGPoint)cornerFrom:(CornerType)corner {
  // REQUIRES: corner is a enum constant defined in PEShape.h as follows:
  //           kTopLeftCorner, kTopRightCorner, kBottomLeftCorner,
  //		   kBottomRightCorner 
  // EFFECTS: returns the coordinates of the specified rotated rectangle corner after rotating
    NSPoint p1,p2,p3;
    p1=(NSMakePoint(self.origin.x+self.width, self.origin.y));
    p2=(NSMakePoint(self.origin.x,self.origin.y-self.height));
    p3=(NSMakePoint(self.origin.x+self.width, self.origin.y-self.height));
    
    if(corner == kTopLeftCorner)
        return [self rotatePoint:self.origin arount:self.center degree:self.rotation];
    else if(corner == kTopRightCorner)
        return [self rotatePoint: *(CGPoint*)&p1 arount:self.center degree:self.rotation];
    else if(corner == kBottomLeftCorner)
        return [self rotatePoint: *(CGPoint*)&p2 arount:self.center degree:self.rotation];
    else
        return [self rotatePoint: *(CGPoint*)&p3 arount:self.center degree:self.rotation];

}

- (CGPoint*)corners {
  // EFFECTS:  return an array with all the rectangle corners

  CGPoint *corner = (CGPoint*) malloc(4*sizeof(CGPoint));
  corner[0] = [self cornerFrom: kTopLeftCorner];
  corner[1] = [self cornerFrom: kTopRightCorner];
  corner[2] = [self cornerFrom: kBottomRightCorner];
  corner[3] = [self cornerFrom: kBottomLeftCorner];
  return corner;
}

- (id)initWithOrigin:(CGPoint)o width:(CGFloat)w height:(CGFloat)h rotation:(CGFloat)r{
  // MODIFIES: self
  // EFFECTS: initializes the state of this rectangle with origin, width,
  //          height, and rotation angle in degrees
    
    self = [super init];
    if(self){
        _origin = o;
     
        _width = w;
        _height = h;
        _rotation = r;
        
    }
    
    return self;

}

- (id)initWithRect:(CGRect)rect {
  // MODIFIES: self
  // EFFECTS: initializes the state of this rectangle using a CGRect
    return [self initWithOrigin:rect.origin width:rect.width height:rect.height rotation:0];
        
    

}

- (void)rotate:(CGFloat)angle {
  // MODIFIES: self
  // EFFECTS: rotates this shape anti-clockwise by the specified angle
  // around the center of mass
    
    //assume this function is here just to modify the ratation attribute
    //CANNOT really perform computation for the here?
    //as it seems making no sense to modify origin only...
    
    //!!dot notation maybe ERROR prone
    self.rotation = self.rotation + angle;
}

- (void)translateX:(CGFloat)dx Y:(CGFloat)dy {
  // MODIFIES: self
  // EFFECTS: translates this shape by the specified dx (along the
  //            X-axis) and dy coordinates (along the Y-axis)
    CGPoint newOrigin;
    newOrigin.x = self.origin.x + dx;
    newOrigin.y = self.origin.y + dy;
    self.origin = newOrigin;

}

- (BOOL)overlapsWithShape:(id<PEShape>)shape {
  // EFFECTS: returns YES if this shape overlaps with specified shape.
  
  if ([shape class] == [PERectangle class]) {
    return [self overlapsWithRect:(PERectangle *)shape];
  }

  return NO;
}
//!! help method here
- (BOOL)pointInRectangle:(NSRect) rect point: (CGPoint)p{
  // EFFECTS: Return YES if the point is inside rect  
    
    if(p.x>=rect.origin.x&&p.x<=rect.origin.x+rect.size.width&&p.y<=rect.origin.y&&p.y>=rect.origin.y-rect.size.height)
        return YES;
    else return NO;
}
- (BOOL)overlapsWithRect:(PERectangle*)rect {
  // EFFECTS: returns YES if this shape overlaps with specified shape.
  // <add missing code here
    
    //implementating the algorithem similiar the that mentioned in Hints
    // set the center of mass of the second rectangle as the axis origin;
    // un-rotate the corner of the first rectangle with the rotation angle of the second rectangle; translate the corner coordinates to the second rectangle coordinates;
    //  check if the corner of the first rectangle is inside the second rectangle.
   
    //unrotated rect2    
    NSRect rectangle = NSMakeRect(rect.origin.x,rect.origin.y,rect.width,rect.height);
   
    //un-rotating the corners of self around the center of rect2
    CGPoint *temptCorners = self.corners;
    temptCorners[0] = [self rotatePoint:  temptCorners[0] arount:rect.center degree:-rect.rotation];

    temptCorners[1] = [self rotatePoint:  temptCorners[1] arount:rect.center degree:-rect.rotation];
    temptCorners[2] = [self rotatePoint:  temptCorners[2] arount:rect.center degree:-rect.rotation];
    temptCorners[3] = [self rotatePoint:  temptCorners[3] arount:rect.center degree:-rect.rotation];
  //  NSLog(@"%@ %@ %@ %@",NSStringFromPoint(*(NSPoint*)&temptCorners[0]),NSStringFromPoint(*(NSPoint*)&temptCorners[1]),NSStringFromPoint(*(NSPoint*)&temptCorners[2]),NSStringFromPoint(*(NSPoint*)&temptCorners[3]));
  //  if ([self pointInRectangle: rectangle point:temptCorners[2]]==YES)
  //      NSLog(@"Innnnnnn!");
  //  else NSLog(@"Outtt!");
  //  NSLog(@"%@",NSStringFromRect(rectangle));
    
    //checking if the corners are in rect2
    BOOL result = [self pointInRectangle: rectangle point:temptCorners[0]]||[self pointInRectangle: rectangle point:temptCorners[1]]||[self pointInRectangle: rectangle point:temptCorners[2]]||[self pointInRectangle: rectangle point:temptCorners[3]];
    
    if(result) return YES;
    return NO;

}

- (CGRect)boundingBox {	
  // EFFECTS: returns the bounding box of this shape.

  // optional implementation (not graded)
  return CGRectMake(INFINITY, INFINITY, INFINITY, INFINITY);
}

@end

