module AND_Dff (
    input A, 
    input B, 
    input C, 
    output reg Q
);

and(clock, B, C);

always @(posedge clock) begin
    Q <= A;
end

endmodule

