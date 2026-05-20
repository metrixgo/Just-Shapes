Player p;
ArrayList<Obstacle> obstacles = new  ArrayList();

final color NEARLYBLACK = color(19, 35, 36);
final color CYAN = color(0, 230, 253);
final color PINKRED = color(255, 56, 111);

float t = 0;

void setup(){
  noStroke();
  size(800, 600);
  p = new Player(CYAN);
}

void draw(){
  background(NEARLYBLACK);
  t++;
  for(int i = obstacles.size() - 1; i >= 0; i--){
    if(obstacles.get(i).isDone()) obstacles.remove(i);
    else obstacles.get(i).update();
  }
  p.update();
  
  if(t % 60 == 1){
    obstacles.add(new Rectangle(random(0, 300), random(0, 300), random(0, 300), random(0, 300), 100, PINKRED));
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
