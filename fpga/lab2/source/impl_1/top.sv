// Alisha Chulani achulani@g.hmc.edu
// Sep 4, 2024
// This projet will test that LEDs on the board are working properly by lighting up under simple and and xor gates
// It also includes code for a 7-segment display based on the same switches


module top (
	input logic reset,
	input logic [3:0] switch1,
	input logic [3:0] switch2,
	output logic [1:0] power,
	output logic  [6:0] segs,  
	output logic  [4:0] leds
	);
	
	logic int_osc; 
	// Internal high-speed oscillator
    HSOSC #(.CLKHF_DIV(2'b01)) hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	multiplexer switchoff(int_osc, reset, switch1, switch2, power, segs);
	summer summing(switch1, switch2, leds);

endmodule


module multiplexer(
	input logic clk, reset, 
	input logic [3:0] switch1,
	input logic [3:0] switch2,
	output logic [1:0] power,
	output logic [6:0] seg
);

     logic [24:0] counter;
   logic [3:0] switch;

  
   // Counter
   always_ff @(posedge clk) begin
     if(reset == 0)  counter <= 0;
     else            counter <= counter + 1;
   end
   
    always_ff @(posedge clk) begin
	 if (counter[16] == 0) begin 
			power[1] <= 1;
			power[0] <= 0;
			switch <= switch1;
	end 
	else begin
			power[1] <= 0;
			power[0] <= 1;
			switch <= switch2;
     end
   end
   
   sevseg sevenseg(switch, seg);
   
  

endmodule 


module sevseg (
	input logic [3:0] switch,
	output  logic [6:0] seg
);
	
	always_comb begin
	  case(switch)
			4'b0000: seg = 7'b0000001;
			4'b0001: seg = 7'b1001111;
			4'b0010: seg = 7'b0010010;
			4'b0011: seg = 7'b0000110;
			4'b0100: seg = 7'b1001100;
			4'b0101: seg = 7'b0100100;
			4'b0110: seg = 7'b0100000;
			4'b0111: seg = 7'b0001111;
			4'b1000: seg = 7'b0000000;
			4'b1001: seg = 7'b0000100;
			4'b1010: seg = 7'b0001000;
			4'b1011: seg = 7'b1100000;
			4'b1100: seg = 7'b0110001;
			4'b1101: seg = 7'b1000010;
			4'b1110: seg = 7'b0110000;
			4'b1111: seg = 7'b0111000;
	   endcase
	 end 

endmodule



module summer (
	input logic [3:0] switch1,
	input logic [3:0] switch2,
	output  logic [4:0] led

);

	logic [4:0] sum;
	
	always_comb begin
	sum = switch1 + switch2; //is this a valid way to do the addition? 
	end

	assign led = sum;


endmodule


