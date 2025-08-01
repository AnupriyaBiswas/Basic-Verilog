`timescale 1ns / 1ns
`include "full_adder.v"

module four_bit_adder #(parameter N = 4) (
    input [N-1:0] A, 
    input [N-1:0] B, 
    input Cin, 
    output [N-1:0] Sum, 
    output Cout
);

wire [N:0] carry;
assign carry[0] = Cin;

genvar i;
generate
    for (i = 0; i < N; i = i + 1) begin: adder_loop
        full_adder FA (
            .A(A[i]), 
            .B(B[i]), 
            .Cin(carry[i]), 
            .Sum(Sum[i]), 
            .Cout(carry[i+1])
        );
    end
endgenerate

assign Cout = carry[N];

endmodule
