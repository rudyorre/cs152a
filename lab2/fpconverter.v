`timescale 1ns / 1ps
//
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
//
module fpconverter(d, S, E, F);

// Input and output declaration
input  [11:0] d;  // Inputs sw[4:2] are unused
output wire S;
output wire [2:0] E;
output wire [3:0] F;

reg [11:0] d_manip; //for two's complement if negative
reg [2:0] zero_count; //to count leading zeros
reg [2:0] zero_count_updated;
reg [3:0] significand;
reg [3:0] significand_added;
reg round_up_Flag;

//Assign the sign bit
assign S = d[11];

//If the sign is negative, we need to flip
always @* begin
	if (S == 1) begin
		//Edge case for most negative number
		if (d == 12'b100000000000) begin 
			assign d_manip = ~d; end
		//Normal case
		else assign d_manip = ~d + 1'b1;
	end

	else begin
		assign d_manip = d; 
	end
end



//Counting leading zeros using priority encoder
//Getting the Significand and the Rounding bit
always @* begin
	if (d_manip[10] == 1) begin 
		assign zero_count = 7;
		assign significand = d_manip[10:7]; 
		assign round_up_Flag = d_manip[6]; end
	
	else if (d_manip[9] == 1) begin
		assign zero_count = 6; 
		assign significand = d_manip[9:6]; 
		assign round_up_Flag = d_manip[5]; end
		
	else if (d_manip[8] == 1) begin 
		assign zero_count = 5;
		assign significand = d_manip[8:5]; 
		assign round_up_Flag = d_manip[4]; end
	
	else if (d_manip[7] == 1) begin
		assign zero_count = 4;
		assign significand = d_manip[7:4]; 
		assign round_up_Flag = d_manip[3]; end	
		
	else if (d_manip[6] == 1) begin
		assign zero_count = 3; 
		assign significand = d_manip[6:3]; 
		assign round_up_Flag = d_manip[2]; end
		
	else if (d_manip[5] == 1) begin 
		assign zero_count = 2;
		assign significand = d_manip[5:2]; 
		assign round_up_Flag = d_manip[1]; end
		
	else if (d_manip[4] == 1) begin 
		assign zero_count = 1;
		assign significand = d_manip[4:1]; 
		assign round_up_Flag = d_manip[0]; end	
		
	else begin 
		assign zero_count = 0; 	
		assign significand = d_manip[3:0]; 
		assign round_up_Flag = 0; end
end

//Rounding
always @* begin
	if (significand == 4'b1111 && round_up_Flag) begin 
		if (zero_count == 7) begin 
			assign significand_added = significand;
			assign zero_count_updated = zero_count; 
		end
		else begin
			assign significand_added = significand >> 1;
			assign zero_count_updated = zero_count + 1; 
		end
	end
	
	else begin 
		assign significand_added = significand + (1 & round_up_Flag); 
		assign zero_count_updated = zero_count; end
end

assign E = zero_count_updated;
assign F = significand_added;

endmodule
