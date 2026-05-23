class Kick extends Obstacle{
  float loc;
  float loc2;
  int dir;
  float w;
  float t;
  float kickDur;
  color c;
  
  Kick(float loc, int dir, float w, color c){
    this.loc = loc;
    this.loc2 = 0;
    this.dir = dir;
    this.t = 0;
    this.w = w;
    this.c = c;
    this.kickDur = 5;
  }
  
  void update(){
    t++;

    if(t <= fadeInDur){
      fill(c);
      if(dir == 0){
        loc2 = lerp(-width / 2, -width / 2 + amplitude * 3, t / fadeInDur);
      }
      else if(dir == 1){
        loc2 = lerp(-height / 2, -height / 2 + amplitude * 3, t / fadeInDur);
      }
      else if(dir == 2){
        loc2 = lerp(1.5 * width, 1.5 * width - amplitude * 3, t / fadeInDur);
      }
      else{
        loc2 = lerp(1.5 * height, 1.5 * height - amplitude * 3, t / fadeInDur);
      }
    }
    else if(t <= fadeInDur + lethalDur){
      fill(lerpColor(color(255), c, (t - fadeInDur) / lethalDur));
      if(dir == 0){
        loc2 = lerp(-width / 2 + amplitude * 3, width / 2, constrain((t - fadeInDur) / kickDur, 0, 1));
      }
      else if(dir == 1){
        loc2 = lerp(-height / 2 + amplitude * 3, height / 2, constrain((t - fadeInDur) / kickDur, 0, 1));
      }
      else if(dir == 2){
        loc2 = lerp(1.5 * width - amplitude * 3, width / 2, constrain((t - fadeInDur) / kickDur, 0, 1));
      }
      else{
        loc2 = lerp(1.5 * height - amplitude * 3, height / 2, constrain((t - fadeInDur) / kickDur, 0, 1));
      }
    }
    else if(t <= fadeInDur + lethalDur + fadeOutDur){
      fill(c);
      if(dir == 0){
        loc2 = lerp(width / 2, -width / 2, (t - fadeInDur - lethalDur) / fadeOutDur);
      }
      else if(dir == 1){
        loc2 = lerp(height / 2, -height / 2, (t - fadeInDur - lethalDur) / fadeOutDur);
      }
      else if(dir == 2){
        loc2 = lerp(width / 2, 1.5 * width, (t - fadeInDur - lethalDur) / fadeOutDur);
      }
      else{
        loc2 = lerp(height / 2, 1.5 * height, (t - fadeInDur - lethalDur) / fadeOutDur);
      }
    }
    if(dir % 2 == 0){
      rect(loc2, loc, width, w);
    }
    else{
      rect(loc, loc2, w, height);
    }

    if(t <= fadeInDur + kickDur){
      fill(red(c), green(c), blue(c), constrain(t / fadeInDur * fadeInStr, 0, fadeInStr));
      if(dir % 2 == 0){
        rect(width / 2, loc, width, w - amplitude);
        }
        else{
        rect(loc, height / 2, w - amplitude, height);
        }
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
    if(dir % 2 == 0){
      return (loc - w / 2 <= p.y + p.h / 2) && (loc + w / 2 >= p.y - p.h / 2);
    }
    else{
      return (loc - w / 2 <= p.x + p.w / 2) && (loc + w / 2 >= p.x - p.w / 2);
    }
  }
}
