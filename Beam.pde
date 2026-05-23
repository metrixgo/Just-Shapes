class Beam extends Obstacle{
  float loc;
  float curLoc;
  int dir;
  float w;
  float curW;
  float t;
  color c;
  
  Beam(float loc, int dir, float w, color c){
    this.loc = loc;
    this.curLoc = loc;
    this.dir = dir;
    this.t = 0;
    this.w = w;
    this.curW = w - amplitude;
    this.c = c;
  }

  Beam(float loc, int dir, float w, color c, float l){
    this.loc = loc;
    this.curLoc = loc;
    this.dir = dir;
    this.t = 0;
    this.w = w;
    this.curW = w - amplitude;
    this.c = c;
    lethalDur = l;
  }
  
  void update(){
    t++;
    if(t <= fadeInDur){
      fill(red(c), green(c), blue(c), t / fadeInDur * fadeInStr);
      curW = lerp(w - amplitude, w, t / fadeInDur);
      curLoc = loc;
    }
    else if(t <= fadeInDur + lethalDur){
      fill(lerpColor(color(255), c, (t - fadeInDur) / lethalDur));
      curLoc = loc + sin((t - fadeInDur) * amplitude / 3) * amplitude / 5;
    }
    else if(t <= fadeInDur + lethalDur + fadeOutDur){
      fill(red(c), green(c), blue(c), lerp(alpha(c), 0, (t - fadeInDur - lethalDur) / fadeOutDur));
      curW = lerp(w, w - amplitude, (t - fadeInDur - lethalDur) / fadeOutDur);
      curLoc = loc;
    }
    else{
      fill(0, 0, 0, 0);
    }
    
    if(dir == 0){
      rect(width / 2, curLoc, width, curW);
    }
    else{
      rect(curLoc, height / 2, curW, height);
    }
  }
  
  boolean isLethal(){
    return t < fadeInDur + lethalDur && t > fadeInDur;
  }
  
  boolean isDone(){
    return t >= fadeInDur + lethalDur + fadeOutDur;
  }
  
  boolean isColliding(Player p){
    if(p == null) return false;
    if(dir == 0){
      return (loc - curW / 2 <= p.y + p.h / 2) && (loc + curW / 2 >= p.y - p.h / 2);
    }
    else{
      return (loc - curW / 2 <= p.x + p.w / 2) && (loc + curW / 2 >= p.x - p.w / 2);
    }
  }
}
