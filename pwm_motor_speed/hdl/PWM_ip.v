//一般50Mhz时钟为基准的PWM波形发生器
//

module PWM_ip
(
	input				clk,			
	input				rst_n,			
	input				pwm_en,			//模块使能信号，该信号有效时，pwm计数器才能开启工作。
	
	input		[31:0]	clock_total,
	input		[31:0]	clock_high,
	input				pwm_out_en,
	
	output	reg			pwm_out
	

);
	
reg	[31:0]	clock_total_reg	;
reg	[31:0]	clock_high_reg	;


reg	[39:0]	clock_count	;

wire		pwm_wire	;


always@(posedge clk,negedge rst_n)
begin
	if(!rst_n)
		begin			
		    clock_total_reg	<=	'b0	;
		    clock_high_reg	<=	'b0	;
		end											
	else 
		begin
		    clock_total_reg	<=	clock_total	;
		    clock_high_reg	<=	clock_high	;
		end	
end
	

//pwm clock count		
always@(posedge clk,negedge rst_n)
begin
	if(!rst_n)	
		clock_count		<=	'b0	;
	else if( !pwm_en )
		clock_count		<=	'b0	;	
	else if(	clock_count	==	clock_total_reg - 1	)
		clock_count		<=	'b0	;
	else
		clock_count		<=	clock_count	+	1'b1	;
end

assign	pwm_wire	=	(	clock_count	<	clock_high_reg )	?	1'b1	:	1'b0	;	

always@(posedge clk,negedge rst_n)
begin
	if(!rst_n)
		pwm_out	<=	'b0	;
	else if(pwm_out_en)
		pwm_out	<=	pwm_wire	;
	else
		pwm_out	<=	'b0	;
end	


endmodule
