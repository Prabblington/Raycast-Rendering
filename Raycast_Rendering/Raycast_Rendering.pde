//raycasting in processing java, with minimap of rendered objects
import java.util.ArrayList;

ArrayList<Boundary> walls;
Particle particle;
private float minmapW, minmapH;
private int wallMax = 0;

public void setup()
{
  size(1200,800);
  background(0);
  stroke(255);
  
  minmapW = width/2;
  minmapH = height;
  walls = new ArrayList();  
  wallMax = 8;
  
  for (int i = 0; i <= wallMax; i++) 
  {
    float x1 = random(minmapW);
    float x2 = random(minmapW);
    float y1 = random(minmapH);
    float y2 = random(minmapH);
    walls.add(new Boundary(x1, y1, x2, y2));    
  }
  
  walls.add(new Boundary(0, 0, minmapW, 0));
  walls.add(new Boundary(minmapW, 0, minmapW, minmapH));
  walls.add(new Boundary(minmapW, minmapH, 0, minmapH));
  walls.add(new Boundary(0, minmapH, 0, 0));  
  particle = new Particle();
}

public void checkMapCollide()
{
  //collision with render page
  if(particle.getPositionX() <= 0)
  {
   particle.setPositionX(0); 
  }
  else if(particle.getPositionY() <= 0)
  {
   particle.setPositionY(0); 
  }
  else if(particle.getPositionX() >= minmapW)
  {
   particle.setPositionX(minmapW); 
  }
  else if(particle.getPositionY() >= minmapH)
  {
   particle.setPositionY(minmapH); 
  }
}

public void draw()
{
  background(30);
  stroke(255);
  float FOVVal = 45;
    
  //mouseX tracking lets the mouse determine the size of the field of view (FOV)
  if(mouseX <= 2) 
  {
    FOVVal = 2; 
  }
  else if (mouseX >= minmapW) 
  {
    FOVVal = 360;
  } 
  else {
    FOVVal = map(mouseX, 0, minmapW, 0, 360);
  }
  
  particle.setFOV(FOVVal);
  
  for (Boundary wall : walls) 
  {
    wall.render();
  }
  
  particle.render();
  particle.check(walls);
  
  ArrayList<Float> scene = particle.check(walls);
  float w = minmapW / scene.size();
  
  if (keyPressed && key == CODED) 
  {
    if (keyCode == LEFT) 
    {
      particle.rotate(-0.1);
    } 
    else if (keyCode == RIGHT) 
    {
      particle.rotate(0.1);
    } 
    else if (keyCode == UP) 
    {
      particle.move(2);
    } 
    else if (keyCode == DOWN) 
    {
      particle.move(-2);
    }
    checkMapCollide();    
  }   
  
  push();
  translate(minmapW, 0);   
  
  for (int i = 0; i < scene.size(); i++) 
  {
    noStroke();
    float sq = scene.get(i) * scene.get(i);
    float wSq = minmapW * minmapW;
    float b = map(sq, 0, wSq, 255, 0);
    float h = map(scene.get(i), 0, minmapW, minmapH, 0);
    fill(b);
    rectMode(CENTER);
    rect(i * w + w / 2, minmapH / 2, w + 1, h);
  }
  pop();
}
