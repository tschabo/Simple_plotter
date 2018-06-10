include <common.scad>;
//carriage dimensions
base_width = 85;
base_height = 9;

//some dimensions are with additional margin
//linear guides settings
rods_r = 4.1;
//LM08UU bearing
linear_bearing_r = 7.6;
linear_bearing_l = 24.5;
linear_bearing_spacig = 8; //from carriage edge

//belt guiding bearing
generate_nut_holes=true;
//604 bearing
screw_hole_dia = 4.4;
belt_bearing_dia = 12;
belt_bearing_height=4.5;
belt_width = 8;
//change it accordingly to options in file Belt_Generator.scad
belt_profile = "MXL";
mouting_screw_hole_dia = 3.5;
//
nema17_motor_length = 45;
//no need to tinker with
rods_spacing = abs((linear_bearing_r+linear_bearing_spacig/2)-(base_width - (linear_bearing_r+linear_bearing_spacig/2)));