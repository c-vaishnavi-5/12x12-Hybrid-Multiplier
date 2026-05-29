module HybridArrayMul (
    input [11:0] A, B,
    output [23:0] Prod
);
    wire [11:0] p[11:0]; //partial products
    genvar g, h;
    generate
        for(g = 0; g < 12; g=g+1) begin
            for(h = 0; h < 12; h=h+1) begin
                and a(p[g][h], A[h], B[g]);
            end
        end
    endgenerate

    assign Prod[0] = p[0][0];
    wire [10:1] couts;
    wire [11:1] sums[10:1];

    CSA_nbit #(.N(12)) CSA0(.A({1'b0,p[0][11:1]}), .B(p[1]), .C(12'd0), .Sum({sums[1],Prod[1]}), .Cout(couts[1]));

    //generating CSA1 to CSA5
    genvar j;
    generate
        for(j = 2; j<6; j=j+1) begin
            CSA_nbit #(.N(12)) CSA1to5(.A({couts[j-1],sums[j-1]}), .B(p[j]), .C(12'd0), .Sum({sums[j],Prod[j]}), .Cout(couts[j]));
        end
    endgenerate

    //generating CSLA6 to CSLA10
    genvar i;
    generate
        for(i = 6; i < 11; i=i+1) begin
            CSelectA_M_N #(.M(12), .N(4)) CSLA(.A({couts[i-1],sums[i-1]}), .B(p[i]), .Sum({sums[i],Prod[i]}), .Cout(couts[i]));
        end
    endgenerate

    CSelectA_M_N #(.M(12), .N(4)) CSLA11(.A({couts[10], sums[10]}), .B(p[11]), .Sum(Prod[22:11]), .Cout(Prod[23]));

endmodule
