module HybridArrayMul_tb;

    reg [11:0] A, B;   // 12-bit inputs
    wire [23:0] Prod;  // 24-bit product output

    // Instantiate the multiplier module
    HybridArrayMul uut (
        .A(A),
        .B(B),
        .Prod(Prod)
    );

    initial begin
        // Test Case 1: Small values
        A = 12'b000000000001;  // 1
        B = 12'b000000000001;  // 1
        #10;
        $display("TC1: A = %d, B = %d, Prod = %d", A, B, Prod);

        // Test Case 2: Medium values
        A = 12'b000000111111;  // 63
        B = 12'b000000000101;  // 5
        #10;
        $display("TC2: A = %d, B = %d, Prod = %d", A, B, Prod);

        // Test Case 3: Maximum values
        A = 12'b111111111111;  // 4095
        B = 12'b111111111111;  // 4095
        #10;
        $display("TC3: A = %d, B = %d, Prod = %d", A, B, Prod);

        // Test Case 4: One operand is zero
        A = 12'b000000000000;  // 0
        B = 12'b101010101010;  // Random number
        #10;
        $display("TC4: A = %d, B = %d, Prod = %d", A, B, Prod);

        // Test Case 5: One operand is maximum
        A = 12'b111111111111;  // 4095
        B = 12'b000000000001;  // 1
        #10;
        $display("TC5: A = %d, B = %d, Prod = %d", A, B, Prod);

        // Test Case 6: Random test
        A = 12'b101010101010;  // Random pattern
        B = 12'b010101010101;  // Random pattern
        #10;
        $display("TC6: A = %d, B = %d, Prod = %d", A, B, Prod);

        $stop;
    end

endmodule
