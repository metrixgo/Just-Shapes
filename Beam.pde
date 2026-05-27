class Beam extends Obstacle{
  float loc;
  float curLoc;
  int dir;
  float w;
  float curW;
  float t;
  float selfLethalDur;
  color c;
  
  Beam(float loc, int dir, float w, color c){
    this.loc = loc;
    this.curLoc = loc;
    this.dir = dir;
    this.t = 0;
    this.w = w;
    this.curW = w - amplitude;
    this.c = c;
    this.selfLethalDur = lethalDur;
  }

  Beam(float loc, int dir, float w, color c, float l){
    this.loc = loc;
    this.curLoc = loc;
    this.dir = dir;
    this.t = 0;
    this.w = w;
    this.curW = w - amplitude;
    this.c = c;
    this.selfLethalDur = l;
  }
  
  void update(){
    t++;
    if(t <= fadeInDur){
      fill(red(c), green(c), blue(c), t / fadeInDur * fadeInStr);
      curW = lerp(w - amplitude, w, t / fadeInDur);
      curLoc = loc;
    }
    else if(t <= fadeInDur + selfLethalDur){
      fill(lerpColor(color(255), c, (t - fadeInDur) / selfLethalDur));
      curLoc = loc + sin((t - fadeInDur) * amplitude / 3) * amplitude / 5;
    }
    else if(t <= fadeInDur + selfLethalDur + fadeOutDur){
      fill(red(c), green(c), blue(c), lerp(alpha(c), 0, (t - fadeInDur - selfLethalDur) / fadeOutDur));
      curW = lerp(w, w - amplitude, (t - fadeInDur - selfLethalDur) / fadeOutDur);
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
    return t < fadeInDur + selfLethalDur && t > fadeInDur;
  }
  
  boolean isDone(){
    return t >= fadeInDur + selfLethalDur + fadeOutDur;
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
