/* **********************************************************************
*** Modules in this file
*** dim_lumber(dims,displayname)
*** roundBox(x,y,z,r)
*** module capsule(z,r)
*** module translate_children()
*** module roundedPlate(x,y,rad)
**************************************************************************** */

// use <common_modules.scad>
x=20;
y=40;
z=50;
r=5;

translate([0,0,0])dim_lumber([x,y,z],"Lumber");

translate([25,0,0])roundBox(x,y,z,r,"R Box");

translate([50,0,0]) capsule(y,r, "Capsule Demo");

translate([75,0,0]) roundedPlate(x,y,r, "Rounded Plate demo");

translate([100,0,0])hull(){translate_children(){
    capsule(z,r,"Child 1");
    translate([x-(r*2),0,0])capsule(z,r,"Child 2");
    translate([0,y-(r*2),0])capsule(z,r,"Child 3");
    translate([x-(r*2),y-(r*2),0])capsule(z,r,"Child 4");
    
    }
    
}


// Modules are below /////////////////////////////////////////

module dim_lumber(dims,displayname){
    echo ("Cut list: ",displayname,dims);
    cube(dims);
}

module roundBox(x,y,z,r,displayName="Unk")
{
    echo ("Round Box: ",displayName,x,y,z,r);
    
    hull(){
    capsule(z,r,displayName);
    translate([x-(r*2),0,0])capsule(z,r,displayName);
    translate([0,y-(r*2),0])capsule(z,r,displayName);
    translate([x-(r*2),y-(r*2),0])capsule(z,r,displayName);
    }
    
}


module capsule(z,r,displayName="Unk")
{
    echo ("Capsule: ",displayName,z,r);
    
    translate([r,r,r])cylinder(z-(2*r),r,r);    
    translate([r,r,r])sphere(r);
    translate([r,r,z-r])sphere(r);
    
    
}

module translate_children()
{
    
    
    for(i=[0:$children-1])
    {
        translate([i*10,0,i*5])children(i);
    }
    
}

module roundedPlate(x,y,rad,displayName="Unk")
{
    echo ("Round Plate: ",displayName,x,y,rad);
    hull(){
    translate([rad,rad,0])circle(rad);
    translate([x-rad,rad,0])circle(rad);
    translate([x-rad,y-rad,0])circle(rad);
    translate([rad,y-rad,0])circle(rad);
    }
}

module drawBezelBox(is_x,is_y,is_total,is_r,bz_x,bz_y,bz_z,bz_r,Name="unknown"){
    
    union(){
    linear_extrude(bz_z)roundedPlate(bz_x,bz_y,bz_r,Name);
    translate([(bz_x-is_x)/2,(bz_y-is_y)/2,bz_z])linear_extrude(is_total-bz_z)roundedPlate(is_x,is_y,is_r,Name);   
    }
    
}

module drawBezelBoxCutout(is_x,is_y,is_total,is_r,bz_x,bz_y,bz_z,bz_r,Name="unknown"){
     union(){
   // linear_extrude(bz_z)roundedPlate(bz_x,bz_y,bz_r,Name);
    translate([(bz_x-is_x)/2,(bz_y-is_y)/2,-1])linear_extrude(2+is_total-bz_z)roundedPlate(is_x,is_y,is_r,Name);   
    }
}

module roundedHollowBox(od_x,od_y,od_z,od_r,wall_thick){
   
    difference(){
    linear_extrude(od_z)roundedPlate(od_x,od_y,od_r);
    
    translate([wall_thick,wall_thick,wall_thick])linear_extrude(1+od_z-wall_thick)roundedPlate(od_x-wall_thick*2,od_y-wall_thick*2,od_r);
    }
    
}
