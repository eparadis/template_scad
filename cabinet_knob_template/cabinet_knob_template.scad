// a template for drilling the hole for the knob on a cabinet door

include <BOSL2/std.scad>

// design parameters
door_top_to_center = (2+1/4)*INCH;
door_side_to_center = (1+1/8)*INCH;
pilot_hole_dia = (1/16)*INCH;
stop_thickness = (1/4)*INCH;

// derived parameters
width = door_side_to_center + (1/2)*INCH;
height = door_top_to_center + (1/2)*INCH;

cabinet_knob_template();

module cabinet_knob_template() {
  difference() {
    base();
    pilot_hole();
    pilot_hole_alignment_marks();
  }
}

module base() {
  thickness = (1/4)*INCH;
  // the plate
  cube([height, width, thickness]);

  // the top stop
  translate([ -stop_thickness, (1/4)*INCH, 0])
    cube([ stop_thickness, width - (1/4)*INCH, thickness + (1/4)*INCH] );

  // the side stop
  translate([(1/4)*INCH, -stop_thickness, 0])
    cube([height-(1/4)*INCH, stop_thickness, thickness + (1/4)*INCH] );
}

module pilot_hole() {
  translate([door_top_to_center, door_side_to_center, (-1/2)*INCH])
    cylinder(d=pilot_hole_dia, h=(1)*INCH, $fn=32);
}

module pilot_hole_alignment_marks() {
  // two to show alignment from the side
  translate([-stop_thickness, door_side_to_center, 0])
  alignment_mark();

  translate([height, door_side_to_center, 0])
  rotate([0,0,180])
  alignment_mark();
  
  // two to show distance from top
  translate([door_top_to_center, width, 0])
  rotate([0, 0, -90])
  alignment_mark();

  translate([door_top_to_center, -stop_thickness, 0])
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
