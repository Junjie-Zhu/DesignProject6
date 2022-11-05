int num = 4;
Particle[] particles = new Particle[num];
Particle[] partLittles = new Particle[num * num];

void setup() {
    size(1000, 600);
    initiateParticleSystem();
}

void initiateParticleSystem() {
    for (int  i = 0; i < num; i++) {
        float px = random(width/2-300, width/2+300);
        float py = random(height/2-200, height/2+200);
        PVector ploc = new PVector(px, py);
        particles[i] = new Particle(ploc, 75, color(255, 0, 255), new PVector(0, 0), new PVector(width, height));
        for (int j = 0; j < num; j++) {
            PVector piTopLeft = new PVector(particles[i].loc.x - particles[i].rad / 2, particles[i].loc.y - particles[i].rad / 2);
            PVector piBottomRight = new PVector(particles[i].loc.x + particles[i].rad / 2, particles[i].loc.y + particles[i].rad / 2);
            float pxx = random(piTopLeft.x + 5, piBottomRight.x - 5);
            float pyy = random(piTopLeft.y + 5, piBottomRight.y - 5);
            PVector plocLittle = new PVector(pxx, pyy);
            partLittles[num * i + j] = new Particle(plocLittle, 7, color(255, 255, 0), piTopLeft, piBottomRight);
        }
    }
}

void draw() {
    // PVector mouseLoc = new PVector(mouseX, mouseY);
    // particles[num - 1] = new Particle(mouseLoc, 5, color(255, 255, 255, 0));

    // background(0);
    fill(0, 5);
    noStroke();
    rect(0, 0, width * 2, height * 2);

    for (int  i = 0; i < num; i ++) {
        particles[i].run();
        for (int j = 0; j < num; j++) {
            partLittles[num * i + j].topLeft = new PVector(particles[i].loc.x - particles[i].rad / 2, particles[i].loc.y - particles[i].rad / 2);
            partLittles[num * i + j].bottomRight = new PVector(particles[i].loc.x + particles[i].rad / 2, particles[i].loc.y + particles[i].rad / 2);
            partLittles[num * i + j].run();
        }
    }
}

void mousePressed() {
  background(0);
  initiateParticleSystem();
}
