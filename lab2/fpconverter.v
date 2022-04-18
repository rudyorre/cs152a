`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:41:51 04/18/2022 
// Design Name: 
// Module Name:    fpconverter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fpconverter(d, S, E, F);

// Input and output declaration
input  [11:0] d;  // Inputs sw[4:2] are unused
output wire S;
output wire [2:0] E;
output wire [3:0] F;

reg [11:0] d_manip; //for two's complement if negative
reg [2:0] zero_count; //to count leading zeros
reg [3:0] significand;
reg round_up_Flag;

//Assign the sign bit
assign S = d[11];

//If the sign is negative, we need to flip
always @* begin
	if (S == 1) begin
		assign d_manip = ~d + 1'b1;
	end
	else begin
		assign d_manip = d;
	end
end

//Counting leading zeros using priority encoder
always @* begin
	if (d_manip[10] == 1) assign zero_count = 7;
	else if (d_manip[9] == 1) assign zero_count = 6;
	else if (d_manip[8] == 1) assign zero_count = 5; 
	else if (d_manip[7] == 1) assign zero_count = 4; 
	else if (d_manip[6] == 1) assign zero_count = 3; 
	else if (d_manip[5] == 1) assign zero_count = 2; 
	else if (d_manip[4] == 1) assign zero_count = 1; 
	else assign zero_count = 0; 	
end

//Getting the Significand
assign significand = d_manip << zero_count;

assign E = zero_count;

endmodule
