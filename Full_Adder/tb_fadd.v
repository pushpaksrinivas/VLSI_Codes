module tb_fadd;

//reg a,b;  remove the comments for testing the individual module
reg ci=0;
    reg [3:0] ba=4'h0,bb=4'h0;
wire c0;
wire [3:0] sout;
	//wire s;  this is for testing the full adder(fadd) individual module

	mfadd uut(.a(ba), .b(bb), .ci(ci), .s(sout), .c0(c0));
	// fadd fuut(.a(a), .b(b), .ci(ci), .s(s), .co(c0));  this is for testing the full adder(fadd) individual module
	
	initial begin

	#10; // for first 10n sec
ba=4'h1;bb=4'h1;   // a=0;b=0;ci=0;
        #10;
ba=4'h2;bb=4'h3;	// a=0;b=1;ci=0;
        #10;
ba=4'h4;bb=4'h4;	// a=1;b=0;ci=0;
        #10;
ba=4'h5;bb=4'h3;	// a=0;b=1;ci=1;
        #10;
ba=4'h1;bb=4'h6;	// a=1;b=0;ci=1;
        #10;
ba=4'h0;bb=4'h1;	// a=1;b=1;ci=0;
        #10;
ba=4'h7;bb=4'h2;	// a=1;b=1;ci=1;
	$finish;            // we ca also add more cases for better testing 
	end

endmodule

