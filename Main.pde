Player p;
ArrayList<Obstacle> obstacles = new  ArrayList();

float t = 0;

void setup(){
  size(800, 600);
  p = new Player();
}

void draw(){
  background(255);
  t++;
  for(int i = obstacles.size() - 1; i >= 0; i--){
    obstacles.get(i).update();
    if(obstacles.get(i).done()) obstacles.remove(i);
  }
  
  p.update();
  for(Obstacle ob : obstacles){
    if(p.isColliding(ob)) ob.h = 400;
    else ob.h = 300;
  }
  
  if(t % 60 == 1){
    obstacles.add(new Obstacle(random(0, 300), random(0, 300), random(0, 300), random(0, 300)));
  }
}

void keyPressed(){
  if(keyCode == UP){
    p.dy = -p.speed;
  }
  else if(keyCode == DOWN){
    p.dy = p.speed;
  }
  else if(keyCode == LEFT){
    p.dx = -p.speed;
  }
  else if(keyCode == RIGHT){
    p.dx = p.speed;
  }
}

void keyReleased(){
  if(keyCode == UP){
    p.dy = 0;
  }
  else if(keyCode == DOWN){
    p.dy = 0;
  }
  else if(keyCode == LEFT){
    p.dx = 0;
  }
  else if(keyCode == RIGHT){
    p.dx = 0;
  }
}
