// File: tb_comparator.v
// Exhaustive verification: tests ALL 256 combinations of two 4-bit numbers
// Cross-checks structural design against behavioral design

`timescale 1ns/1ps

module tb_comparator;

    reg [3:0] A, B;
    wire GT_s, EQ_s, LT_s;   // structural outputs
    wire GT_b, EQ_b, LT_b;   // behavioral outputs
    integer errors = 0;
    integer i, j;

    // Instantiate BOTH versions with the SAME inputs
    comparator_4bit_structural  u_struct (.A(A), .B(B), .GT(GT_s), .EQ(EQ_s), .LT(LT_s));
    comparator_4bit_behavioral  u_behav  (.A(A), .B(B), .GT(GT_b), .EQ(EQ_b), .LT(LT_b));

    initial begin
        $dumpfile("comparator.vcd");
        $dumpvars(0, tb_comparator);

        $display("==================================================");
        $display(" Exhaustive test: 16 x 16 = 256 combinations");
        $display("==================================================");

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                A = i;
                B = j;
                #5;   // let signals settle

                // Cross-check: structural result MUST match behavioral result
                if ({GT_s, EQ_s, LT_s} !== {GT_b, EQ_b, LT_b}) begin
                    $display("MISMATCH at A=%0d B=%0d : structural=%b%b%b  behavioral=%b%b%b",
                              A, B, GT_s, EQ_s, LT_s, GT_b, EQ_b, LT_b);
                    errors = errors + 1;
                end

                // Also sanity-check: exactly ONE of GT/EQ/LT should be 1, never zero, never two
                if ((GT_s + EQ_s + LT_s) != 1) begin
                    $display("INVALID STATE at A=%0d B=%0d : GT=%b EQ=%b LT=%b (should sum to exactly 1)",
                              A, B, GT_s, EQ_s, LT_s);
                    errors = errors + 1;
                end
            end
        end

        $display("==================================================");
        if (errors == 0)
            $display(" RESULT: ALL 256 COMBINATIONS PASSED - 0 errors");
        else
            $display(" RESULT: %0d ERROR(S) FOUND across 256 tests", errors);
        $display("==================================================");

        $finish;
    end

endmodule
