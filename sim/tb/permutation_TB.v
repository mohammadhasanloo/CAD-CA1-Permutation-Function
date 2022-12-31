`timescale 1ns/1ns
module permutation_TB #(parameter WIDTH = 25)();
    reg clk = 0;
    reg rst = 0;
    reg start = 0;
    reg [WIDTH-1:0] data_in;
    wire ready, co;
    wire [WIDTH-1:0] data_out;
	
    reg [8*18:0]input_file_name = "./file/input_i.txt";
    reg [8*19:0]output_file_name = "./file/output_i.txt";

    permutation_top UUT(.clk(clk), .rst(rst), .start(start), .in(data_in), .ready(ready), .co(co), .out(data_out));

    integer input_file, output_file, i, testscounts=3, k;

    always #(5) clk = ~clk;

    initial begin
		for(i=0;i<testscounts;i=i+1) begin
		    $sformat(input_file_name, "./file/input_%0d.in", i);
                    $sformat(output_file_name, "./file/output_%0d.txt", i);
			
			rst = 1;
			#25
			rst = 0;
			//#20
			start = 1;
			#25
			start = 0;
        
			input_file = $fopen(input_file_name, "r");
			output_file = $fopen(output_file_name, "w");
			while (!$feof(input_file) && co != 1) begin
				k = $fscanf(input_file, "%b\n", data_in);
				#30
				$fwrite(output_file, "%b\n", data_out);
				$display("----\n%b\n%b\n----\n", data_in, data_out);
			end
			$fclose(input_file);
			$fclose(output_file);
		end
        #30
        $stop;
    end
endmodule