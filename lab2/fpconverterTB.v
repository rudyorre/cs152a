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
		//Initialization
		d = 0;
		#1000;
		
		$display("Begin Test Cases -----------");

		//Most Negative Number
		d = 12'b100000000000;
		#10
		$display("\nInitial -- Most Neg: %b \nFloating Point: %b %b %b", d, S, E, F);
		
		#1000
		//Most Positive Number
		d = 12'b011111111111;
		#10
		$display("\nInitial -- Most Pos: %b \nFloating Point: %b %b %b", d, S, E, F);
		
		#1000;
		
		//Rounding #1
		d = 12'b000000101100;
		#10
		$display("\nInitial -- Rounding #1: %b \nFloating Point: %b %b %b", d, S, E, F);
		
		#1000
		//Rounding #2
		d = 12'b000000101101;
		#10
		$display("\nInitial -- Rounding #2: %b \nFloating Point: %b %b %b", d, S, E, F);
		
		#1000
		//Rounding #3
		d = 12'b000000101110;
		#10
		$display("\nInitial -- Rounding #3: %b \nFloating Point: %b %b %b", d, S, E, F);
		
		#1000
		//Rounding #4
		d = 12'b000000101111;
		#10
		$display("\nInitial -- Rounding #4: %b \nFloating Point: %b %b %b", d, S, E, F);
		
		#1000
		//Extra #1
		d = 12'b011111000000;
		#10
		$display("\nInitial -- Extra #1: %b \nFloating Point: %b %b %b", d, S, E, F);


		
		#1000;

		//Add stimulus here
		d = 0;
        
		$display("\n---------- End Test Cases");
	end
      
endmodule



