class Text extends Obstacle{
  float x;
  float y;
  float s;
  float w;
  float h;
  float curS;
  float t;
  float lethalDur;
  String text;
  color c;
  
  Text(float x, float y, float s, String text, color c, float l){
    this.x = x;
    this.y = y;
    this.s = s;
    this.curS = s - amplitude;
    this.text = text;
    this.t = 0;
    this.c = c;
    textSize(s);
    this.w = textWidth(text);
    this.h = textAscent() + textDescent();
    this.lethalDur = l;
  }
  
  void update(){
    t++;
    if(t <= fadeInDur){
      fill(red(c), green(c), blue(c), t / fadeInDur * fadeInStr);
      curS = lerp(s - amplitude, s, t / fadeInDur);
    }
    else if(t <= fadeInDur + lethalDur){
      fill(lerpColor(color(255), c, (t - fadeInDur) / lethalDur));
    }
    else if(t <= fadeInDur + lethalDur + fadeOutDur){
      fill(red(c), green(c), blue(c), lerp(alpha(c), 0, (t - fadeInDur - lethalDur) / fadeOutDur));
      curS = lerp(s, s - amplitude, (t - fadeInDur - lethalDur) / fadeOutDur);
    }
    else{
      fill(0, 0, 0, 0);
    }
    textSize(curS);
    rect(x, y, w, h);
    if(t > fadeInDur && t < fadeInDur + lethalDur){
      fill(c);
      text(text, x, y);
    }
  }
  
  boolean isLethal(){
    return t < fadeInDur + lethalDur && t > fadeInDur;
  }
  
  boolean isDone(){
    return t >= fadeInDur + lethalDur + fadeOutDur;
  }
  
  boolean isColliding(Player p){
    return (x - w / 2 <= p.x + p.w / 2) && (x + w / 2 >= p.x - p.w / 2) && (y - h / 2 <= p.y + p.h / 2) && (y + h / 2 >= p.y - p.h / 2);
  }
}
