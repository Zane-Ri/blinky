`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/22/2025 04:08:21 PM
// Design Name: 
// Module Name: top
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


module top( 
input logic clk,
input logic [3:0] sw,
output logic [3:0] led
    );
    
    localparam int unsigned clk_Hz = 125_000_000;
    
    logic [31:0] count = 32'd0;
    logic [31:0] half_period;
    
    always_comb begin
        half_period = (clk_Hz / 2) >> sw;     // divide by 2^(sw+1) overall
        if (half_period < 32'd1)
            half_period = 32'd1;              // clamp (avoid 0)
    end
    
    
    always_ff @(posedge clk) begin
    if (count >= (half_period - 1)) begin
            count    <= 32'd0; // reset counter
            led[0]   <= ~led[0]; // blink led
            end else begin
            count <= count + 1'd1; // count = count + 1
            end
        led[3:1] <= sw[2:0];
    end
    initial led = 4'b0001;
endmodule
