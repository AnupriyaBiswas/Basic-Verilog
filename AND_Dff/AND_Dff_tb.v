`include "AND_Dff.v"

module AND_Dff_tb;

    reg A, B, C;
    wire Q;

    AND_Dff uut (
        .A(A),
        .B(B),
        .C(C),
        .Q(Q)
    );

    initial begin
        $dumpfile("AND_Dff_tb.vcd");
        $dumpvars(0, AND_Dff_tb);
        
        $display("A\tB\tC\tQ");
        $monitor("%b\t%b\t%b\t%b", A, B, C, Q);

        A = 0;        B = 0;        C = 0;
        #10;

        C = 1;
        #10;

        B = 1;        C = 0;        
        #10;

        C = 1;        
        #10;
        
        A = 1;        B = 0;        C = 0;
        #10;

        C = 1;
        #10;

        B = 1;        C = 0;        
        #10;

        C = 1;        
        #10;

        $display("Test complete");
        $finish;
    end

endmodule
