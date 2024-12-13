`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.12.2024 11:58:45
// Design Name: 
// Module Name: brent_kung_adder
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


module brent_kung_adder (
    input [31:0] in1, in2,
    input cin,
    output [31:0] out
);

    reg [31:0] propagate[6:0];
    reg [31:0] gen_signal[6:0];
    reg [32:1] carry;

    integer i;

    always @(*) begin
        // Level 1: Initial propagate and generate signals
        propagate[0] = in1 ^ in2;
        gen_signal[0] = in1 & in2;

        // Level 2 to 6: Group propagate and generate signals
        for (i = 0; i < 6; i = i + 1) begin
            propagate[i + 1] = propagate[i] & {propagate[i][31:1], 1'b0};
            gen_signal[i + 1] = gen_signal[i] | (propagate[i] & {gen_signal[i][31:1], cin});
        end

        // Compute carry signals based on generate and propagate values
        carry[1] = gen_signal[0][0] | (propagate[0][0] & cin);
        for (i = 1; i <= 31; i = i + 1) begin
            carry[i + 1] = gen_signal[0][i] | (propagate[0][i] & carry[i]);
        end
    end

    // Compute sum output
    assign out = propagate[0] ^ {carry[31:1], cin};

endmodule
