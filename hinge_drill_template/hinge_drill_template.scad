// a template for drilling the pilot holes for a euro style hinge

include <BOSL2/std.scad>

// design parameters
center_to_edge = (1+7/16)*INCH;
center_to_center_line = (5/8)*INCH;
pilot_hole_dia = (1/16)*INCH;
stop_thickness = (1/4)*INCH;

// derived parameters
depth = center_to_edge+(1/2)*INCH;
width = 2*(center_to_center_line+(1/2)*INCH);

hinge_drill_template();

module hinge_drill_template() {
  difference() {
    base();
    pilot_holes();
    front_alignment_mark();
    back_alignment_mark();
    pilot_hole_alignment_marks();
  }
}

module base() {
  height = (3/8)*INCH;
  // the plate
  translate([0, -width/2, 0])
    cube([depth, width, height]);

  // the edge stop
  translate([ -stop_thickness, -width/2, 0])
    cube([ stop_thickness, width, height + (1/4)*INCH] );
}

module pilot_holes() {
  translate([center_to_edge, center_to_center_line, 0])
    pilot_hole();
  translate([center_to_edge, -center_to_center_line, 0])
    pilot_hole();

  module pilot_hole() {
    translate([0,0, (-1/2)*INCH])
    cylinder(d=pilot_hole_dia, h=(1)*INCH, $fn=32);
  }
}

module front_alignment_mark() {
  translate([depth, 0, 0])
  rotate([0,0,180])
  alignment_mark();
}

module back_alignment_mark() {
  translate([-stop_thickness, 0, 0])
  alignment_mark();
}

module pilot_hole_alignment_marks() {
  // two to show the distance from center line
  translate([0, center_to_center_line, 0])
    front_alignment_mark();
  translate([0, -center_to_center_line, 0])
    front_alignment_mark();

  // two to show distance from edge
  translate([center_to_edge, width/2, 0])
  rotate([0, 0, -90])
  alignment_mark();

  translate([center_to_edge, -width/2, 0])
  rotate([0, 0, 90])
  alignment_mark();
}

module alignment_mark() {
  linear_extrude((1)*INCH)
    alignment_mark_profile();

  module alignment_mark_profile() {
    regular_ngon(n=3, od=(1/8)*INCH);
  }
}
