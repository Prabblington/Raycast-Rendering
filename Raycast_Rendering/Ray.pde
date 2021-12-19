class Ray
{
 private PVector position, direction;
  
 public Ray(PVector pos, float angle)
 {
  this.position = pos;
  this.direction = PVector.fromAngle(angle);
  //allows you to create vectors from an angle
 }
 
 public void setDirection(float x, float y)
 {
  this.direction.x = x - this.position.x;
  this.direction.y = y - this.position.y;
  this.direction.normalize();
 }
 
 public void setAngle(float angle) 
 {
    direction = PVector.fromAngle(angle);
 }
  
 public void look(float x, float y)
 {
   direction.x = x - position.x;
   direction.y = y - position.y;
   direction.normalize();
 }
 
 public PVector cast(Boundary wall)
 {
  //where the walls start
  float x1 = wall.pointA.x;
  float y1 = wall.pointA.y;
  float x2 = wall.pointB.x;
  float y2 = wall.pointB.y;
  
  //x3 and y3 are position of the ray
  //x4 and y4 are the direction vectors
  float x3 = this.position.x;
  float y3 = this.position.y;
  float x4 = this.position.x + this.direction.x;
  float y4 = this.position.y + this.direction.y;
  
  //to calculate, use matrix for intersection points of lines
  //math is (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4) - denominator
  //(x1-x3)*(y3-y4)-(y1-y3)*(x3-x4) - T (a numerator)
  //-(x1-x2)*(y1-y3)-(y1-y2)*(x1-x3) - U (b numerator)
  float denom = (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4);
  if(denom == 0)
  {
    return null;
  } //if the denominator == 0, this means the ray and wall vectors will never intersect, so return from the method
  
  float t = ((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4)) / denom;
  float u = -((x1-x2)*(y1-y3)-(y1-y2)*(x1-x3)) / denom;
  
  if(t > 0 && t < 1 && u > 0)
  {
    PVector pt = new PVector();
    pt.x = x1 + t * (x2 - x1);
    pt.y = y1 + t * (y2 - y1);
    
    return pt; 
  }
  else return null;
 }
 
 //pushes the vector into specified position and draws a unit vector for where the ray resides
 public void render()
 {
   push();
   translate(this.position.x, this.position.y);
   line(0, 0, direction.x, direction.y);
   pop();
 }
}
