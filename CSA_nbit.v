module CSA_nbit #(parameter N = 8) (
    input [N-1:0] A, B, C,
    output [N-1:0] Sum,
    output Cout
);
    wire [N-2:0] St;
    wire [N-1:0] Ct;

    FullAdder CSAU0(.a(A[0]), .b(B[0]), .cin(C[0]), .sum(Sum[0]), .cout(Ct[0]));

    genvar i;
    generate
        for (i = 1; i < N; i = i + 1)
            FullAdder CSAU(.a(A[i]), .b(B[i]), .cin(C[i]), .sum(St[i-1]), .cout(Ct[i]));
    endgenerate

    wire [N-1:0] finalout;
    RCA_nBit #(.N(12)) RCA_CSA(.A(Ct), .B({1'b0, St}), .Cin(1'b0), .Sum(finalout), .Cout());

    assign Cout = finalout[N-1];
    assign Sum[N-1:1] = finalout[N-2:0];

endmodule
