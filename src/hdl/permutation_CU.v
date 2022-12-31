`timescale 1ns/1ns
module permutation_CU (
    input clk, rst, start, co,
    output reg ready, input_sel, permutation_sel, init_c, inc_c, ld_x
);
    parameter[2:0] idle=0, init=1, load_input=2, load_permutation=3, flush=4;
    reg[2:0] pstate, nstate;

    always@ (start, co, pstate) begin

        nstate = 3'b0;
        {ready, input_sel, permutation_sel, init_c, inc_c, ld_x} = 6'b0;

        case(pstate)
            idle            :begin nstate = start ? init : idle; ready=1'b1; end
            init            :begin nstate = load_input; init_c=1'b1; end
            load_input      :begin nstate = load_permutation; ld_x=1'b1; input_sel=1'b1; end
            load_permutation:begin nstate = co ? idle : flush; inc_c = 1'b1; ld_x=1'b1; permutation_sel=1'b1; end
	    flush	    :begin nstate = load_input; end

        endcase

    end

    always@ (posedge clk, posedge rst) begin
        if(rst)
            pstate <= idle;
        else
            pstate <= nstate;
    end        

endmodule