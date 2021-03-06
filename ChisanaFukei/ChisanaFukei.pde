// 小さな風景 Chīsana fūkei is Japanese for "small landscapes"

float branchSize = 1000.0/18.0;
int maxBranchesLevel = 15;
boolean shadow = false;

void branch(int level) {
  if (level > maxBranchesLevel) {return;}

  float randomBranchAngle = random(PI/(level+5));
  pushMatrix();

  //strokeWeight(10);
  //stroke(255,0,0);
  //ellipse(0,0,1.25,1.25);

  rotate(-randomBranchAngle);
  trunk(++level);  
  popMatrix();

  rotate(randomBranchAngle);
  trunk(++level);

}

//void terminal_branch (float angle, float len) {
//  pushMatrix();
//  rotate(angle);
//  line(0, 0, len*0.8, 0); // reduce length of terminal branch
//  popMatrix();
//}

void scraggle(int level) {
  float strideLength = maxBranchesLevel-level;
  strideLength = max(3,strideLength/2);
  strideLength += random(strideLength/10);
  translate(0,-strideLength);
  float randomAngleExtent = 0.05 * (1+level/2);
  
  float randomAngle = random(-randomAngleExtent,randomAngleExtent);
  rotate(randomAngle);
}


void trunk(int level) {

    if (level > maxBranchesLevel) {return;}
    
    float alpha = 255;
    if (shadow){
      alpha = 6;
      strokeWeight(10);
      stroke(120,120,120,alpha);
    }
    else {
      stroke(210,220,220,alpha);
    }

     while (random(10) > 1+level/7){

        float ellipseSize = max(1,max(1,2 + maxBranchesLevel-level));
        ellipseSize += random(ellipseSize/10);

        //noStroke();

        //fill(175,175,175,25);
        //ellipse(0,0,ellipseSize+10,ellipseSize+10);
        //fill(155,155,155,255);
        //ellipse(0,0,ellipseSize,ellipseSize);

        for (int i = 0; i < 10; i = i+1) {
          float randomy = random(0,ellipseSize/2);
          float randomx = random(0,ellipseSize/2);
          float rnd1 = random(5);
          float rnd2 = random(5);
          float rnd3 = random(ellipseSize/2 + 5);
          float rnd4 = random(ellipseSize/2 + 5);
          if (shadow) line(rnd1, rnd2, rnd3, rnd4);
        }
  
        if (!shadow) {
          fill(255,alpha);
          ellipse(0,0,ellipseSize,ellipseSize);
        }

        
        stroke(20,alpha);

        if (!shadow){
          strokeWeight(2);
          line(ellipseSize/2,0,ellipseSize/2,ellipseSize/2);

          strokeWeight(1);
          line(-ellipseSize/2,0,-ellipseSize/2,ellipseSize/2);
        }
        
        //if (level < maxBranchesLevel-1){
        strokeWeight(1);
        for (int i = 0; i < 10; i = i+1) {
          float randomy = random(0,ellipseSize/2);
          float randomx = random(0,ellipseSize/2);
          if (!shadow){
            line(randomx, randomy, ellipseSize/2, randomy);
          }
         }
        //}

        if (!shadow){
          strokeWeight(0.5);
        }

        for (int i = 0; i < 10; i = i+1) {
          float randomy = random(0,ellipseSize/2);
          float randomx = max(0,random(0,4-level));
          float randomLength = random(0,2);
          if (!shadow){
            line(-ellipseSize/2+randomx, randomy, -ellipseSize/2+randomx+randomLength, randomy);
          }
         }


        scraggle(level);
     }
     
     branchSize *= 0.7;
     branch(level);


  //line(0, 0, len, 0);
  //translate(len, 0);
}

void drawBall() {
  float prevX = 9,prevY = 8;
  float firstX = 9,firstY = 8;
  float noiseStart = random(188); 

  pushMatrix();
  rotate(-0.1);
  scale(1.5,0.35);
  translate(10,90);
  int n = 55;
  for(int i = 1; i < n; i++) {
    float angle = i*PI/n;
    float radius = 39 + noise(angle + noiseStart);
    float x = radius * cos(angle);
    float y = radius * sin(angle);
    if (i==1) {
      firstX = x-5;
      firstY = y;
    } else {
      //x = (n-i)*x/n + i*firstX/n;
      //y = (n-i)*y/n + i*firstY/n;
      //strokeWeight(1);
      //stroke(0);
      //line(prevX,prevY, x, y); 
      strokeWeight(2);
      stroke(60,100);
      line(2+x*0.8 + random(2),y*0.8+ random(2),-2+x*0.8+ random(2),-y*0.8+ random(2));
    }
    prevX = x;
    prevY = y; 
  }

  popMatrix();

  n = 50;
  for(int i = 1; i < n; i++) {
    float angle = i*2*PI/n;
    float radius = 39 + noise(angle + noiseStart);
    float x = radius * cos(angle);
    float y = radius * sin(angle);
    if (i==1) {
      firstX = x;
      firstY = y;
    } else {
      //x = (n-i)*x/n + i*firstX/n;
      //y = (n-i)*y/n + i*firstY/n;

      strokeWeight(5);
      stroke(255);
      line(x, y,0,0); 

      strokeWeight(1);
      stroke(0);
      line(prevX,prevY, x, y); 
    }
    prevX = x;
    prevY = y; 
  }

  pushMatrix();
  n = 2000;
  int displacement = 7;
  translate(-displacement,-displacement);
  for(int i = 1; i < n; i++) {
    float randomAngle = random(0,2*PI);
    float randomRadius = 1.55*30*(1 - pow(random(0,0.9),9));
    float x = randomRadius * cos(randomAngle);
    float y = randomRadius * sin(randomAngle);
    if (dist(x,y,displacement,displacement) < 39) {
      stroke(0,150);
      rect(x,y,1,1);
    } 
  }
  popMatrix();
}


// LINE/LINE
float[] theReturn = new float[2];
float[] lineToLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  // calculate the distance to intersection point
  theReturn[0] = 0;
  theReturn[1] = 0;
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  
  // if uA and uB are between 0-1, lines are colliding
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
    // optionally, draw a circle where the lines meet
    float intersectionX = x1 + (uA * (x2-x1));
    float intersectionY = y1 + (uA * (y2-y1));
    //fill(255,0,0);
    //noStroke();
    //ellipse(intersectionX,intersectionY, 20,20);
    
    theReturn[0] = intersectionX;
    theReturn[1] = intersectionY;
    return theReturn;
  }
  theReturn[0] = 0;
  theReturn[1] = 0;
  return theReturn;
}

void wigglyLine(float startX, float startY, float endX, float endY) {

  float startXSplit = 0;
  float startYSplit = 0;

  float endXSplit = startX;   
  float endYSplit = startY;

  float vectX = endX - startX;
  float vectY = endY - startY;

  for(int i = 1; i < 12; i++) {

    startXSplit = endXSplit;   
    startYSplit = endYSplit;

    endXSplit = startX + (i+1)*vectX/12;   
    endYSplit = startY + (i+1)*vectY/12;
    
    endXSplit += random(-1,1);
    endYSplit += random(-1,1);

    float aRandom = random(0,10);
    if (aRandom < 0.2)
      stroke(255);
    else if (aRandom < 3)
      stroke(125);
    else
      stroke(0);

    line(startXSplit, startYSplit, endXSplit, endYSplit );
    //prevX = endXSplit;
    //prevY = endYSplit;
  }

}

void drawDurerPolygon() {
  pushMatrix();
  
  scale(0.1,0.1);
  

  
  stroke(0);
  strokeWeight(10);


  for(int i = 1; i < 12; i++) {
    wigglyLine(221+i*20,746+i*20,856+i*20,659+i*20);
  }

  fill(255);
  noStroke();
  triangle(344,878,733,809,937,614);
  triangle(221,746,344,878,733,809);
  triangle(221,746,937,614,344,878);
  noFill();

  
  wigglyLine(263,65,630,53);
  wigglyLine(263,65,625,69); // fill
  wigglyLine(263,65,619,89);

  wigglyLine(263,65,77,236);

  wigglyLine(77,236,227,752);

  wigglyLine(630,53,619,89);

  wigglyLine(619,89,721,299);

  wigglyLine(619,89,721,299);

  wigglyLine(721,299,227,752);

  wigglyLine(227,752,334,881);

  wigglyLine(334,881,733,806);

  wigglyLine(733,806,931,620);

  wigglyLine(625,68,931,620); // fill

  wigglyLine(931,620,721,299);

  wigglyLine(931,620,630,53);

  for(int i = 1; i < 12; i++) {
    float vectorx = 721 - 227;
    float vectory = 752 - 299;
    float fullLineStartX = 227 + i*vectorx/20;
    float fullLineStartY = 752 + i*vectory/20;
    float fullLineEndX = 227 + i*vectorx/20 + vectorx;
    float fullLineEndY = 752 + i*vectory/20 - vectory;

    float[] shortStart;
    float[] shortEnd;
    //float shortStart1 = lineToLine(fullLineStartX,fullLineStartY,fullLineEndX,fullLineEndY,227+10,752,334+10,881)[0];
    //float shortStart2 = lineToLine(fullLineStartX,fullLineStartY,fullLineEndX,fullLineEndY,227+10,752,334+10,881)[1];

    shortEnd = lineToLine(fullLineStartX-30,fullLineStartY+5,fullLineEndX+30,fullLineEndY+5,721,299,931+10,620+10);
    float shortEndX = shortEnd[0];
    float shortEndY = shortEnd[1];


    shortStart = lineToLine(fullLineStartX-30,fullLineStartY+5,fullLineEndX+20,fullLineEndY+5,227,752,334,881);
    float shortStartX = shortStart[0];
    float shortStartY = shortStart[1];
    if (shortStartX != 0 && shortStartY != 0)
      wigglyLine(shortStartX,shortStartY,shortEndX,shortEndY);

    shortStart = lineToLine(fullLineStartX-30,fullLineStartY+5,fullLineEndX+20,fullLineEndY+5,334,881,733,806);
    shortStartX = shortStart[0];
    shortStartY = shortStart[1];
    if (shortStartX != 0 && shortStartY != 0)
      wigglyLine(shortStartX,shortStartY,shortEndX,shortEndY);

}

  popMatrix();
}


void drawTree() {
  background(255);    

  int seed2 = round(random(0,100));
  noiseSeed(seed2);

  float y = 0;
  float x = 0;
  float noiseY = 0;
  int n = width;
  float previousY = 0;
  float previousX = 0;
  pushStyle();
  stroke(0,255);
  strokeWeight(1);

  for(int i = 1; i < n; i++) {
   y += .01;
   x = i* (width/n); //evenly distributes line across window
   noiseDetail(6,0.3);
   noiseY = noise(y) * height/2 + height/8;
   noiseY += random(2);
   noiseDetail(6,0.6);
   float noiseHeight = max(0,(noise(y)-0.5)) * height * 3;
   if (previousX != 0 && previousY != 0) {

     stroke(200);
     for(int k = 1; k < 20; k++) {
       float randomY = random(100) - 250;
       float noiseY2 = (noise(y+5)-0.5) * height / 5;
       stroke(noiseY2-randomY);
       line(x,noiseY2-randomY,x,noiseY2-randomY - random(2) );
     }
     
     stroke(0,255);
     line(x,noiseY,previousX,previousY);

     stroke(255,255);
     line(x,noiseY,x,height );
   }
   
   stroke(0,255);

   if (previousY <noiseY ){
     //fill(255,0,0);
     //ellipse(x,noiseY,10,10);
     //line(x,noiseY,x,noiseY + noiseHeight/50);
     for(int j = 1; j < 10; j++) {
       float randomH = random(noiseHeight/10);
       line(x,noiseY+randomH ,x,noiseY + randomH + 1 );
     }
   }

   previousX = x;
   previousY = noiseY;
   //text("word is weird", x, noiseY);
  }
  popStyle();

  shadow = false;
  pushStyle();
  noiseDetail(2,0.8);
  for (int i = 0; i < 4; i = i+1) {
    stone();
  }
  popStyle();


  translate(width/2, height - 80);

    //fill(255,0,0);
  //ellipse(0,0,50,50);
  stroke(125,255);
  strokeWeight(1);
  for(int i = 1; i < 20; i++) {
    line(i,i/10+random(5),i, i/10+random(5));
    line(-10-i,i/10+random(5),-10-i, i/10+random(5));
  }
  
  float length = 70;
  int seed = round(random(0,100));
  randomSeed(seed);

  shadow = true;
  strokeWeight(3);

  applyMatrix( 
  1, tan( radians(-65) ), 0,
  0, 1, 0
  );
  scale(0.6,0.1);

  rotate(random(-PI/20,PI/20));
  trunk(0);

 
  randomSeed(seed);
  
  resetMatrix();
  shadow = false;

  translate(width/2.02, height - 88);
  rotate(random(-PI/20,PI/20));
  trunk(0);

  resetMatrix();
  for (int i = 0; i < 1; i = i+1) {
    pushMatrix();
    //translate(width/2,height/2);
    translate(random(width/10, width - width/10),height/2+height/(2.3+random(0.8)));
    scale(0.7);
    drawBall();
    popMatrix();
  }

  resetMatrix();
  for (int i = 0; i < 1; i = i+1) {
    pushMatrix();
    //translate(width/2,height/2);
    translate(random(width/10, width - width/10),height/2+height/(2.5+random(0.8)));
    //scale(0.7);
    drawDurerPolygon();
    popMatrix();
  }

}

void stone() {
  int n = 200;
  float radius = 30;
  pushMatrix();

  translate(random(width/10, width - width/10),height/(2.3+random(0.2)));
  if (!shadow) translate(0,height/2);
  if (!shadow) scale(0.5,0.3);
  if (!shadow) scale(random(0.4,0.7));  
  if (!shadow) translate(0,25);

  if (!shadow) strokeWeight(1);
  if (!shadow) stroke(50,255);
  float factor = 0.8;
  for(int i = 1; i < 55; i++) {
    //line(random(-factor*radius,factor*radius),random(-factor*radius,factor*radius),random(-factor*radius,factor*radius),random(-factor*radius,factor*radius));
    float randomY = random(-factor*radius,factor*radius)/2;
    float rand1 = random(-5,5);
    float rand2 = random(-5,5);
    float rand3 = random(-2,2);
    if (!shadow) line(0+rand1,randomY,radius+rand2,-10+randomY+rand3);
  }
  if (!shadow) translate(0,-25);
 

  float prevX = 0,prevY = 0;
  float firstX = 0,firstY = 0;
  float noiseStart = random(100);
  for(int i = 1; i < n; i++) {
    float angle = i*2*PI/n;
    radius = 30 + 30*noise(angle + noiseStart);
    float x = -radius/2 + radius * cos(angle);
    float y = radius * sin(angle);
    if (i==1) {
      firstX = x;
      firstY = y;
    }
    else {
      x = (n-i)*x/n + i*firstX/n;
      y = (n-i)*y/n + i*firstY/n;
      if (!shadow) strokeWeight(1);
      if (!shadow) stroke(255,255);
      if (!shadow) line(x,y,0,0);

    }
    
    
    if (angle < 1.2*PI/3){
      if (random(20)>15){
        if (!shadow) stroke(100,255);
        if (!shadow) strokeWeight(3);
        float littleRandom = random(1);
        float rand1 = random(1);
        float rand2 = random(1);
        if (!shadow) line(x,y,rand1 + x/(1.9-littleRandom),rand2 + y/(1.9- littleRandom));
      }
    }

    if (i!=1) {
      if (!shadow) strokeWeight(1);
      if (!shadow) stroke(0,255);
      if (!shadow) line(prevX,prevY,x,y);
    }

    prevX = x;
    prevY = y;
  }
  
  popMatrix();


}


void setup() {
  size(1000, 1000);  
  drawTree();
}

void mousePressed() {
  drawTree();
}

void draw() {
}
