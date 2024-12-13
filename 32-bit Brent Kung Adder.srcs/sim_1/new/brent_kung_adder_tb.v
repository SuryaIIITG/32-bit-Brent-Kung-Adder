`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.12.2024 12:00:55
// Design Name: 
// Module Name: brent_kung_adder_tb
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


module brent_kung_adder_tb;

    // Inputs
    reg [31:0] in1;
    reg [31:0] in2;
    reg cin;

    // Outputs
    wire [31:0] out;

    // Instantiate the Unit Under Test (UUT)
    brent_kung_adder uut (
        .in1(in1), 
        .in2(in2), 
        .cin(cin), 
        .out(out)
    );

    // Task for applying test cases
    task apply_test(
        input [31:0] a,
        input [31:0] b,
        input c,
        input [31:0] expected_sum
    );
        begin
            in1 = a;
            in2 = b;
            cin = c;
            #10; // Wait for the combinational logic to settle
            
            if (out !== expected_sum) begin
                $display("Test Failed: in1=%h, in2=%h, cin=%b, expected=%h, got=%h",
                         in1, in2, cin, expected_sum, out);
            end else begin
                $display("Test Passed: in1=%h, in2=%h, cin=%b, out=%h",
                         in1, in2, cin, out);
            end
        end
    endtask

    initial begin
        // Initialize Inputs
        in1 = 0;
        in2 = 0;
        cin = 0;

        $display("Starting Brent-Kung Adder Testbench");

        // Test Cases
        apply_test(32'h00000000, 32'h00000000, 1'b0, 32'h00000000); // Test Case 1: All zeros
        apply_test(32'h00000001, 32'h00000001, 1'b0, 32'h00000002); // Test Case 2: Simple addition
        apply_test(32'hFFFFFFFF, 32'h00000001, 1'b0, 32'h00000000); // Test Case 3: Overflow
        apply_test(32'h12345678, 32'h87654321, 1'b0, 32'h99999999); // Test Case 4: Random values
        apply_test(32'hAAAAAAAA, 32'h55555555, 1'b1, 32'h00000000); // Test Case 5: Alternating bits with carry

        $display("Testbench Completed");
        $stop;
    end

endmodule