import processing.sound.*;

int curTrack = 0;
int gameState = 0;
ArrayList<Track> tracks = new ArrayList();

float tranX;
float tranY;
Player p;
ArrayList<Obstacle> obstacles = new  ArrayList();
ArrayList<Particle> particles = new  ArrayList();

SoundFile song;

final color NEARLYBLACK = color(19, 35, 36);
final color CYAN = color(0, 230, 253);
final color PINKRED = color(255, 56, 111);
final color DARKGREEN = color(35, 111, 73);
final color LIGHTGREEN = color(215, 249, 159);

void setup(){
  noStroke();
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  ellipseMode(CENTER);
  size(800, 600);
  song = new SoundFile(this, "data/Theme.mp3");
  song.loop();
  tracks.add(new Track(0, "Source", NEARLYBLACK, PINKRED, CYAN, 125, 2400, this));
  tracks.add(new Track(1, "The Emerald Electric", NEARLYBLACK, DARKGREEN, LIGHTGREEN, 91, 2610, this));
}

void draw(){
  tracks.get(curTrack).update();
  for(int i = particles.size() - 1; i >= 0; i--){
    if(particles.isEmpty()) break;
    if(particles.get(i).isDone()) particles.remove(i);
    else particles.get(i).update();
  }
  if(p != null) p.update();
}

void keyPressed(){
  if(gameState == 1){
    if(keyCode == UP || key == 'w'){
      p.up = true;
    }
    else if(keyCode == DOWN || key == 's'){
      p.down = true;
    }
    else if(keyCode == LEFT || key == 'a'){
      p.left = true;
    }
    else if(keyCode == RIGHT || key == 'd'){
      p.right = true;
    }
    else if(key == ' '){
      p.dash = true;
    }
  }
  else if(gameState == 0){
    if(keyCode == DOWN && curTrack < tracks.size() - 1){
      curTrack = min(curTrack + 1, tracks.size() - 1);
    }
    else if(keyCode == UP){
      curTrack = max(curTrack - 1, 0);
    }
    else if(keyCode == ENTER){
      p = new Player(tracks.get(curTrack).player);
      song.stop();
      song = new SoundFile(this, "data/" + tracks.get(curTrack).name + ".mp3");
      song.play();
      tracks.get(curTrack).play();
      gameState = 1;
    }
  }
  else{
    if(keyCode == ENTER){
      gameState = 0;
      song.stop();
      song = new SoundFile(this, "data/Theme.mp3");
      song.play();
      p = null;
    }
  }
}

void keyReleased(){
  if(gameState != 1) return;
  if(keyCode == UP || key == 'w'){
    p.up = false;
  }
  else if(keyCode == DOWN || key == 's'){
    p.down = false;
  }
  else if(keyCode == LEFT || key == 'a'){
    p.left = false;
  }
  else if(keyCode == RIGHT || key == 'd'){
    p.right = false;
  }
}
