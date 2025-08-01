`include "Modulus.v"

module Modulus_tb;

    reg [3:0] Dividend, Divisor;
    wire [3:0] Modulus;
    
    Modulus uut (
        .Dividend(Dividend),
        .Divisor(Divisor),
        .Modulus(Modulus)
    );

    initial begin
        $dumpfile("Modulus_tb.vcd");
        $dumpvars(0, Modulus_tb);

        $display("Time\tDividend\tDivisor\tModulus");
        $monitor("%g\t%b\t\t%b\t%b", $time, Dividend, Divisor, Modulus);

        Dividend = 4'b1000; Divisor = 4'b0010;
        #10;
        Dividend = 4'b0111; Divisor = 4'b0011;
        #10;
        Dividend = 4'b1111; Divisor = 4'b0100;
        #10;
        Dividend = 4'b1001; Divisor = 4'b0011;
        #10;
        Dividend = 4'b0110; Divisor = 4'b0000;
        #10;

        $display("Test complete");
        $finish;
    end

endmodule
