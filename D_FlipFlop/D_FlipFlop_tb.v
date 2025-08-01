`include "D_FlipFlop.v"

module D_FlipFlop_tb;

    reg A, B, clock;
    wire Q;

    D_FlipFlop uut (
        .A(A),
        .B(B),
        .clock(clock),
        .Q(Q)
    );
    always #5 clock = ~clock;

    initial begin
        $dumpfile("D_FlipFlop_tb.vcd");
        $dumpvars(0, D_FlipFlop_tb);
        
        $display("Clock\tA\tB\tQ");
        $monitor("%b\t%b\t%b\t%b", clock, A, B, Q);

        clock = 0;

        A = 0;        B = 0;        
        #10;

        A = 1;        B = 0;
        #10;

        A = 0;        B = 1;        
        #10;

        A = 1;        B = 1;        
        #10;
        
        $display("Test complete");
        $finish;
    end
