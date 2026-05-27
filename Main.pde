import processing.sound.*;

float speed = 0.5;
int curTrack = 0;
float curProgress = 0;
int gameState = 0;
ArrayList<Track> tracks = new ArrayList();
ArrayList<SoundFile> songs = new ArrayList();
SoundFile song;

Player p;
ArrayList<Obstacle> obstacles = new  ArrayList();
ArrayList<Particle> particles = new  ArrayList();

float tranX = 0;
float tranY = 0;

final color NEARLYBLACK = color(19, 35, 36);
final color CYAN = color(0, 230, 253);
final color PINKRED = color(255, 56, 111);
final color DARKGREEN = color(35, 111, 73);
final color LIGHTGREEN = color(215, 249, 159);
final color DARKORANGE = color(180, 72, 0);
final color LIGHTORANGE = color(243, 163, 51);
final color LIGHTBLUE = color(160, 255, 252);
final color DARKBLUE = color(34, 47, 117);

void setup(){
  noStroke();
  noSmooth();
  strokeWeight(10);
  textAlign(CENTER, CENTER);
  textFont(createFont("Consolas", 30));
  rectMode(CENTER);
  ellipseMode(CENTER);
  size(800, 600, P2D);
  song = new SoundFile(this, "data/Theme.mp3");
  song.loop();
  tracks.add(new Track(0, "Source", NEARLYBLACK, PINKRED, CYAN, 125, 2400, this));
  tracks.add(new Track(1, "The Emerald Electric", NEARLYBLACK, DARKGREEN, LIGHTGREEN, 91, 2680, this));
  tracks.add(new Track(2, "Zero Dark Hundred", NEARLYBLACK, DARKORANGE, LIGHTORANGE, 104, 3340, this));
  tracks.add(new Track(3, "Speculation", NEARLYBLACK, DARKBLUE, LIGHTBLUE, 95, 2950, this));
  for(Track t : tracks){
    songs.add(new SoundFile(this, "data/" + t.name + ".mp3"));
  }
}

void draw(){
  pushMatrix();
  translate(tranX, tranY);
  tracks.get(curTrack).update();
  if(gameState == 0){
    tranX = 0;
    tranY = 0;
    curProgress = 0;
    fill(255, 255, 255);
    triangle(width / 2 - 50, 40, width / 2 + 50, 40, width / 2, 20);
    triangle(width / 2 - 50, height - 40, width / 2 + 50, height - 40, width / 2, height - 20);
    if((int)random(40) == 0) particles.add(new Particle(random(height), random(width), color(255), 3));
  }
  for(int i = particles.size() - 1; i >= 0; i--){
    if(particles.isEmpty()) break;
    if(particles.get(i).isDone()) particles.remove(i);
    else particles.get(i).update();
  }
  if(p != null) p.update();
  if(abs(tranX) > 0.01 || abs(tranY) > 0.01){
    fill(255, 255, 255, 40);
    rect(width / 2, height / 2, width * 2, height * 2);
  }
  popMatrix();
  if(gameState == 1){
    curProgress = song.position() / song.duration();
    fill(255, 255, 255);
    rect(width / 2 - (1 - curProgress) * width, 0, width, 10);
  }
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
    if(keyCode == DOWN || key == 's'){
      curTrack = (curTrack + 1) % tracks.size();
    }
    else if(keyCode == UP || key == 'w'){
      if(curTrack == 0) curTrack = tracks.size() - 1;
      else curTrack--;
    }
    else if(keyCode == ENTER){
      p = new Player(tracks.get(curTrack).player);
      song.stop();
      song = songs.get(curTrack);
      song.rate(speed);
      song.play();
      Obstacle.fadeInDur /= speed;
      tracks.get(curTrack).play();
      particles.add(new Particle(tracks.get(curTrack).name));
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
