`timescale 1ns / 1ns
`include "full_adder.v"

module full_adder_tb;

    reg A, B, Cin;
    wire Sum, Cout;

    // Instantiate the full_adder module
    full_adder uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        // Generate waveform dump file
        $dumpfile("full_adder_tb.vcd");
        $dumpvars(0, full_adder_tb);

        $display("Time\tA\tB\tCin\tSum\tCout");
        $monitor("%g\t%b\t%b\t%b\t%b\t%b", $time, A, B, Cin, Sum, Cout);

        A = 0; 
        B = 0; 
        Cin = 0; 
        #20;
        
        A = 0; 
        B = 0; 
        Cin = 1; 
        #20;
        
        A = 0; 
        B = 1; 
        Cin = 0; 
        #20;
        
        A = 0; 
        B = 1; 
        Cin = 1; 
        #20;
        
        A = 1; 
        B = 0; 
        Cin = 0; 
        #20;
        
        A = 1; 
        B = 0; 
        Cin = 1; 
        #20;
        
        A = 1; 
        B = 1; 
        Cin = 0; 
        #20;
        
        A = 1; 
        B = 1; 
        Cin = 1; 
        #20;

        $display("Test complete");
        $finish;
    end
endmodule
