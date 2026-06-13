//inverter file 
//CMOS Inverter - behavioral description
//This tells the simulator WHAT the circuit does , not How its built

module inverter(
    input wire in,
    output wire out
);

     //'assign '= continous assignment - out is always the equal to not in 
     //~ is the bitwise NOT operator in verilog

     assign out = ~in ;

endmodule
