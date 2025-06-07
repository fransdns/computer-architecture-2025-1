module top (
    input [4:0] A,
    input [4:0] B,
    input [1:0] bshift,
    input dir,
    input [2:0] ALUControl,
    output [4:0] Result,
    output [3:0] ALUFlags
);

    wire [4:0] shiftedA;

    shift sh(
        .A(A),
        .bshift(bshift),
        .dir(dir),
        .Result(shiftedA)
    );

    alu alu_inst (
        .a(shiftedA),
        .b(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .ALUFlags(ALUFlags)
    );

endmodule