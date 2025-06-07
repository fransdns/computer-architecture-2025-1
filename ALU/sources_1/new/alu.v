`timescale 1ns / 1ps

module alu (
    input  [4:0] a, b,               // Entradas a y b
    input  [2:0] ALUControl,          // Señales de control de la ALU
    output reg [4:0] Result,          // Resultado de la operación
    output wire [3:0] ALUFlags        // Flags de la ALU (negativo, cero, acarreo, desbordamiento)
);
    wire neg, zero, carry, overflow;  // Flags internos
    wire [4:0] condinvb;              // Condición de invertir b
    wire [5:0] sum;                  // Suma de a + b
    wire [4:0] twocomplement;        // Complemento a dos de a

    
    assign condinvb = ALUControl[0] ? ~b : b;
    assign sum = a + condinvb + ALUControl[0];
    assign twocomplement = a[4] ? ~a + 1'b1 : a;

 
 

    // Lógica principal de la ALU con base en el ALUControl
    always @(*) begin
        case (ALUControl)
            3'b000: Result = sum;                      // Suma
            3'b010: Result = a & b;                    // AND
            3'b011: Result = a | b;                    // OR
            3'b100: Result = (~a & b) | (a & ~b);      // XOR
            3'b111: if (a[4] == 1) begin
                    Result = twocomplement;
                    Result[4] = 1'b1;  // Si el bit más significativo es 1, es negativo
                    end else begin
                        Result = twocomplement;
                        Result[4] = 1'b0;  // Si no, es positivo
                    end            // Complemento a dos
            default: Result = 5'b0;                    // Valor por defecto
        endcase
    end

   
    assign neg = Result[4];                         
    assign zero = (Result == 5'b0);                   
    assign carry = (ALUControl[1] == 1'b0) & sum[5]; 
    assign overflow = (ALUControl[1] == 1'b0) & ~(a[4] ^ b[4] ^ ALUControl[0]) & (a[4] ^ sum[4]); // Flag de desbordamiento

   
    assign ALUFlags = {neg, zero, carry, overflow};

endmodule