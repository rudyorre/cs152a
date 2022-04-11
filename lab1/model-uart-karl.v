`timescale 1ns / 1ps

module model_uart(/*AUTOARG*/
   // Outputs
   TX,
   // Inputs
   RX
   );

   output TX;
   input  RX;

   parameter baud    = 115200;
   parameter bittime = 1000000000/baud;
   parameter name    = "UART0";
   
   reg [7:0] rxData;
   reg [31:0] out;
   reg index;
   event     evBit;
   event     evByte;
   event     evTxBit;
   event     evTxByte;
   reg       TX;
   reg [31:0] temp;
   integer i;

   initial
     begin
         TX = 1'b1;
         index = 0;
         temp = 0;
         i = 0;
     end
   
   always @ (negedge RX)
     begin
        rxData[7:0] = 8'h0;
        #(0.5*bittime);
        repeat (8)
          begin
             #bittime ->evBit;
             //rxData[7:0] = {rxData[6:0],RX};
             rxData[7:0] = {RX,rxData[7:1]};
          end
       
       // NEW CODE
       // temp[31:0] = {rxData, temp[31:8]}; // Concatenate rxData & temp together
       
		//If carriage return, print out our buffer
       if (rxData == 13)  
			  begin// match ascii \r or \n
				  $display ("\n %d %s Received %0x \n", $stime, name, temp); 
				  temp = 0;
			end
		
		//Else if it's not a newline, we'll add the character to the buffer
		else if (rxData != 10) begin 
		 
			temp = temp << 8;
			temp[7:0] = rxData;
		end
       // END NEW CODE
		 
		 
        ->evByte;
        //$display ("%d %s Received byte %02x (%s)", $stime, name, rxData, rxData);
     end

   task tskRxData;
      output [7:0] data;
      begin
         @(evByte);
         data = rxData;
      end
   endtask // for
      
   task tskTxData;
      input [7:0] data;
      reg [9:0]   tmp;
      integer     i;
      begin
         tmp = {1'b1, data[7:0], 1'b0};
         for (i=0;i<10;i=i+1)
           begin
              TX = tmp[i];
              #bittime;
              ->evTxBit;
           end
         ->evTxByte;
      end
   endtask // tskTxData
   
endmodule // model_uart
