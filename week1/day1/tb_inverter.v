// File: tb_inverter.v
//Test bench for the cmos inverter

`timescale 1ns/1ps
//This means: 1ns is one simulation time unit, 1ps is the precision
//So #10 means "wait 10 nanoseconds"

module tb_inverter;

    // 'reg' = register . Use reg for signals you DRIVE from the testbench
    reg in;


    // 'wire' = use wire for outputs you OBSERVE
    wire out;

    wire expected;
    assign expected = ~in;

    //INSTANTIATE THE DESIGN UNDER TEST (DUT)
    //This is like " Plugging your chip into the test board"
    
    inverter dut (
         .in(in),
         .out(out)

    );
   

     //dump waveform to a .vcd file for gtkwave


     initial begin
         $dumpfile("inverter.vcd");
         $dumpvars(0, tb_inverter);
     end


     initial begin
       
        $display("====================");
        $display("time|in|out|expected");
        $display("====================");

        $monitor("%4t ns| %b| %b| out should be %b",
                  $time, in, out,expected);


        // Test Case 1: Input = 1 (expect output = 1)
        in = 1'b0;
        #20;
        
        in = 1'b1;
        #20;

        repeat(4) begin

            in = ~in;
            #10;

         end
    
          
         if (out === ~in)
              $display ("PASS: inverter output correct at end of simulation");
         else
              $display("FAIL : Something is wrong!");


         $display("=================================");
         $display("Simulation complete!");
         $finish;          //end the simulation
      end
 
endmodule
