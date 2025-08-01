module Reset (
    input A, 
    input Rst, 
    input clock, 
    output reg Q
);

always @(posedge clock or posedge Rst) begin
    Q <= A;
end

endmodule

