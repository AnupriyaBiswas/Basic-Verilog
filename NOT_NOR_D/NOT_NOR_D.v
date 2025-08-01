module NOT_NOR_D (
    input A, 
    input Rst, 
    input clock, 
    output reg Q
);

always @(posedge clock or posedge Rst) begin
    if (Rst)
        Q <= 1'b0;
    else
        Q <= A;
end

endmodule

