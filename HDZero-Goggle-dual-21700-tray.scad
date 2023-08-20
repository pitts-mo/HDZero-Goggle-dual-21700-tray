// HDZero Goggle dual 21700 tray
// 2023-07-23 -initial test print.
// 2023-08-19 -enhanced head facing side for improved comfort and reduced stress on HDZero battery straps.
// 2023-08-20 -add notes and format clean up.

//$fn=18;
$fn=90;

CellRad=21.4*0.5;
CellLen=71;
CablePath=12.5*0.5;


StrapWidth=26; // measured goggle strap = 26
StrapLength=80; // measured goggle strap = 84
StrapHeight=47; // measured goggle strap = 50

CaseRad=4*0.5;

HeadContourRad=30;

//cube([CellRad,StrapHight,StrapLength],true);

//rotate([0,90,0]) HeadContour();

rotate([0,90,0])
difference(){
    Tray();
    PackDiff();
    PackAccess();
    StrapPaths();
    HeadContour();
}



module PackDiff(){
    hull() {
        translate([0,+CellRad,0]) cylinder(CellLen,CellRad,CellRad,true);
        translate([0,-CellRad,0]) cylinder(CellLen,CellRad,CellRad,true);
    }
    translate([CellRad,0,CellLen*0.5]) sphere(CablePath);
}

module Tray() {
    hull(){
        translate([-CellRad,0,0]) Ring(CellRad*2+CaseRad,CellLen*0.5+CaseRad*4,CaseRad);
        translate([+CellRad,0,0]) Ring(CellRad*2-CaseRad*2,CellLen*0.5,CaseRad);
    }
}

module PackAccess() {
    hull(){
        //translate([-(CellRad+CaseRad*2),0,0]) Ring(CellRad*1,CellLen*0.5-CellRad,CaseRad);
        translate([0,0,0]) Ring(CellRad-CaseRad*1.1,CellLen*0.5-CaseRad*1.1,CaseRad);
        PackAccessHalf(+1);
        PackAccessHalf(-1);
    }
}

module PackAccessHalf(Shift) {
    translate([Shift*(CellRad-CaseRad*1),0,0]) Ring(CellRad*1.25+CaseRad*1,CellLen*0.5-CaseRad*0.125,CaseRad*0.125);
    translate([Shift*(CellRad),0,0]) Ring(CellRad*1.25+CaseRad*0.125,CellLen*0.5-CaseRad*0.125,CaseRad*0.125);
    translate([Shift*(CellRad+CaseRad*2),0,0]) Ring(CellRad*1.25,CellLen*0.5-CaseRad*2,CaseRad);
}

module StrapPaths() {
    hull(){
        translate([0,0,-(StrapLength*0.5+CaseRad)]) rotate([0,90,0]) Ring(StrapWidth*0.5,CellRad+CaseRad*2,CaseRad);
        translate([0,0,-(StrapLength*0.5+CaseRad*3)]) rotate([0,90,0]) Ring(StrapWidth*0.5,CellRad+CaseRad*2,CaseRad);
    }
    hull(){
        translate([0,0,+(StrapLength*0.5+CaseRad)]) rotate([0,90,0]) Ring(StrapWidth*0.5,CellRad+CaseRad*2,CaseRad);
        translate([0,0,+(StrapLength*0.5+CaseRad*3)]) rotate([0,90,0]) Ring(StrapWidth*0.5,CellRad+CaseRad*2,CaseRad);
    }
    hull(){
        translate([0,-(StrapHeight*0.5+CaseRad),0]) rotate([90,0,90]) Ring(StrapWidth*0.5,CellRad+CaseRad*2,CaseRad);
    }
    hull(){
        translate([0,+(StrapHeight*0.5+CaseRad),0]) rotate([90,0,90]) Ring(StrapWidth*0.5,CellRad+CaseRad*2,CaseRad);
    }
}


module Ring(RingY,RingZ,RingRad){
    translate([0,+RingY,+RingZ]) sphere(RingRad);
    translate([0,+RingY,-RingZ]) sphere(RingRad);
    translate([0,-RingY,+RingZ]) sphere(RingRad);
    translate([0,-RingY,-RingZ]) sphere(RingRad);
}

module HeadContour(){
translate([-(CellRad+HeadContourRad*0.95),0,0]) 
    hull(){
        sphere(HeadContourRad);
        translate([HeadContourRad*0.8,0,0]) cube([0.02,CellRad*7.5,CellLen*2.5],true);
    }    
}    