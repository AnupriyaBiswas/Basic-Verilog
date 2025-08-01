`timescale 1ns / 1ns
`include "half_adder.v"

module half_adder_tb;

    reg A, B;
    wire Sum, Cout;

    // Instantiate the full_adder module
    full_adder uut (
        .A(A),
        .B(B),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        // Generate waveform dump file
        $dumpfile("half_adder_tb.vcd");
        $dumpvars(0, half_adder_tb);

        $display("Time\tA\tB\tSum\tCout");
        $monitor("%g\t%b\t%b\t%b\t%b", $time, A, B, Sum, Cout);

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
