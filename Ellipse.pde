class Ellipse extends Obstacle{
  float x;
  float y;
  float w;
  float curW;
  float h;
  float curH;
  float t;
  color c;
  
  Ellipse(float x, float y, float w, float h, color c){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.curW = w - amplitude;
    this.curH = h - amplitude;
    this.t = 0;
    this.c = c;
  }
  
  void update(){
    t++;
    color temp;
    if(t <= fadeInDur){
      temp = color(red(c), green(c), blue(c), t / fadeInDur * fadeInStr);
      curW = lerp(w - amplitude, w, t / fadeInDur);
      curH = lerp(h - amplitude, h, t / fadeInDur);
    }
    else if(t <= fadeInDur + lethalDur){
      temp = lerpColor(color(255), c, (t - fadeInDur) / lethalDur);
    }
    else if(t <= fadeInDur + lethalDur + fadeOutDur){
      temp = color(red(c), green(c), blue(c), lerp(alpha(c), 0, (t - fadeInDur - lethalDur) / fadeOutDur));
      curW = lerp(w, w - amplitude, (t - fadeInDur - lethalDur) / fadeOutDur);
      curH = lerp(h, h - amplitude, (t - fadeInDur - lethalDur) / fadeOutDur);
    }
    else{
      temp = color(0, 0, 0, 0);
    }

    if(t <= fadeInDur){
      noFill();
      stroke(temp);
      ellipse(x, y, 3 * w - 2 * curW, 3 * h - 2 * curH);
      noStroke();
    }
    else{
      fill(temp);
      ellipse(x, y, curW, curH);
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
    float dx = (constrain(x, p.x - p.w / 2, p.x + p.w / 2) - x) / w * 2;
    float dy = (constrain(y, p.y - p.h / 2, p.y + p.h / 2) - y) / h * 2;
    return (dx * dx + dy * dy) <= 1;
  }
}
