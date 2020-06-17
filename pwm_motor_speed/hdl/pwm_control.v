module pwm_control
(
	clk,
	rst_n,	
	key_in,
	pwm_out1,
	pwm_out2

);

input			clk;
input			rst_n;
input	[2:0]	key_in;
output			pwm_out1;
output			pwm_out2;

wire			pwm_out;

reg		[20:0]	key_cnt;
reg		[2:0]	key_reg1;
reg		[2:0]	key_reg2;
wire	[2:0]	key_out;
reg		[31:0]	clock_high;
reg				pwm_out_sel;

always@(posedge clk,negedge rst_n)
begin
	if(!rst_n)
		key_cnt	<=	'b0;
	else if( key_cnt == 50_000 )
		key_cnt	<=	'b0;
	else
		key_cnt	<=	key_cnt	+	1'b1;
end

always@(posedge clk,negedge rst_n)
begin
	if(!rst_n)
		key_reg1	<=	'b0;		
	else if( key_cnt == 50_000 )
		key_reg1	<=	key_in;		
	else
		key_reg1	<=	key_reg1;
end

always@(posedge clk,negedge rst_n)
begin
	if(!rst_n)
		key_reg2	<=	'b0;		
	else
		key_reg2	<=	key_reg1;
end

assign	key_out	=	key_reg2 & ( ~key_reg1 );
	

//clock_high	80000
//clock_total	100000	

always@(posedge clk,negedge rst_n)
begin
	if(!rst_n)
		clock_high	<=	90000;
	else if( ( key_out == 3'b010 ) && ( clock_high > 55000) )
		clock_high	<=	clock_high	-	5000;
	else if( ( key_out == 3'b001 ) && ( clock_high < 95000) )
		clock_high	<=	clock_high	+	5000;
	else
		clock_high	<=	clock_high	;
end
	
always@(posedge clk,negedge rst_n)
begin
	if(!rst_n)
		pwm_out_sel	<=	'b0;
	else if(key_out == 3'b100)
		pwm_out_sel	<=	~pwm_out_sel;
	else 
		pwm_out_sel	<=	pwm_out_sel;
end
	

assign	pwm_out1	=	pwm_out_sel ?	pwm_out	:	1'b0	;
assign	pwm_out2	=	pwm_out_sel ?	1'b0	:	pwm_out	;

	
PWM_ip uPWM_ip
(
	.clk			(	clk			),			
	.rst_n			(	rst_n		),			
	.pwm_en			(	1'b1		),			//模块使能信号，该信号有效时，pwm计数器才能开启工作。
	
	.clock_total	(	100000		),
	.clock_high		(	clock_high	),
	.pwm_out_en		(	1'b1		),
	
	.pwm_out		(	pwm_out		)
	
);

	

endmodule
