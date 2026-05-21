import ddf.minim.*;

int curTrack = 0;
boolean started = false;
ArrayList<Track> tracks = new ArrayList();

Player p;
ArrayList<Obstacle> obstacles = new  ArrayList();

Minim minim;
AudioPlayer song;

float t = 0;

final color NEARLYBLACK = color(19, 35, 36);
final color CYAN = color(0, 230, 253);
final color PINKRED = color(255, 56, 111);
final color DARKGREEN = color(35, 111, 73);
final color LIGHTGREEN = color(215, 249, 159);

void setup(){
  noStroke();
  textAlign(CENTER, CENTER);
  size(800, 600);
  minim = new Minim(this);
  song = minim.loadFile("data/Theme.mp3");
  song.loop();
  tracks.add(new Track(0, "Source", NEARLYBLACK, PINKRED, CYAN, 125, 2460));
  tracks.add(new Track(1, "The Emerald Electric", NEARLYBLACK, DARKGREEN, LIGHTGREEN, 91, 2460));
}

void draw(){
  tracks.get(curTrack).update(millis() - t);
  for(int i = obstacles.size() - 1; i >= 0; i--){
    if(obstacles.get(i).isDone() || obstacles.get(i).isColliding(p)) obstacles.remove(i);
    else obstacles.get(i).update();
  }
  t = millis();
}

void keyPressed(){
  if(started) return;
  if(keyCode == DOWN && curTrack < tracks.size() - 1){
    curTrack = min(curTrack + 1, tracks.size() - 1);
  }
  else if(keyCode == UP){
    curTrack = max(curTrack - 1, 0);
  }
  else if(keyCode == ENTER){
    started = true;
    p = new Player(tracks.get(curTrack).player);
    song.close();
    song = minim.loadFile("data/" + tracks.get(curTrack).name + ".mp3");
    song.play();
    tracks.get(curTrack).play();
  }
}
