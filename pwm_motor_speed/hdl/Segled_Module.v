
module Segled_Module
(	
	
	input				clk,
	input				rst_n,
	
	input		[ 3:0]	seg_num,
	output	reg	[ 6:0]	SEG_HEX
);

//实现数码管的解码
always @ (posedge clk,negedge rst_n)
begin
	if( !rst_n )
		SEG_HEX	<=	7'b0111111;
	else 
		begin
			case(seg_num)
				0  : SEG_HEX[6:0] = 7'b1000000		;   		//显示数字 "0"
				1  : SEG_HEX[6:0] = 7'b1111001		;  		//显示数字 "1"
				2  : SEG_HEX[6:0] = 7'b0100100		;   		//显示数字 "2"
				3  : SEG_HEX[6:0] = 7'b0110000		;   		//显示数字 "3"
				4  : SEG_HEX[6:0] = 7'b0011001		;  		//显示数字 "4"
				5  : SEG_HEX[6:0] = 7'b0010010		;   		//显示数字 "5"
				6  : SEG_HEX[6:0] = 7'b0000010		;   		//显示数字 "6"
				7  : SEG_HEX[6:0] = 7'b1111000		;   		//显示数字 "7"
				8  : SEG_HEX[6:0] = 7'b0000000		;   		//显示数字 "8"
				9  : SEG_HEX[6:0] = 7'b0010000		;  		//显示数字 "9"
				10 : SEG_HEX[6:0] = 7'b0001000		;   		//显示数字 "A"
				11 : SEG_HEX[6:0] = 7'b0000011		;   		//显示数字 "B"
				12 : SEG_HEX[6:0] = 7'b0100111		;   		//显示数字 "C"
				13 : SEG_HEX[6:0] = 7'b0100001		;   		//显示数字 "D"
				14 : SEG_HEX[6:0] = 7'b0000110		;   		//显示数字 "E"
				15 : SEG_HEX[6:0] = 7'b0001110		;   		//显示数字 "F"
				default :SEG_HEX[6:0] = 7'b0111111;	//显示数字 "0"
			endcase
		end
end

endmodule
