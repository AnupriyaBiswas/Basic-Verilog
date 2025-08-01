`timescale 1ns / 1ns

module full_adder(
    input A, 
    input B, 
    input Cin, 
    output Sum, 
    output Cout
);

assign Sum = A ^ B ^ Cin;
assign Cout = (A & B) | (B & Cin) | (A & Cin);

endmodule
