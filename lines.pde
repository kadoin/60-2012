void setup(){
  size(400,500);
}

void newLines(){
  long lines[][] = new long[15][4];
  
  for (int i=0; i<15; i++){
    int x1 = int(random(10, width-10));
    int y1 = int(random(10, height-10));
    
    int len = int(random(150,300));
    int angle = int(random(0,360));
    
    long x2 = Math.round(x1 + len*Math.cos(angle));
    long y2 = Math.round(y1 + len*Math.sin(angle));
    
    while (y2<=0 || y2>=(height-10) || x2<=0 || (x2>=width-10)){
      angle = int(random(0,360));
      x2 = Math.round(x1 + len*Math.cos(angle));
      y2 = Math.round(y1 + len*Math.sin(angle));
    }
    lines[i][0]=x1;
    lines[i][1]=y1;
    lines[i][2]=x2;
    lines[i][3]=y2;
  }
  stroke(80,80,80);
  drawLines(lines);
}

void drawLines(long lines[][]){
  for (int i=0; i<lines.length; i++){
    long x1 = lines[i][0];
    long y1 = lines[i][1];
    long x2 = lines[i][2];
    long y2 = lines[i][3];
    
    line(x1,y1,x2,y2);
  }
  for (int i=0; i<lines.length; i++){
    for (int j=i; j<lines.length; j++){
      if (i != j){
        linesIntersect(lines[i], lines[j]);
      }
    }
  }
}
  
void linesIntersect(long line1[], long line2[]){
  float x1 = line1[0];
  float y1 = line1[1];
  float x2 = line1[2];
  float y2 = line1[3];
  
  float x3 = line2[0];
  float y3 = line2[1];
  float x4 = line2[2];
  float y4 = line2[3];
  
  float xMin1 = Math.min(x1, x2);
  float xMin2 = Math.min(x3,x4);
  float xMin = Math.max(xMin1,xMin2);
  
  float xMax1 = Math.max(x1, x2);
  float xMax2 = Math.max(x3,x4);
  float xMax = Math.min(xMax1,xMax2);
  
  float yMin1 = Math.min(y1, y2);
  float yMin2 = Math.min(y3,y4);
  float yMin = Math.max(yMin1,yMin2);
  
  float yMax1 = Math.max(y1, y2);
  float yMax2 = Math.max(y3,y4);
  float yMax = Math.min(yMax1,yMax2);
   
  float slope1 = (y1-y2)/(x1-x2);
  float slope2 = (y3-y4)/(x3-x4);
  
  if (slope1==slope2){
    float x = x1;
    float y = slope1*(x-x1)+y1;
    if (xMin<=x && x<=xMax && yMin<=y && y<=yMax){
      noStroke();
      fill(127,255,212);
      ellipse(x,y,10,10);
  }
  }
  if (slope1 != slope2){
    float x = (slope1*x1-y1-slope2*x3+y3)/(slope1-slope2);
    float y = slope1*(x-x1)+y1;
    if (xMin<=x && x<=xMax && yMin<=y && y<=yMax){
      noStroke();
      fill(127,255,212);
      ellipse(x,y,10,10);
  }
  }
}
void draw(){
  background(255,192,203);
  newLines();
  noLoop();
}

void mouseClicked(){
  draw();
  loop();
}