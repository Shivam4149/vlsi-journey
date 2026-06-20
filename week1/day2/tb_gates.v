// File: tb_gates.v
// Comprehensive testbench: tests NAND, NOR, and the NAND-built AND/OR
// Auto-checks every combination -- no manual eyeballing needed

`timescale 1ns/1ps

module tb_gates;

    reg a, b;
    wire y_nand, y_nor, y_and, y_or;
    integer errors = 0;   // 'integer' = a variable to count failures
    integer i;

    // Instantiate all four circuits, same inputs feeding all of them
    nand_gate      u_nand (.a(a), .b(b), .y(y_nand));
    nor_gate       u_nor  (.a(a), .b(b), .y(y_nor));
    and_from_nand  u_and  (.a(a), .b(b), .y(y_and));
    or_from_nand   u_or   (.a(a), .b(b), .y(y_or));

    initial begin
        $dumpfile("gates.vcd");
        $dumpvars(0, tb_gates);

        $display("=========================================================");
        $display(" A  B | NAND NOR  AND  OR  | Expected NAND NOR AND OR");
        $display("=========================================================");

        // Loop through all 4 combinations of a 2-bit number: 00, 01, 10, 11
        for (i = 0; i < 4; i = i + 1) begin
            {a, b} = i;     // concatenation trick: assigns top bit to a, bottom bit to b
            #10;            // let signals settle

            $display(" %b  %b |  %b    %b    %b    %b  |    %b      %b    %b   %b",
                      a, b, y_nand, y_nor, y_and, y_or,
                      ~(a&b), ~(a|b), (a&b), (a|b));

            // AUTOMATIC CHECKING -- this is what makes it a real testbench
            if (y_nand !== ~(a&b)) begin
                $display("  *** FAIL: NAND wrong for a=%b b=%b ***", a, b);
                errors = errors + 1;
            end
            if (y_nor !== ~(a|b)) begin
                $display("  *** FAIL: NOR wrong for a=%b b=%b ***", a, b);
                errors = errors + 1;
            end
            if (y_and !== (a&b)) begin
                $display("  *** FAIL: AND (from NAND) wrong for a=%b b=%b ***", a, b);
                errors = errors + 1;
            end
            if (y_or !== (a|b)) begin
                $display("  *** FAIL: OR (from NAND) wrong for a=%b b=%b ***", a, b);
                errors = errors + 1;
            end
        end

        $display("=========================================================");
        if (errors == 0)
            $display(" RESULT: ALL TESTS PASSED (0 errors)");
        else
            $display(" RESULT: %0d TEST(S) FAILED", errors);
        $display("=========================================================");

        $finish;
    end

endmodule
