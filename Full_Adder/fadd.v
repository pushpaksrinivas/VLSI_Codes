module fadd(input a,b,ci, output s,co);
    wire anot, w1, w2, w3, w4, c1, c2, c3;
    
    assign anot = ~(a);
    assign w1 = b^ci;
    assign w2 = ~w1;
    assign w3 = a&w2;
    assign w4 = anot&w1;
    assign s = w3|w4;
    
    assign c1 = a&ci;
    assign c2 = b&ci;
    assign c3 = a&b;
    assign co = c1|c2|c3;
endmodule
