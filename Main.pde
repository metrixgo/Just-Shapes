import ddf.minim.*;

Player p;
ArrayList<Obstacle> obstacles = new  ArrayList();

Minim minim;
AudioPlayer song;

final color NEARLYBLACK = color(19, 35, 36);
final color CYAN = color(0, 230, 253);
final color PINKRED = color(255, 56, 111);

float t = 2460;
float interval = 60.0 / 91 * 1000;

void setup(){
  noStroke();
  size(800, 600);
  p = new Player(CYAN);
  minim = new Minim(this);
  song = minim.loadFile("data/TheEmeraldElectric.mp3");
  song.play();
}

void draw(){
  background(NEARLYBLACK);
  for(int i = obstacles.size() - 1; i >= 0; i--){
    if(obstacles.get(i).isDone() || obstacles.get(i).isColliding(p)) obstacles.remove(i);
    else obstacles.get(i).update();
  }
  p.update();
  
  if(millis() >= t + interval){
    t += interval;
    obstacles.add(new Rectangle(random(0, 300), random(0, 300), random(0, 300), random(0, 300), PINKRED));
    obstacles.add(new Beam(random(0, 300), (int)random(1,3), random(0, 300), PINKRED));
    obstacles.add(new Ellipse(random(0, 300), random(0, 300), random(0, 300), random(0, 300), PINKRED));
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
