module RCA_nBit #(parameter N = 8)(
    input [N-1:0] A, B,
    input Cin,
    output [N-1:0] Sum,
    output Cout
);
    wire [N-2:0] carry;

    FullAdder FA0(.sum(Sum[0]), .cout(carry[0]), .a(A[0]), .b(B[0]), .cin(Cin));

    genvar i;
    generate
        for (i=1; i<N-1; i=i+1) begin
            FullAdder FA(.sum(Sum[i]), .cout(carry[i]), .a(A[i]), .b(B[i]), .cin(carry[i-1]));
        end
    endgenerate

    FullAdder FAN(.sum(Sum[N-1]), .cout(Cout), .a(A[N-1]), .b(B[N-1]), .cin(carry[N-2]));

endmodule
