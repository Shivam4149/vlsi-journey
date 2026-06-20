module comparator_4bit_structural(
  
    input wire [3:0] A,
    input wire [3:0] B,
    output wire GT,
    output wire EQ,
    output wire LT

);


    wire eq3, eq2, eq1, eq0;
    assign eq3 = ~(A[3] ^ B[3]);
    assign eq2 = ~(A[2] ^ B[2]);
    assign eq1 = ~(A[1] ^ B[1]);
    assign eq0 = ~(A[0] ^ B[0]);     

    wire gt3, gt2, gt1, gt0;
    assign gt3 = (A[3] & ~B[3]);
    assign gt2 = (A[2] & ~B[2]);
    assign gt1 = (A[1] & ~B[1]);
    assign gt0 = (A[0] & ~B[0]);

    wire lt3, lt2, lt1, lt0;
    assign lt3 = (~A[3] & B[3]);
    assign lt2 = (~A[2] & B[2]);
    assign lt1 = (~A[1] & B[1]);
    assign lt0 = (~A[0] & B[0]);



    assign EQ = eq3 & eq2 & eq1 & eq0;
 

    assign GT = gt3
              |(eq3 & gt2)
              |(eq3 & eq2 & gt1)
              |(eq3 & eq2 & eq0 & gt0);
 

    
    assign LT = lt3
              |(eq3 & lt2)
              |(eq3 & eq2 & lt1)
              |(eq3 & eq2 & eq0 & lt0);


endmodule
