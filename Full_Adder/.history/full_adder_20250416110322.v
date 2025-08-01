module full_adder (
    input wire A,
    input wire B,
    input wire Cin,
    output wire Sum,
    output wire Cout
);

    wire AxorB, AandB, AxorBandCin;

    xor (AxorB, A, B);
    and (AandB, A, B);
    xor (Sum, AxorB, Cin);
    and (AxorBandCin, AxorB, Cin);
    or  (Cout, AandB, AxorBandCin);

endmodule

