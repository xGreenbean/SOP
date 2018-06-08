Node head;
Node temp;
int regular=0;
int doughnut=1;
int farone=2;
int fartwo=3;
static int stop=500;
static int count=0;
static float rate=0.5;
static int nRate=1;
ArrayList<Node> points;
int numberOfDataPoint = 500;
int neuron_option=regular;
int data_option=fartwo;
void setup() {
  points=new ArrayList<Node>();
  for (int i=0; i<numberOfDataPoint; i++) {
    points.add(new Node(data_option));
  }
  head=new Node(neuron_option);
  temp=head;
  head.id='A';
  for (int i=1; i<19; i++) {
    temp.next=new Node(neuron_option);
    temp.next.prev=temp;
    temp.next.id=(char)('A'+i);
    temp=temp.next;
  }
  temp.next=new Node(neuron_option);
  temp.next.prev=temp;
  temp.next.id=(char)('A'+19);
  temp.next.next=head;
  head.prev=temp.next;
  size(1000, 1000);
  background(255);
  noStroke();
  stroke(155);
  ellipse(500, 500, 1000, 1000);
}
void draw() {
  println(count);
  /*number of ephocs*/
  count++;
  /*contorling the neighboring function*/
  if (count%50==0) {
    //nRate--;          
    rate=rate/1.2;
  }

  /*global "learning rate"*/


  /*initializing enviroment*/
  background(255);
  stroke(155);
  ellipse(500, 500, 1000, 1000);
  /*update - work on new data point and update neurons*/
  head.update(nRate);
  temp=head;
  /*go over the neoruns and printe'm*/
  while (temp.next.id!='A') {
    stroke(140);
    ellipse(temp.x, temp.y, 10, 10);
    line(temp.x, temp.y, temp.next.x, temp.next.y);
    temp=temp.next;
  }
  line(temp.x, temp.y, temp.next.x, temp.next.y);
  stroke(140);
  ellipse(temp.x, temp.y, 10, 10);

  /*if number of ephocs reached the limit then finish*/
  if (count==stop) {

    for (Node node : points) {
      fill(210);
      stroke(210);
      ellipse( node.x, node.y, 5, 5);
    }
    noLoop();
  }
}

class Node {
  char id;
  float x;
  float y;
  Node next;
  Node prev;
  Node(int x) {
    if (x==regular)
      setXY();
    else if (x==doughnut)
      setDoughtNut();
    else if(x==farone)
      setFarOne();
    else 
      setFarTwo();
  }
  void addPrev(Node prev) {
    this.prev=prev;
  }
  void addNext(Node next) {
    this.next=next;
  }
  float distance(float x1, float y1) {
    return dist(x1, y1, this.x, this.y);
  }
  void update(int neighbor_rate) {
    int index=(int)random(0, numberOfDataPoint);
    //print(num.x+" "+" "+num.y+" dist "+dist(num.x,num.y,500,500)+"\n");


    Node close=this.closest(points.get(index).x, points.get(index).y);
    close.x=close.x+rate*(points.get(index).x-close.x);
    close.y=close.y+rate*(points.get(index).y-close.y);
    //go forward
    float i=1;
    while (close.next!=null&&i<=neighbor_rate) {
      close.next.x=close.next.x+(rate/(i))*(points.get(index).x-close.next.x);
      close.next.y=close.next.y+(rate/(i))*(points.get(index).y-close.next.y);
      close=close.next;
      i++;
    }
    //go backwards
    i=1;
    while (close.prev!=null&&i<=neighbor_rate) {
      close.prev.x=close.prev.x+(rate/(i))*(points.get(index).x-close.prev.x);
      close.prev.y=close.prev.y+(rate/(i))*(points.get(index).y-close.prev.y);
      close=close.prev;
      i++;
    }
  }
  Node closest(float x1, float y1) {
    Node temp=this;
    float d=1000;
    Node close=this;
    if (temp.distance(x1, y1)<d) {
      d=temp.distance(x1, y1);
      close=temp;
    }
    temp=temp.next;
    while (temp.id!='A') {
      if (temp.distance(x1, y1)<d) {
        d=temp.distance(x1, y1);
        close=temp;
      }
      temp=temp.next;
    }
    return close;
  }
  void setXY() {
    float a = random(0, 1) * 2 * PI;
    float r = 500 * sqrt(random(0, 0.25));
    float x = r * cos(a);
    float y = r * sin(a);
    this.x=x+500;
    this.y=y+500;
  }
  void setDoughtNut() {
    float a = random(0, 1) * 2 * PI;
    float r = 500 * sqrt(random(0.25, 1));
    float x = r * cos(a);
    float y = r * sin(a);
    this.x=x+500;
    this.y=y+500;
  }
  void setFarOne() {
    float px=1000;
    float py=500;
    float a = random(0, 1) * 2 * PI;
    float r = 500 * sqrt(random(0, 1));
    float x = r * cos(a);
    float y = r * sin(a);
    x=x+500;
    y=y+500;
    float rand=random(0, 1000);
    while (dist(x, y, px, py)<=rand) {
      println("hi");
      a = random(0, 1) * 2 * PI;
      r = 500 * sqrt(random(0, 1));
      x = r * cos(a);
      y = r * sin(a);
      x=x+500;
      y=y+500;
    }
    this.x=x;
    this.y=y;
  }
  void setFarTwo() {
    float px1=1000;
    float py1=500;
    float py2=0;
    float px2=500;
    float a = random(0, 1) * 2 * PI;
    float r = 500 * sqrt(random(0, 1));
    float x = r * cos(a);
    float y = r * sin(a);
    x=x+500;
    y=y+500;
    float rand=random(707, 1848);
    while ((dist(x, y, px1, py1)+dist(x, y, px2, py2))<=rand) {
      println("hi");
      a = random(0, 1) * 2 * PI;
      r = 500 * sqrt(random(0, 1));
      x = r * cos(a);
      y = r * sin(a);
      x=x+500;
      y=y+500;
    }
    this.x=x;
    this.y=y;
  }
}
