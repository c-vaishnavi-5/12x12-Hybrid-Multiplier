module sumMUX #(parameter N = 4) (
    input [N-1:0] U, D,
    input Sel,
    output [N-1:0] Y
);
    assign Y = Sel ? U : D;

endmodule

module carryMUX (
    input u, d, sel,
    output y
);
    assign y = sel ? u : d;

endmodule
