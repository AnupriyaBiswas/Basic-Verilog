`include "Reset.v"

module Reset_tb;

    reg A, Rst, clock;
    wire Q;

    Reset uut (
        .A(A),
        .Rst(Rst),
        .clock(clock),
        .Q(Q)
    );    
    always #5 clock = ~clock;
    
    initial begin
        $dumpfile("Reset_tb.vcd");
        $dumpvars(0, Reset_tb);
        
        $display("A\tRst\tclock\tQ");
        $monitor("%b\t%b\t%b\t%b", A, Rst, clock, Q);

        clock = 0;

        A = 0;        Rst = 0;
        #10;

        Rst = 1;
        #10;

        A = 1;        Rst = 0;        
        #10;

        Rst = 1;        
        #10;

        $display("Test complete");
        $finish;
    end
endmodule
