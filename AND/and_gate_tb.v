`timescale 1ns / 1ns
`include "and.v"

module and_gate_tb;

reg A, B;
wire Y;

and_gate uut (
    .A(A), 
    .B(B), 
    .Y(Y)
);

initial begin
    $dumpfile("and_gate_tb.vcd");
    $dumpvars(0, and_gate_tb);

    $display("Time\tA\tB\tY");
    $monitor("%g\t%b\t%b\t%b", $time, A, B, Y);

    A = 0; 
    B = 0;
    #20;

    A = 0; 
    B = 1;
    #20;

    A = 1; 
    B = 0;
    #20;

    A = 1; 
    B = 1;
    #20;

    $display("Test complete");
    $finish;
end
endmodule
