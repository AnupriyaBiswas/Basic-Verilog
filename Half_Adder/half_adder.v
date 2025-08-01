module full_adder (
    input wire A,
    input wire B,
    output wire Sum,
    output wire Cout
);

    xor (Sum, A, B);
    and (Cout, A, B);

endmodule

