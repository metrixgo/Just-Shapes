class Editor extends PApplet{

    PApplet main;

    int pointer = 0;
    int subPointer = 0;
    boolean selected = false;

    String newTrack = "";
    String fileName = "";
    PrintWriter output;
    
    Editor(PApplet main){
        this.main = main;
    }

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
        if(!selected){
            textSize(40);
            text("Control Panel", width / 2, 30);
            textSize(20);
            text("New Track", textWidth("New Track") / 2 + 40, 180);
            text("Settings", textWidth("Settings") / 2 + 40, 280);
            text("Quit", textWidth("Quit") / 2 + 40, 380);
            triangle(10, 170 + pointer * 100, 30, 180 + pointer * 100, 10, 190 + pointer * 100);
        }
        else{
            if(pointer == 0){
                textSize(40);
                text("New Track", width / 2, 30);
                textSize(20);
                text("Edit", textWidth("Edit") / 2 + 40, 180);
                text("Save As", textWidth("Save As") / 2 + 40, 280);
                if(subPointer == 0){
                    textAlign(CORNER, CORNER);
                    text(newTrack, textWidth("Save As") + 100, 100);
                    textAlign(CENTER, CENTER);
                }
                else if(subPointer == 1){
                    textAlign(CORNER, CORNER);
                    text(fileName, textWidth("Save As") + 100, 100);
                    textAlign(CENTER, CENTER);
                }
                triangle(10, 170 + subPointer * 100, 30, 180 + subPointer * 100, 10, 190 + subPointer * 100);
            }
            else if(pointer == 1){
                textSize(40);
                text("Settings", width / 2, 30);
                textSize(20);
                text("Speed", textWidth("Speed") / 2 + 40, 180);
                rectMode(CORNER);
                rect(textWidth("Speed") + 60, 170, 550 * (speed - 0.5) / 1.5, 20);
                rectMode(CENTER);
                text(speed, 550 * (speed - 0.5) / 1.5 + textWidth("Speed") + 50, 210);
                triangle(10, 170 + subPointer * 100, 30, 180 + subPointer * 100, 10, 190 + subPointer * 100);
            }
        }
        
    }

    void exit(){
        opened = false;
        surface.setVisible(false);
        dispose();
    }

    void keyPressed(){
        if(!selected){
            if(keyCode == DOWN || key == 's'){
                pointer = (pointer + 1) % 3;
            }
            else if(keyCode == UP || key == 'w'){
                if(pointer == 0) pointer = 2;
                else pointer--;
            }
            else if(keyCode == ENTER){
                if(pointer == 2){
                    exit();
                }
                else{
                    subPointer = 0;
                    selected = true;
                }
            }
        }
        else{
            if(keyCode == CONTROL){
                selected = false;
            }
            if(pointer == 0){
                if(keyCode == DOWN){
                    subPointer = (subPointer + 1) % 2;
                }
                else if(keyCode == UP){
                    if(subPointer == 0) subPointer = 1;
                    else subPointer--;
                }
                if(subPointer == 0){
                    if((key >= 'a' && key <= 'z') || (key >= '0' && key <= '9') || key == ';' || key == ' ' || key == '.'){
                        newTrack += key;
                    }
                    else if(keyCode == ENTER){
                        newTrack += "\n";
                    }
                    else if(keyCode == BACKSPACE && newTrack.length() > 0){
                        newTrack = newTrack.substring(0, newTrack.length() - 1);
                    }
                }
                else if(subPointer == 1){
                    if((key >= 'a' && key <= 'z') || (key >= '0' && key <= '9') || (key >= 'A' && key <= 'Z') || key == ' ' || key == ';'){
                        fileName += key;
                    }
                    else if(keyCode == BACKSPACE && fileName.length() > 0){
                        fileName = fileName.substring(0, fileName.length() - 1);
                    }
                    else if(keyCode == ENTER && fileName.length() > 0 && newTrack.length() > 0){
                        String[] temp = fileName.split(";");
                        output = createWriter("D:\\My Assets\\Processing Projects\\Just Shapes\\data\\Track" + tracks.size() + ".txt");
                        output.print(newTrack);
                        output.flush();
                        output.close();
                        tracks.add(new Track(tracks.size(), temp[0], NEARLYBLACK, PINKRED, CYAN, float(temp[1]), float(temp[2]), main));
                        songs.add(new SoundFile(this, "data/" + temp[0] + ".mp3"));
                        newTrack = "";
                        fileName = "";
                        selected = false;
                    }
                }
            }
            else if(pointer == 1){
                if(keyCode == LEFT || key == 'a'){
                    speed = max(0.5, speed - 0.01);
                }
                else if(keyCode == RIGHT || key == 'd'){
                    speed = min(2, speed + 0.01);
                }
            }
        }
    }
}