`timescale 1ns / 1ns
`include "four_bit_adder.v"

module four_bit_adder_tb;

parameter N = 4;

reg [N-1:0] A, B;
reg Cin;
wire [N-1:0] Sum;
wire Cout;

four_bit_adder #(N) uut (
    .A(A), 
    .B(B), 
    .Cin(Cin), 
    .Sum(Sum), 
    .Cout(Cout)
);

initial begin
    $dumpfile("four_bit_adder_tb.vcd");
    $dumpvars(0, four_bit_adder_tb);

    $display("Time\tA\tB\tCin\tSum\tCout");
    $monitor("%g\t%b\t%b\t%b\t%b", $time, A, B, Cin, Sum, Cout);

    A = 4'b0000; B = 4'b0000; Cin = 0;
    #10;

    A = 4'b0101; B = 4'b0011; Cin = 0;
    #10;

    A = 4'b0111; B = 4'b0001; Cin = 1;
    #10;

    A = 4'b1111; B = 4'b0001; Cin = 0;
    #10;

    A = 4'b1010; B = 4'b1100; Cin = 1;
    #10;

    $display("Test complete");
    $finish;
end

endmodule
