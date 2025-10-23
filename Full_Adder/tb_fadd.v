module tb_fadd;


reg ci=0;
    reg [3:0] ba=4'h0,bb=4'h0;
wire c0;
wire [3:0] sout;

mfadd uut(.a(ba), .b(bb), .ci(ci), .s(sout), .c0(c0));

	
	initial begin

	#10;
ba=4'h1;bb=4'h1;
        #10;
ba=4'h2;bb=4'h3;
        #10;
ba=4'h4;bb=4'h4;
        #10;
ba=4'h5;bb=4'h3;
        #10;
ba=4'h1;bb=4'h6;
        #10;
ba=4'h0;bb=4'h1;
        #10;
ba=4'h7;bb=4'h2;
	$finish;            // Quit the simulation
	end

endmodule

