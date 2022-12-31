`timescale  1ns/1ns
module permutation_top #(parameter WIDTH = 25)(
    input clk, rst, start,
    input[WIDTH-1:0] in,
    output ready, 
    output one_co,
    output co,
    output[WIDTH-1:0] out
);
wire input_sel, permutation_sel, init_c, inc_c, ld_x;

    permutation_DP dp(.clk(clk), .rst(rst), .input_sel(input_sel), .permutation_sel(permutation_sel), .init_c(init_c),
     .inc_c(inc_c), .ld_x(ld_x), .permutation_in(in), .result(out), .one_co(one_co), .co(co));

    permutation_CU du(.clk(clk), .rst(rst), .start(start), .co(co), .ready(ready), .input_sel(input_sel),
     .permutation_sel(permutation_sel), .init_c(init_c), .inc_c(inc_c), .ld_x(ld_x));

endmodule