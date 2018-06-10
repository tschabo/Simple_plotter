// file with helpful modules only
module screw_hole(dia,depth, nut_holes)
{
cylinder(r=dia/2, h=depth, $fn=8);
        if(nut_holes) 
            cylinder(r=dia*0.95, h=3, $fn=6);
        else
            cylinder(r=dia*1.1, h=3);
}

module roundedRect(size, radius) 
{ 
    x = size[0]; y = size[1]; z = size[2]; 
    
    linear_extrude(height=z) 
    hull() { // place 4 circles in the corners, with the given radius 
    translate([(-x/2)+(radius), (-y/2)+(radius), 0])        circle(r=radius); 
    translate([(x/2)-(radius), (-y/2)+(radius), 0]) 
    circle(r=radius); 
    translate([(-x/2)+(radius), (y/2)-(radius), 0]) 
    circle(r=radius); 
    translate([(x/2)-(radius), (y/2)-(radius), 0]) 
    circle(r=radius); 
    } 
}
