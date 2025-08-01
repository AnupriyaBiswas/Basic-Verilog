`include "multiplication.v"

module multiplication_tb;

    reg [3:0] A, B;
    wire [7:0] Product;

    // Instantiate the multiplier
    multiplication #() uut (
        .A(A),
        .B(B),
        .Product(Product)
    );

    initial begin
        $dumpfile("multiplication_tb.vcd");
        $dumpvars(0, multiplication_tb);

        $display("Time\tA\tB\tProduct");
        $monitor("%g\t%b\t%b\t%b", $time, A, B, Product);

        // Test Cases
        A = 4'b0011; B = 4'b0010;
        #10;
        A = 4'b0101; B = 4'b0011;
        #10;
        A = 4'b1111; B = 4'b0001;
        #10;
        A = 4'b1001; B = 4'b0010;
        #10;
        A = 4'b0110; B = 4'b0110;
        #10;

        $display("Test complete");
        $finish;
    end

endmodule
