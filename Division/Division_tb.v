`include "Division.v"

module Division_tb;

    reg [3:0] Dividend, Divisor;
    wire [3:0] Quotient, Remainder;
    
    Division uut (
        .Dividend(Dividend),
        .Divisor(Divisor),
        .Quotient(Quotient),
        .Remainder(Remainder)
    );

    initial begin
        $dumpfile("Division_tb.vcd");
        $dumpvars(0, Division_tb);

        $display("Time\tDividend\tDivisor\tQuotient\tRemainder");
        $monitor("%g\t%b\t\t%b\t%b\t\t%b", $time, Dividend, Divisor, Quotient, Remainder);

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
