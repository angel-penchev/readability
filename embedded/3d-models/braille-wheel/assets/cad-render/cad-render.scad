dot_h=0.2;
dot_d=1.5;
c_to_c=2.5;
s=16;
ew=2*c_to_c;
eh=c_to_c;
c_r=ew*s/PI;
res=100;

dots=[0,0,0,0,0,1,0,1,0,0,1,1,1,0,0,1,0,1,1,1,0,1,1,1];

echo("Cylinder with edge: ",ew," and height: ",eh, " and radius: ",c_r);
echo("Sphere with r=",dot_d);

module ring(){
	intersection(){
		translate([-c_r,-eh,0]){cube([2*c_r,eh,c_r]);}
		rotate([90,0,0]){
			union(){
				cylinder($fn=s,r=c_r,h=eh);
				for(a=[0:16]){
					rotate([0,0,a*(360/s)+(360/s)/2]){
						translate([c_r-dot_d/2-dot_h,0,eh/2]){
							if(dots[a*3]==1){
								translate([0,c_to_c,0]){
									sphere($fn=res,d=dot_d);    
								}
							}
										
							if(dots[a*3+1]==1){sphere($fn=res,d=dot_d);} 

							if(dots[a*3+2]==1){
								translate([0,-c_to_c,0]){
									sphere($fn=res,d=dot_d);    
								}
							}
						}     
					}
				}      
			}      
		}
	}
}


rotate([0,180/s,0]){ring();}
//translate([0,eh,0]){rotate([0,1*360/s,0]){ring();}};
