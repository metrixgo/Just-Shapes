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
    float prevT;

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
        this.prevT = offset;
    }

    void update(){
        background(background);
        if(gameState == 0){
            fill(player);
            textSize(50);
            text(name, width / 2, height / 2 + 150);
            fill(obstacle);
            rect(width / 2 - 200, height / 2 - 200, 400, 300);
        }
        else if(gameState == 1){
            if(millis() >= 60 / bpm * 1000 + prevT){
                prevT += 60 / bpm * 1000;
                obstacles.add(new Rectangle(random(width - 50), random(height - 50), 50, 50, obstacle));
            }
        }
        else{
            started = false;
            gameState = 2;
            p = null;
            fill(player);
            textSize(50);
            text("Game Over\n Press Enter to Restart", width / 2, height / 2 + 150);
        }
    }

    void play(){
        prevT = millis() + offset;
        started = true;
    }

}