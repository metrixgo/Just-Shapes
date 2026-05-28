class Editor extends PApplet{

    void settings(){
        size(800, 600);
    }

    void setup(){
        textAlign(CENTER, CENTER);
        textFont(createFont("Consolas", 30));
    }

    void draw(){
        background(NEARLYBLACK);
        fill(255);
        textSize(80);
        text("Level Editor", width / 2, 80);
        textSize(50);
        text("New Track", width / 2, 280);
        text("Quit", width / 2, 480);
    }

    void exit(){
        opened = false;
        dispose();
    }
}