library attracting_particles;

import 'dart:html';
import 'dart:async';
import 'dart:math';

part 'particle.dart';

// Based on: http://cssdeck.com/item/602/html5-canvas-particles-web-matrix

// The board is redrawn every interval ms.
final int interval = 4;

var canvas, context, particles;
var particleCount = 40, minDist = 120;

// Paint the canvas black.
paintBlack() {
  // Set the fill color to black
  context.fillStyle = 'rgba(0, 0, 0, 1)';

  // This will create a rectangle of black color from the
  // top left (0, 0) to the bottom right corner (width, height).
  context.fillRect(0, 0, canvas.width, canvas.height);
}

// Distance calculator between two particles.
distance(p1, p2) {
  var dx = p1.x - p2.x, dy = p1.y - p2.y;
  var dist = sqrt(dx*dx + dy*dy);

  // Draw the line when distance is smaller then the minimum distance.
  if(dist <= minDist) {
    context.beginPath();
    context.strokeStyle = "rgba(255, 255, 255, ${1.2-dist/minDist})";
    context.moveTo(p1.x, p1.y);
    context.lineTo(p2.x, p2.y);
    context.stroke();
    context.closePath();

    // Some acceleration for the partcles depending upon their distance.
    var ax = dx/2000, ay = dy/2000;

    // Apply the acceleration on the particles.
    p1.vx -= ax;
    p1.vy -= ay;

    p2.vx += ax;
    p2.vy += ay;
  }
}

// Give every particle some life.
update() {
  // Update every particle's position according to their velocities.
  for (var i = 0; i < particles.length; i++) {
    var p = particles[i];
    p.x += p.vx;
    p.y += p.vy;

    // We don't want to make the particles leave the area,
    // so just change their position when they touch the walls of the window.
    if (p.x + p.radius > canvas.width) {
      p.x = p.radius;
    } else if (p.x - p.radius < 0) {
      p.x = canvas.width - p.radius;
    }

    if(p.y + p.radius > canvas.height) {
      p.y = p.radius;
    } else if (p.y - p.radius < 0) {
      p.y = canvas.height - p.radius;
    }

    // Now we need to make them attract each other so
    // we'll check the distance between them and compare it to
    // the minDist we have already set.

    // We will need another loop so that each particle can be compared to
    // every other particle except itself.
    for(var j = i + 1; j < particles.length; j++) {
      var p2 = particles[j];
      distance(p, p2);
    }
  }
}

// Draw everything on the canvas.
draw() {
  paintBlack();
  for (var i = 0; i < particles.length; i++) {
    var p = particles[i];
    p.draw();
  }
  update();
}

main() {
  canvas = document.query('#canvas');
  context = canvas.getContext('2d');

  // Set the canvas width and height to occupy full window.
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;

  particles = new List<Particle>();
  // Time to add the particles into an array
  for(var i = 0; i < particleCount; i++) {
    particles.add(new Particle(canvas, context));
  }

  // Redraw every INTERVAL ms.
  new Timer.repeating(interval, (t) => draw());
}

