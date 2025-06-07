`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2025 12:53:51
// Design Name: 
// Module Name: shift
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module shift (
    input [4:0] A,
    input [1:0] bshift,  // número de bits para desplazar
    input dir,           // 0 = left 1 = right
    output reg [4:0] Result
);
    always @(*) begin
        if (dir == 0) begin
            // Shift a la izquierda
            case (bshift)
                2'b00: Result = A;
                2'b01: Result = A << 1;
                2'b10: Result = A << 2;
                2'b11: Result = A << 3;
                default: Result = A;
            endcase
        end else begin
            // Shift a la derecha
            case (bshift)
                2'b00: Result = A;
                2'b01: Result = A >> 1;
                2'b10: Result = A >> 2;
                2'b11: Result = A >> 3;
                default: Result = A; 
            endcase
        end
    end
endmodule