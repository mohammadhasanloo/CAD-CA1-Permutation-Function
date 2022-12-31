`timescale 1ns/1ns
module permutation_DP #(parameter WIDTH = 25)(
    input clk, rst, input_sel, permutation_sel, init_c, inc_c, ld_x,
    input[WIDTH-1:0] permutation_in,
    output reg[WIDTH-1:0] result,
    output one_co,
    output co
);
    wire[WIDTH-1:0] permutation_out;
    wire[WIDTH-1:0] xreg_out;
    wire[4:0] out_c;
    wire[WIDTH-1:0] mux_out;

    counter counter64(.clk(clk), .rst(rst), .inc(inc_c), .init(init_c), .out(out_c), .one_co(one_co), .co(co));
    register xreg(.clk(clk), .rst(rst), .ld(ld_x), .in(mux_out), .out(xreg_out));
    permutation_function permutation25bits(.in(xreg_out), .out(permutation_out));
    mux mux2to1(.input_sel(input_sel), .permutation_sel(permutation_sel),
     .circuit_input(permutation_in), .permutation_res(permutation_out), .out(mux_out));

    always@ (xreg_out) begin
        result <= xreg_out;

    end    

endmodule