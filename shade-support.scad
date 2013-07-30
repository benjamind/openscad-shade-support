//all sizes are in mm
pipeOD=0.922*25.4;
pipeID=0.824*25.4;

tolerance=0.2; // 0.2mm
supportWidth = 100; // 10cm
supportHeight = 40; // 4cm

insertRadius = (pipeID/2)-tolerance;
insertLength = 20; // 2cm

// ratio of height to radius should not result in more than 45 degree angle, so it should be taller than it is wide
insertPlugHeight = 8; //5mm
insertPlugRadius = 5;

module support() {
	union() {
		difference() {
			scale([supportWidth/2,supportWidth/2,supportHeight/2]) {
				translate([0,0,-0.5]) {
					difference() {
						translate([0,0,0.8])
							sphere(r=1,$fn=100);
						translate([0,0,0])
							cylinder(h=1,r=1,center=true,$fn=100);
					}
				}
			}
			union() {
				translate([0,0,insertPlugHeight/2])
					cylinder(h=insertPlugHeight,r1=insertPlugRadius+tolerance,r2=0,center=true,$fn=100);
				translate([0,0,-insertPlugHeight/2+0.02])
					cylinder(h=insertPlugHeight,r=insertPlugRadius+tolerance,center=true,$fn=100);
			}
		}
	}
}
// Now draw insert and put plug on top
module insert() {
	translate([0,0,-insertLength/2])
		cylinder(h=insertLength,r=insertRadius,center=true,$fn=100);
	translate([0,0,insertPlugHeight/2])
		cylinder(h=insertPlugHeight,r1=insertPlugRadius,r2=0,center=true,$fn=100);
}


support();
translate([supportWidth/2+insertRadius+10,0,insertLength])
	insert();
