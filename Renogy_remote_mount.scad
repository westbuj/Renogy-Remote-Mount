//mount for renogy
use <common_modules.scad>

$fn=125;

bm_back_x=56;
bm_back_y=96;
bm_bezel_z=2.81;
bm_bezel_x=60.5;
bm_bezel_y=100;
bm_tot_z=60;//actual is 17.5;

inv_back_x=43.5;
inv_back_y=73;
inv_bezel_z=3.25;
inv_bezel_x=60.5;
inv_bezel_y=100;
inv_tot_z=31+bm_bezel_z;//actual is 28.2;
inv_hole_y_inset=8;


mount_x=inv_bezel_x;
mount_y=bm_bezel_y;
mount_bezel=4;
//mount_y_bezel=5;
mount_bezel_r=5;
mount_z= inv_tot_z;//27;//actual is 16;

din_x=51.6+2;
din_y=177.8+6;
din_r=3;
din_z=35;
din_wall=6;


//mount_z=12;
//mount_bezel=5;


difference(){
//block
translate([-mount_bezel,-mount_bezel,bm_bezel_z])color([.2,.3,.5])linear_extrude(mount_z)roundedPlate(mount_x+2*mount_bezel,mount_y+2*mount_bezel,mount_bezel_r);

translate([0,0,0])InvRemote();
translate([25,-10,mount_z-10-mount_bezel_r])cube([10.5,40,10.5]);
    
translate([inv_bezel_x/2-13,inv_bezel_y/2-25,-5])cylinder(55,3/2,3/2);
translate([inv_bezel_x/2-13,inv_bezel_y/2+25,-5])cylinder(55,3/2,3/2);
translate([inv_bezel_x/2+13,inv_bezel_y/2-25,-5])cylinder(55,3/2,3/2);
translate([inv_bezel_x/2+13,inv_bezel_y/2+25,-5])cylinder(55,3/2,3/2);
}





//translate([0,0,0])color([0,0,1])dinTemplate();

//translate([100,0,0])color([0,1,0])wholeAssembly();

//translate([200,0,0])color([1,0,0])mountTemplate();

module mountTemplate(){
    translate([mount_bezel,mount_bezel,0])
   difference(){
    
    translate([-mount_bezel,-mount_bezel,inv_bezel_z+1])color([.2,.2,.6])linear_extrude(3)roundedPlate(mount_bezel*2+bm_bezel_x,mount_bezel*2+inv_bezel_y+bm_bezel_y,4);
    color([0,.5,.5])battMon();
    translate([0,bm_bezel_y,0])color([.5,.5,0])InvRemote();
    translate([0,0,10])linear_extrude(25)roundedPlate(bm_bezel_x,inv_bezel_y+bm_bezel_y,2);
   }
    

    
}
module dinTemplate(){
    //mount_din
difference(){
translate([(mount_bezel*2+bm_bezel_x-din_x)/2,(mount_bezel*2+inv_bezel_y+bm_bezel_y-din_y)/2,inv_bezel_z+mount_z])linear_extrude(3)roundedPlate(din_x,din_y,din_r);
translate([din_wall+(mount_bezel*2+bm_bezel_x-din_x)/2,din_wall+(mount_bezel*2+inv_bezel_y+bm_bezel_y-din_y)/2,inv_bezel_z+mount_z-1])linear_extrude(din_z+5)roundedPlate(din_x-din_wall*2,din_y-din_wall*2,din_r);
}
    
}


module wholeAssembly(){
union(){

/*
difference(){
translate([(mount_bezel*2+bm_bezel_x-din_x)/2,(mount_bezel*2+inv_bezel_y+bm_bezel_y-din_y)/2,inv_bezel_z+mount_z])linear_extrude(din_z)roundedPlate(din_x,din_y,din_r);
translate([din_wall+(mount_bezel*2+bm_bezel_x-din_x)/2,din_wall+(mount_bezel*2+inv_bezel_y+bm_bezel_y-din_y)/2,inv_bezel_z+mount_z-1])linear_extrude(din_z+5)roundedPlate(din_x-din_wall*2,din_y-din_wall*2,din_r);
    
}
*/

//translate([0,0,0])linear_extrude(1)roundedPlate(4,4,2);

/*

difference(){
translate([0,0,mount_z+1.5])linear_extrude(3)roundedPlate(mount_bezel*2+bm_bezel_x,mount_bezel*2+inv_bezel_y+bm_bezel_y,4);
    translate([din_wall+(mount_bezel*2+bm_bezel_x-din_x)/2,din_wall+(mount_bezel*2+inv_bezel_y+bm_bezel_y-din_y)/2,inv_bezel_z+mount_z-3])linear_extrude(din_z+5)roundedPlate(din_x-din_wall*2,din_y-din_wall*2,din_r);
    
}

*/

//translate([inv_bezel_x/2,inv_bezel_y-inv_hole_y_inset,-1])cylinder(15,5.5/2,5.5/2);

translate([mount_bezel,mount_bezel,0])
difference(){
    
    translate([-mount_bezel,-mount_bezel,inv_bezel_z+1])color([.2,.2,.6])mount();
    color([0,.5,.5])battMon();
    translate([0,bm_bezel_y,0])color([.5,.5,0])InvRemote();
    translate([0,0,10])linear_extrude(25)roundedPlate(bm_bezel_x,inv_bezel_y+bm_bezel_y,2);
   // translate([inv_bezel_x/2,inv_bezel_y-inv_hole_y_inset,-1])cylinder(15,5.5/2,5.5/2);
    
    //translate([din_wall+(mount_bezel*2+bm_bezel_x-din_x)/2,din_wall+(mount_bezel*2+inv_bezel_y+bm_bezel_y-din_y)/2,inv_bezel_z+mount_z-15])linear_extrude(din_z+5)roundedPlate(din_x-din_wall*2,din_y-din_wall*2,din_r);

}
}
} //end wholeassembble

module mount(){
    linear_extrude(mount_z)roundedPlate(mount_bezel*2+bm_bezel_x,mount_bezel*2+inv_bezel_y+bm_bezel_y,4);
    
}

module battMon(){
    
    union(){
    linear_extrude(bm_bezel_z)roundedPlate(bm_bezel_x,bm_bezel_y,4);
    linear_extrude(bm_tot_z-bm_bezel_z)translate([(bm_bezel_x-bm_back_x)/2,(bm_bezel_y-bm_back_y)/2,bm_bezel_z])roundedPlate(bm_back_x,bm_back_y,4);
    }
    
}

module InvRemote(){
    
    //translate([inv_bezel_x/2,inv_hole_y_inset,-1])cylinder(15,5.5/2,5.5/2);
    union(){
        
    //difference(){
        linear_extrude(inv_bezel_z)roundedPlate(inv_bezel_x,inv_bezel_y,4);
        translate([inv_bezel_x/2,inv_hole_y_inset,-5])cylinder(25,3/2,3/2);
        translate([inv_bezel_x/2,inv_bezel_y-inv_hole_y_inset,-5])cylinder(25,3/2,3/2);
 //   }
    linear_extrude(inv_tot_z-inv_bezel_z)translate([(inv_bezel_x-inv_back_x)/2,(inv_bezel_y-inv_back_y)/2,inv_bezel_z])roundedPlate(inv_back_x,inv_back_y,4);
    }
    
}



