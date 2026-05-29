module CSelectA_M_N #(parameter M = 16, N = 4)(
    input [M-1:0] A, B,
    output [M-1:0] Sum,
    output Cout
);
    localparam S = M/N;
    wire [S-1:0] StageCout;
    wire [1:0] StageCarry[S-1:1];
    wire [N-1:0] StageSum[S-1:1][1:0];

    //Stage N-1:0
    RCA_nBit #(.N(N)) RCA0(.A(A[N-1:0]), .B(B[N-1:0]), .Cin(1'b0), .Sum(Sum[N-1:0]), .Cout(StageCout[0]));

    //Stages M-1:N
    genvar i;
    generate
        for(i = 1; i < S; i=i+1) begin
            RCA_nBit #(.N(N)) RCAS0(.A(A[(N*(i+1))-1:N*i]), .B(B[(N*(i+1))-1:N*i]), .Cin(1'b0), .Sum(StageSum[i][0]), .Cout(StageCarry[i][0]));
            RCA_nBit #(.N(N)) RCAS1(.A(A[(N*(i+1))-1:N*i]), .B(B[(N*(i+1))-1:N*i]), .Cin(1'b1), .Sum(StageSum[i][1]), .Cout(StageCarry[i][1]));
            carryMUX CMS(.u(StageCarry[i][1]), .d(StageCarry[i][0]), .sel(StageCout[i-1]), .y(StageCout[i]));
            sumMUX #(.N(N)) SMS(.U(StageSum[i][1]), .D(StageSum[i][0]), .Sel(StageCout[i-1]), .Y(Sum[(N*(i+1))-1:N*i]));
        end
    endgenerate

    assign Cout = StageCout[S-1];

endmodule
