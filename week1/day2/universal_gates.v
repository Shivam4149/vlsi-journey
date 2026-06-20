// File: universal_gates.v
// Proves NAND is "universal" -- can build NOT, AND, OR using ONLY NAND gates

module not_from_nand(
    input  wire a,
    output wire y
);
    // Trick: tie both NAND inputs to the same signal
    // NAND(a,a) = ~(a & a) = ~a
    nand_gate inst1(.a(a), .b(a), .y(y));
endmodule

module and_from_nand(
    input  wire a,
    input  wire b,
    output wire y
);
    wire nand_out;
    nand_gate inst1(.a(a), .b(b), .y(nand_out));  // NAND(a,b)
    not_from_nand inst2(.a(nand_out), .y(y));     // invert it -> AND
endmodule

module or_from_nand(
    input  wire a,
    input  wire b,
    output wire y
);
    wire not_a, not_b;
    not_from_nand inst1(.a(a), .y(not_a));   // NOT a
    not_from_nand inst2(.a(b), .y(not_b));   // NOT b
    nand_gate inst3(.a(not_a), .b(not_b), .y(y));  
    // NAND(NOT a, NOT b) = ~(~a & ~b) = a | b   <- De Morgan's theorem in action
endmodule
