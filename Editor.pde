import java.io.FileWriter;

class Editor extends PApplet{

    PApplet main;

    int pointer = 0;
    int subPointer = 0;
    int subSubPointer = -1;
    boolean selected = false;

    String newTrack = "";
    String fileName = "";
    String[] saveAs = new String[]{
        "Song Name: ",
        "Background Color: #",
        "Obstacle Color: #",
        "Player Color: #",
        "Beats Per Minute: ",
        "Offset: "
    };
    int[] headers = {11, 19, 17, 15, 18, 8};

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
                textAlign(CORNER, CORNER);
                if(subPointer == 0){
                    text(newTrack, textWidth("Save As") + 100, 100);
                }
                else if(subPointer == 1){
                    int temp = 100;
                    for(String s : saveAs){
                        text(s, textWidth("Save As") + 100, temp);
                        temp += 50;  
                    }
                }
                textAlign(CENTER, CENTER);
                if(subSubPointer == -1) triangle(10, 170 + subPointer * 100, 30, 180 + subPointer * 100, 10, 190 + subPointer * 100);
                else triangle(textWidth("Save As") + 70, 80 + subSubPointer * 50, textWidth("Save As") + 90, 90 + subSubPointer * 50, textWidth("Save As") + 70, 100 + subSubPointer * 50);
            }
            else if(pointer == 1){
                textSize(40);
                text("Settings", width / 2, 30);
                textSize(20);
                text("Speed", textWidth("Speed") / 2 + 40, 180);
                rectMode(CORNER);
                rect(textWidth("Speed") + 60, 170, 550 * (speed - 0.5) / 1.5, 20);
                rectMode(CENTER);
                text(nf(speed, 0, 2), 550 * (speed - 0.5) / 1.5 + textWidth("Speed") + 50, 210);
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
                subSubPointer = -1;
            }
            if(pointer == 0){
                if(subSubPointer == -1){
                    if(keyCode == DOWN){
                        subPointer = (subPointer + 1) % 2;
                    }
                    else if(keyCode == UP){
                        if(subPointer == 0) subPointer = 1;
                        else subPointer--;
                    }
                }
                if(subPointer == 0){
                    if((Character.toLowerCase(key) >= 'a' && Character.toLowerCase(key) <= 'z') || (key >= '0' && key <= '9') || key == ';' || key == ' ' || key == '.'){
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
                    if(subSubPointer == -1){
                        if(keyCode == RIGHT) subSubPointer = 0;
                        else if(keyCode == ENTER){
                            String line = tracks.size() + "";
                            for(int i = 0; i <= 5; i++){
                                line += ";" + saveAs[i].substring(headers[i]);
                            }
                            try{
                                output = new PrintWriter(new FileWriter("D:\\My Assets\\Processing Projects\\Just Shapes\\data\\Track" + tracks.size() + ".txt"));
                                output.print(newTrack);
                                output.close();
                                output = new PrintWriter(new FileWriter("D:\\My Assets\\Processing Projects\\Just Shapes\\data\\TrackReference.txt", true));
                                output.print("\n" + line);
                                output.close();
                            }
                            catch(IOException e){
                                e.printStackTrace();
                            }
                            String[] temp = line.split(";");
                            tracks.add(new Track(int(temp[0]), temp[1], color(unhex("FF" + temp[2])), color(unhex("FF" + temp[3])), color(unhex("FF" + temp[4])), float(temp[5]), float(temp[6]), this));
                            songs.add(new SoundFile(this, "data/" + temp[1] + ".mp3"));
                            newTrack = "";
                            saveAs = new String[]{
                                "Song Name: ",
                                "Background Color: #",
                                "Obstacle Color: #",
                                "Player Color: #",
                                "Beats Per Minute: ",
                                "Offset: "
                            };
                            selected = false;
                            subSubPointer = -1;
                        }
                    }
                    else{
                        if(keyCode == LEFT){
                            subSubPointer = -1;
                        }
                        else if(keyCode == DOWN){
                            subSubPointer = (subSubPointer + 1) % 6;
                        }
                        else if(keyCode == UP){
                            if(subSubPointer == 0) subSubPointer = 5;
                            else subSubPointer--;
                        }
                        else if((Character.toLowerCase(key) >= 'a' && Character.toLowerCase(key) <= 'z') || (key >= '0' && key <= '9') || key == ' '){
                            saveAs[subSubPointer] += key;
                        }
                        else if(keyCode == BACKSPACE && saveAs[subSubPointer].length() > headers[subSubPointer]){
                            saveAs[subSubPointer] = saveAs[subSubPointer].substring(0, saveAs[subSubPointer].length() - 1);
                        }
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