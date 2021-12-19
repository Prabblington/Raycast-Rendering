class Boundary
{
  private PVector pointA, pointB;
  
 public Boundary(float x1, float y1, float x2, float y2)
 {
   pointA = new PVector(x1, y1);
   pointB = new PVector(x2, y2);
 }
 
 public void render()
 {
  line(pointA.x, pointA.y, pointB.x, pointB.y);
 }
}
