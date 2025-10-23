//multi bit adder (this is 4bit adder using instances)

module mfadd(
input [3:0] a,b,cint,
input ci,
output [3:0] s,
output c0);


    fadd ints0 (.a(a[0]), .b(b[0]), .ci(ci), .s(s[0]), .co(cint[0]));
    fadd ints1 (.a(a[1]), .b(b[1]), .ci(cint[0]), .s(s[1]), .co(cint[1]));
    fadd ints2 (.a(a[2]), .b(b[2]), .ci(cint[1]), .s(s[2]), .co(cint[2]));
    fadd ints3 (.a(a[3]), .b(b[3]), .ci(cint[2]), .s(s[3]), .co(cint[3]));
    
    assign c0 = cint[3];
endmodule
