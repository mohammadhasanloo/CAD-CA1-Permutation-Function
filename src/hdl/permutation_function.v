`timescale 1ns/1ns
module permutation_function #(parameter WIDTH = 25)(
    input[WIDTH-1:0] in,
    output reg [WIDTH-1:0] out
    );
    
    integer i ,j, x, z, new_pos;
    
	always @(*) begin
      for (i=0;i<5;i=i+1) begin
	    z = (i+3)%5;
		for (j=0;j<5;j=j+1) begin
			x = (j+3)%5;
			new_pos = ((2*x)+(3*z))%5;
			if(new_pos==0) begin  
                out[24-(i+(5*2))] = in[24-((5*i)+j)];
            end else if(new_pos==1) begin
                out[24-(i+(5*3))] = in[24-((5*i)+j)];
            end else if(new_pos==2) begin
                out[24-(i+(5*4))] = in[24-((5*i)+j)];
            end else if(new_pos==3) begin 
                out[24-i] = in[24-((5*i)+j)];
            end else  begin
                out[24-(i+(5))] = in[24-((5*i)+j)];
			end
		end
	   end	
    end

endmodule