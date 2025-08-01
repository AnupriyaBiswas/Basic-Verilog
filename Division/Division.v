module Division
(
    input [3:0] Dividend, 
    input [3:0] Divisor,
    output reg [3:0] Quotient,
    output reg [3:0] Remainder
);

always @(*) begin
    if (Divisor != 0) begin
        Quotient = Dividend / Divisor;
        Remainder = Dividend % Divisor;
    end else begin
        Quotient = 0;
        Remainder = 0;
    end
end

endmodule
