class Particle{
  float x;
  float y;
  float t;
  float l;
  float w;
  float h;
  float rot;
  float amplitude = 50;
  int mode;
  color c;
  
  Particle(float x, float y, color c, int mode){
    this.x = x;
    this.y = y;
    this.t = 0;
    this.mode = mode;
    this.c = c;
    if(mode == 0){
      this.l = random(20, 50);
      this.w = random(10, 20);
      this.h = random(10, 20);
      this.rot = random(TWO_PI);
    }
    else if(mode == 1){
      this.l = 10;
      this.w = p.w + amplitude;
      this.h = p.h + amplitude;
      this.rot = 0;
    }
    else if(mode == 2){
      this.l = 30;
      this.w = p.w + amplitude;
      this.h = p.h + amplitude;
      this.rot = 0;
    }
  }
  
  void update(){
    if(t >= l) return;
    t++;
    fill(red(c), green(c), blue(c), lerp(alpha(c), 0, t / l));
    if(mode == 0){
        pushMatrix();
        translate(x, y);
        rotate(rot);
        rect(0, 0, w, h);
        popMatrix();
    }
    else if(mode == 1){
        ellipse(x, y, lerp(w, w + amplitude, t / l), lerp(h, h + amplitude, t / l));
    }
    else if(mode == 2){
        rect(x, y, lerp(w, w + amplitude * 1.5, t / l), lerp(h, h + amplitude * 1.5, t / l));
    }
  }

  boolean isDone(){
    return t >= l;
  }
}
