class Particle{
  float x;
  float y;
  float t;
  float l;
  float w;
  float h;
  float rot;
  float amplitude = 30;
  boolean isDash;
  color c;
  
  Particle(float x, float y, color c){
    this(x, y, c, false);
  }

  Particle(float x, float y, color c, boolean dash){
    this.x = x;
    this.y = y;
    this.t = 0;
    if(!dash){
        this.l = random(20, 50);
        this.w = random(10, 20);
        this.h = random(10, 20);
        this.rot = random(TWO_PI);
    }
    else{
        this.l = 10;
        this.w = p.w + amplitude;
        this.h = p.h + amplitude;
        this.rot = 0;
    }
    this.isDash = dash;
    this.c = c;
  }
  
  void update(){
    if(t >= l) return;
    t++;
    fill(red(c), green(c), blue(c), lerp(alpha(c), 0, t / l));
    if(!isDash){
        pushMatrix();
        translate(x, y);
        rotate(rot);
        rect(0, 0, w, h);
        popMatrix();
    }
    else{
        ellipse(x, y, lerp(w, w + amplitude, t / l), lerp(h, h + amplitude, t / l));
    }
  }

  boolean isDone(){
    return t >= l;
  }
}
