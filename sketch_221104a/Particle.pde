class Particle {
    PVector loc;
    float rad;
    PVector vel = new PVector(0, 0);
    PVector acc = new PVector(0, 0);
    float accMag = 0.0;
    color fc;
    PVector topLeft, bottomRight;

    Particle(PVector loc_, float r, color c, PVector tl, PVector br) {
        loc = loc_;
        rad = r;
        fc = c;
        topLeft = tl;
        bottomRight = br;
    }

    void run() {
        acceleration();
        update();
        crossCanvas();
        show();
    }

    void show() {
        // noFill();
        // stroke(255);
        // strokeWeight(5);
        stroke(fc);
        noFill();
        rectMode(CENTER);
        rect(loc.x, loc.y, rad, rad);
    }

    void acceleration() {
        for (Particle p : particles) {
            PVector direction = PVector.sub(loc, p.loc);
            float dist = direction.mag();

            if (dist <= 20 && dist > 0) {
                accMag = 100 / dist;
            }
            else if (dist >= 20) {
                accMag = - pow(dist, -1);
            }

            direction.normalize();
            direction.mult(accMag);
            acc.add(direction);
        }

        for (Particle p : partLittles) {
            PVector direction = PVector.sub(loc, p.loc);
            float dist = direction.mag();

            if (dist <= 20 && dist > 0) {
                accMag = 100 / dist;
            }
            else if (dist >= 20) {
                accMag = - pow(dist, -1);
            }

            direction.normalize();
            direction.mult(accMag);
            acc.add(direction);
        }
    }

    void update() {
        vel.add(acc);
        vel.limit(map(rad, 0, 200, 5, 20));
        loc.add(vel);
        acc = new PVector(0, 0);
    }

    void crossCanvas(){
        if(loc.x > bottomRight.x) loc.x = topLeft.x;
        if(loc.x < topLeft.x) loc.x = bottomRight.x;
        if(loc.y > bottomRight.y) loc.y = topLeft.y;
        if(loc.y < topLeft.y) loc.y = bottomRight.y;
    }
}