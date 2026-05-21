class Track{
    int id;
    String name;
    color background;
    color obstacle;
    color player;
    AudioPlayer music;
    float bpm;
    float offset;
    boolean started;
    float t;

    Track(int id, String name, color background, color obstacle, color player, float bpm, float offset){
        this.id = id;
        this.name = name;
        this.background = background;
        this.obstacle = obstacle;
        this.player = player;
        this.music = minim.loadFile("data/+" + name + ".mp3");
        this.bpm = bpm;
        this.offset = offset;
        this.started = false;
        this.t = -offset;
    }

    void update(float dt){
        if(!started){
            background(background);
            fill(player);
            textSize(50);
            text(name, width / 2, height / 2 + 150);
            fill(obstacle);
            rect(width / 2 - 200, height / 2 - 200, 400, 300);
        }
        else{
            background(background);
            fill(player);
            rect(p.x, p.y, p.w, p.h);
            t += dt;
            if(t >= 60 / bpm * 1000){
                t -= 60 / bpm * 1000;
                obstacles.add(new Rectangle(random(width - 50), random(height - 50), 50, 50, obstacle));
            }
        }
    }

    void play(){
        started = true;
    }

}