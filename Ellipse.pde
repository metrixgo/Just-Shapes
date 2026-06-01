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
      curW = lerp(w + amplitude * 2, w, t / fadeInDur);
      curH = lerp(h + amplitude * 2, h, t / fadeInDur);
      noFill();
      stroke(red(c), green(c), blue(c), t / fadeInDur * fadeInStr);
      ellipse(x, y, curW - 10, curH - 10);
      noStroke();
    }
    else if(t <= fadeInDur + lethalDur){;
      fill(lerpColor(color(255), c, (t - fadeInDur) / lethalDur));
      ellipse(x, y, w, h);
    }
    else if(t <= fadeInDur + lethalDur + fadeOutDur){
      curW = lerp(w, w - amplitude, (t - fadeInDur - lethalDur) / fadeOutDur);
      curH = lerp(h, h - amplitude, (t - fadeInDur - lethalDur) / fadeOutDur);
      fill(red(c), green(c), blue(c), lerp(alpha(c), 0, (t - fadeInDur - lethalDur) / fadeOutDur));
      ellipse(x, y, curW, curH);
    }
    else{
      fill(0, 0, 0, 0);
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
