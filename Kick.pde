class Kick extends Obstacle{
  float loc;
  float loc2;
  int dir;
  float w;
  float t;
  float selfFadeDur;
  float kickDur;
  color c;
  
  Kick(float loc, int dir, float w, color c){
    this.loc = loc;
    this.loc2 = 0;
    this.dir = dir;
    this.t = 0;
    this.w = w;
    this.c = c;
    this.kickDur = 3;
    this.selfFadeDur = fadeInDur - kickDur;
  }
  
  void update(){
    t++;

    if(t <= selfFadeDur){
      fill(c);
      if(dir == 0){
        loc2 = lerp(-width / 2, -width / 2 + amplitude * 3, t / selfFadeDur);
      }
      else if(dir == 1){
        loc2 = lerp(-height / 2, -height / 2 + amplitude * 3, t / selfFadeDur);
      }
      else if(dir == 2){
        loc2 = lerp(1.5 * width, 1.5 * width - amplitude * 3, t / selfFadeDur);
      }
      else{
        loc2 = lerp(1.5 * height, 1.5 * height - amplitude * 3, t / selfFadeDur);
      }
    }
    else if(t <= selfFadeDur + lethalDur){
      fill(lerpColor(color(255), c, (t - selfFadeDur) / lethalDur));
      if(dir == 0){
        loc2 = lerp(-width / 2 + amplitude * 3, width / 2, constrain((t - selfFadeDur) / kickDur, 0, 1));
      }
      else if(dir == 1){
        loc2 = lerp(-height / 2 + amplitude * 3, height / 2, constrain((t - selfFadeDur) / kickDur, 0, 1));
      }
      else if(dir == 2){
        loc2 = lerp(1.5 * width - amplitude * 3, width / 2, constrain((t - selfFadeDur) / kickDur, 0, 1));
      }
      else{
        loc2 = lerp(1.5 * height - amplitude * 3, height / 2, constrain((t - selfFadeDur) / kickDur, 0, 1));
      }
    }
    else if(t <= selfFadeDur + lethalDur + fadeOutDur){
      fill(c);
      if(dir == 0){
        loc2 = lerp(width / 2, -width / 2, (t - selfFadeDur - lethalDur) / fadeOutDur);
      }
      else if(dir == 1){
        loc2 = lerp(height / 2, -height / 2, (t - selfFadeDur - lethalDur) / fadeOutDur);
      }
      else if(dir == 2){
        loc2 = lerp(width / 2, 1.5 * width, (t - selfFadeDur - lethalDur) / fadeOutDur);
      }
      else{
        loc2 = lerp(height / 2, 1.5 * height, (t - selfFadeDur - lethalDur) / fadeOutDur);
      }
    }
    if(dir % 2 == 0){
      rect(loc2, loc, width, w);
    }
    else{
      rect(loc, loc2, w, height);
    }

    if(t <= selfFadeDur + kickDur){
      fill(red(c), green(c), blue(c), constrain(t / selfFadeDur * fadeInStr, 0, fadeInStr));
      if(dir % 2 == 0){
        rect(width / 2, loc, width, w - amplitude);
        }
        else{
        rect(loc, height / 2, w - amplitude, height);
        }
    }

    if(t >= selfFadeDur + kickDur && t < selfFadeDur + kickDur * 2){
      if(dir == 0){
        tranX += amplitude / kickDur;
      }
      else if(dir == 1){
        tranY += amplitude / kickDur;
      }
      else if(dir == 2){
        tranX -= amplitude / kickDur;
      }
      else{
        tranY -= amplitude / kickDur;
      }
    }
    else if(t >= selfFadeDur + kickDur * 2 && t < selfFadeDur + kickDur * 3){
      if(dir == 0){
        tranX -= amplitude / kickDur;
      }
      else if(dir == 1){
        tranY -= amplitude / kickDur;
      }
      else if(dir == 2){
        tranX += amplitude / kickDur;
      }
      else{
        tranY += amplitude / kickDur;
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
