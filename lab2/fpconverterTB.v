`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: UCLA COMSCI M152A 
// Engineer: Karl Goeltner, Rudy Orre, Kelly Yang
//
// Create Date:   12:42:14 04/18/2022
// Design Name:   fpconverter
// Module Name:   C:/Users/Student/Documents/Krk/lab2/fpconverterTB.v
// Project Name:  lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fpconverter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fpconverterTB;

	reg [11:0] d;
	// Outputs
	wire S;
	wire [2:0] E;
	wire [3:0] F;

	// Instantiate the Unit Under Test (UUT)
	fpconverter uut (.d(d), .S(S), .E(E), .F(F)
		
	);

	initial begin
		// Initialize Inputs
		d = 12'b001000000000;

		// Wait 100 ns for global reset to finish
		#1000;
		
		//Add stimulus here
		d = 12'b101000000000;
        

	end
      
endmodule



