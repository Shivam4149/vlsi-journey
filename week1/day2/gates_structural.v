module nand_structural(

    input wire a,
    input wire b,
    output wire y

);

    supply1 vdd;
    supply0 gnd;


    pmos p1(y , vdd, a);
    pmos p2(y , vdd, b);
 
    wire mid;
    nmos n1(y, mid, a);
    nmos n2(mid, gnd, b);

endmodule

module nor_structural(
    input wire a,
    input wire b,
    output wire y
);
    
    supply1 vdd;
    supply0 gnd;

    wire mid;
    pmos p1(y , mid , a);
    pmos p2(mid, gnd, b);

    nmos n1(y, vdd, a);
    nmos n2(y, vdd, b);

endmodule
