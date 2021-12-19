class Particle
{
  private float fov, heading;
  private PVector position;
  ArrayList<Ray> rays;
  
  Particle() {
    //this.fov = 45; // original code
    fov = 60; // fisheye fix
    position = new PVector(width/6, height/2);
    rays = new ArrayList();
    heading = 0;
    
    for (float a = -fov / 2; a < fov / 2; a++) 
    {
      rays.add(new Ray(position, radians(a)));
    }
  }
  
  public float getFOV()
  {
   return this.fov; 
  }
  
  public void setFOV(float fov)
  {
    this.fov = fov;
    rays = new ArrayList<Ray>();
    for(float a = -fov / 2; a < fov/2 ; a++)
    {
     rays.add(new Ray(position, radians(a) + heading));
    }
  } //updates the size of the cone of view
  
  public void update(float x, float y)
  {
   this.position.set(x, y); 
  }
  
  public void rotate(float angle)
  {
   heading += angle;
   int i = 0;
   for(float a = -fov/ 2; a < fov / 2; a++) 
   {
      rays.get(i).setAngle(radians(a) + heading);
      i++;
   }
  } //without this, the view cone would simply point in one direction, and not move when you rotate
  
  public void move(float amt)
  {
   PVector vel = PVector.fromAngle(heading);
   vel.setMag(amt);
   position.add(vel);
  }
  
  //method checks if the particle intersects with the walls
  public ArrayList<Float> check(ArrayList<Boundary> walls) 
  {
    ArrayList<Float> scene = new ArrayList();
    
    for(Ray ray : this.rays)
    {
      PVector closest = null;
      float viewDist = Float.MAX_VALUE;
      
      for (Boundary wall : walls) 
      {
        PVector pt = ray.cast(wall);
        if (pt != null) 
        {
          float distance = PVector.dist(this.position, pt);
          float angle = ray.direction.heading() - heading;
          //heading is used to generate angles for 2d vectors
          
          if(!mousePressed)
          {
           distance *= cos(angle); 
          }
          if (distance < viewDist) 
          {
            viewDist = distance;
            closest = pt;
          }
        }
      }
      if (closest != null) 
      {
        stroke(255, 5, 120);
        line(this.position.x, this.position.y, closest.x, closest.y);
      }
      scene.add(viewDist);
    }
    return scene;
  }
  
  public void render()
  {
    for (Ray ray : this.rays) 
    {
      ray.render();
    }
  }
  
}
