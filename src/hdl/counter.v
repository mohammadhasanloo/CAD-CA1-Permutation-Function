`timescale 1ns/1ns
module counter #(parameter WIDTH = 32)(
    input clk, 
    input rst, 
    input inc,
    input init,
    output [WIDTH-1:0] out,
    output reg one_co,
    output co
);

    reg [WIDTH-1:0] counter;
    always @(posedge clk or posedge rst) begin
        if(rst) begin 
            counter <= 0;
            one_co <= 0;
	  end else if(init) begin
	        counter <= 0; 
                one_co <= 0;
        end else if(inc) begin
            counter <= counter + 1;
            one_co <= 1;
        end
    end 
    assign out = counter;
    assign co = out == 64;
endmodule