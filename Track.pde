class Track{
    int id;
    String name;

    color background;
    color obstacle;
    color player;

    PApplet main;
    float bpm;
    float offset;

    boolean started;
    float prevT;
    int line;
    int prevLine;
    int repeat;

    String[] lines;
    String[] curLine;
    ArrayList<Obstacle> obstacles = new  ArrayList();

    Track(int id, String name, color background, color obstacle, color player, float bpm, float offset, PApplet main){
        this.id = id;
        this.name = name;
        this.background = background;
        this.obstacle = obstacle;
        this.player = player;
        this.main = main;
        this.bpm = bpm;
        this.offset = offset;
        this.started = false;
        this.prevT = offset;
        p = new Player(player);
        this.line = 0;
        this.prevLine = 0;
        this.repeat = -1;
        this.lines = loadStrings("data/Track" + id + ".txt");
        this.curLine = split(lines[line], ";");
    }

    void update(){
        background(background);
        if(gameState == 0){
            obstacles.clear();
            line = 0;
            fill(player);
            textSize(50);
            text(name, width / 2, height / 2 + 200);
            fill(obstacle);
            rect(width / 2 , height / 2 - 25, 600, 350);
        }
        else if(gameState == 1){
            if(!song.isPlaying() && line > 5){
                gameState = 3;
                song.stop();
                song = new SoundFile(main, "data/complete.mp3");
                song.play();
            }
            for(int i = obstacles.size() - 1; i >= 0; i--){
                if(obstacles.get(i).isDone()) obstacles.remove(i);
                else if(obstacles.get(i).isLethal() && obstacles.get(i).isColliding(p) && p.hurt()){
                    song.stop();
                    song = new SoundFile(main, "data/death.mp3");
                    song.play();
                    gameState = 2;
                }
                else obstacles.get(i).update();
            }

            if(line >= lines.length) return;
            curLine = split(lines[line], ";");

            while((curLine[0].equals("repeat")) && line < lines.length){
                if(repeat != 0 && !curLine[1].equals("0")){
                    if(repeat == -1) repeat = int(curLine[1]) - 1;
                    else repeat--;
                    line = prevLine;
                }
                else{
                    line++;
                    prevLine = line;
                    repeat = -1;
                }
                if(line < lines.length) curLine = split(lines[line], ";");
            }

            if(millis() >= 60 / bpm / speed * 1000 * float(curLine[0]) + prevT){
                prevT += 60 / bpm / speed * 1000 * float(curLine[0]);
                addCurLineObstacles();
                line++;
            }
        }
        else if(gameState == 2){
            started = false;
            p = null;
            for(int i = obstacles.size() - 1; i >= 0; i--){
                if(obstacles.get(i).isDone()) obstacles.remove(i);
                else obstacles.get(i).update();
            }
            fill(player);
            textSize(50);
            text("Game Over\n Press Enter to Restart", width / 2, height / 2 + 150);
        }
        else if (gameState == 3){
            started = false;
            p = null;
            for(int i = obstacles.size() - 1; i >= 0; i--){
                if(obstacles.get(i).isDone()) obstacles.remove(i);
                else obstacles.get(i).update();
            }
            fill(player);
            textSize(50);
            text("Level Complete!\n Press Enter to Restart", width / 2, height / 2 + 150);
        }
    }

    void addCurLineObstacles(){
        if(curLine[1].equals("beam")){
            int dir = (int)random(2);
            float loc;
            if(dir == 0) loc = random(height);
            else loc = random(random(width));
            if(curLine.length == 4) obstacles.add(new Beam(loc, dir, float(curLine[2]), obstacle, float(curLine[3])));
            else obstacles.add(new Beam(loc, dir, float(curLine[2]), obstacle));
        }
        else if(curLine[1].equals("rectangle")){
            obstacles.add(new Rectangle(random(width), random(height), float(curLine[2]), float(curLine[3]), obstacle));
        }
        else if(curLine[1].equals("ellipse")){
            obstacles.add(new Ellipse(random(width), random(height), float(curLine[2]), float(curLine[3]), obstacle));
        }
        else if(curLine[1].equals("kick")){
            int dir = (int)random(4);
            float loc;
            if(dir % 2 == 0) loc = random(height);
            else loc = random(random(width));
            obstacles.add(new Kick(loc, dir, float(curLine[2]), obstacle));
        }
        else if(curLine[1].equals("text")){
            textSize(float(curLine[2]));
            float w = textWidth(curLine[3]);
            float h = textAscent() + textDescent();
            obstacles.add(new Text(random(w / 2, width - w / 2), random(h / 2, height - h / 2), float(curLine[2]), curLine[3], obstacle, float(curLine[4])));
        }
        else if(curLine[0].equals("multi")){
            int n = int(curLine[1]);
            for(int i = 1; i <= n; i++){
                line++;
                if(line >= lines.length) break;
                curLine = split(lines[line], ";");
                addCurLineObstacles();
            }
        }
    }

    void play(){
        prevT = millis() + offset / speed;
        started = true;
    }

}