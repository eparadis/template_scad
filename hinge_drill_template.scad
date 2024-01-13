// a template for drilling the pilot holes for a euro style hinge

include <BOSL2/std.scad>

center_to_edge = (1+7/16)*INCH;
center_to_center_line = (5/8)*INCH;
pilot_hole_dia = (1/16)*INCH;

module pilot_hole() {
  translate([0,0, (-1/2)*INCH])
    cylinder(d=pilot_hole_dia, h=(1)*INCH, $fn=32);
}

module pilot_holes() {
  translate([center_to_edge, center_to_center_line, 0])
    pilot_hole();
  translate([center_to_edge, -center_to_center_line, 0])
    pilot_hole();
}

module base() {
  height = (3/8)*INCH;
  depth = center_to_edge+(1/2)*INCH;
  width = 2*(center_to_center_line+(1/2)*INCH);
  // the plate
  translate([0, -width/2, 0])
    cube([depth, width, height]);

  // the edge stop
  translate([(-1/2)*INCH, -width/2, 0])
    cube([ (1/2)*INCH, width, height + (1/4)*INCH] );
}

module hinge_drill_template() {
  difference() {
    base();
    pilot_holes();
  }
}

hinge_drill_template();
