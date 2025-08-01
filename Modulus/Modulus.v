module Modulus
(
    input [3:0] Dividend, 
    input [3:0] Divisor,
    output reg [3:0] Modulus
);

always @(*) begin
    if (Divisor != 0) begin
        Modulus = Dividend % Divisor;
    end else begin
        Modulus = 0;
    end
end

endmodule
