
`timescale 1ms / 1ns

module sevenseg_tb();

// set up test signals 
logic [3:0] switch1;
logic [3:0] switch2;
logic reset;
logic [1:0] power;
logic [4:0] leds;
logic [6:0] segs; 


top dut( .reset(reset), .switch1(switch1), .switch2(switch2), .power(power), .segs(segs), .leds(leds));

initial begin 
	reset = 0; #1;
	reset = 1;
	switch1 = 0; switch2 = 0; #10; 

	switch1 = 1; switch2 = 0; #10; 
	
	switch1 = 0; switch2 = 1; #10; 
	
	switch1 = 8; switch2 = 15; #10; 
	$stop;
   end


endmodule 
