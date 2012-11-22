part of attracting_particles;

class Particle {
  var canvas;
  var context;

  var x, y;
  var vx, vy;
  var radius;

  Particle(this.canvas, this.context) {
    // Position a particle randomly on the canvas.
    // nextDouble() generates a random value between 0 and 1,
    // so we will need to multiply that with the canvas width and height.
    x = new Random().nextDouble() * canvas.width;
    y = new Random().nextDouble() * canvas.height;

    // We would also need some velocity for a particle
    // so that it can move freely across the space.
    vx = -1 + new Random().nextDouble() * 2;
    vy = -1 + new Random().nextDouble() * 2;

    // All particles are equal in size.
    radius = 4;
  }

  // This is the method that will draw a particle on the canvas.
  // The `arc` method is used to draw a circle.
  // The `arc` method accepts four parameters.
  // the first two parameters depict the position
  // of the center point of the circle as x and y coordinates.
  // The third value is for radius, then start angle,
  // then end angle and finally a boolean value which decides
  // whether the arc is to be drawn in counter clockwise or
  // in a clockwise direction. False is for clockwise.
  draw() {
    context.fillStyle = 'white';
    context.beginPath();
    context.arc(x, y, radius, 0, PI * 2, false);
    // Fill the color to the arc that we just created.
    context.fill();
  }

}
