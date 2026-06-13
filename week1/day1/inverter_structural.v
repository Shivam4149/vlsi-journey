//file:inverter_structure.v
//cmos Inverter - structural description using actual PMOS/NMOS premitives 
//This shows EXACTLY how the transistors are connected 

module inverter_structural(

    input wire in,
    output wire out

);

    // supply1 = always logic HIGH (VDD)
    // supply0 = a;ways logic LOW (GND)

    supply1 vdd;
    supply0 gnd;

    //PMOS(drain, source , gate )
    //when gate= LOW, PMOS conducts from vdd(source ) to out (drain)
    pmos p1(out, vdd, in);

    //NMOS: (drain, source, gate)
    //When gate= High, NMOS conducts from out(drain) to gnd(source)
    nmos n1(out, gnd, in);

endmodule
