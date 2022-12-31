`timescale 1ns/1ns
module mux #(parameter WIDTH = 25)(
    input input_sel,
    input permutation_sel,
    input[WIDTH-1:0] circuit_input,
    input[WIDTH-1:0] permutation_res,
    output[WIDTH-1:0] out
);

    assign out = permutation_sel ? permutation_res : input_sel ? circuit_input : 0;

endmodule