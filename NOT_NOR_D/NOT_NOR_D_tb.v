`include "NOT_NOR_D.v"

module NOT_NOR_D_tb;

    reg A, Rst, clock;
    wire Q;

    NOT_NOR_D uut (
        .A(A),
        .Rst(Rst),
        .clock(clock),
        .Q(Q)
    );
    
    always #5 clock = ~clock;
    
    initial begin
        $dumpfile("NOT_NOR_D_tb.vcd");
        $dumpvars(0, NOT_NOR_D_tb);
        
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
