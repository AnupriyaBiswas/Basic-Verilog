module D_FlipFlop (
    input A, 
    input B, 
    input clock, 
    output reg Q
);
reg internal;
always @(posedge clock) begin
    internal <= A;
end
always @(posedge internal) begin
    Q <= B;
end
endmodule
