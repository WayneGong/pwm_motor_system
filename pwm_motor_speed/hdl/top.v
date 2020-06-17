//	黑色和灰色两根线：pwm控制信号，黑线接引脚JP1-40,灰线接引脚JP1-38
//	黄色线：测速信号线，接引脚JP1-2
//	红色和黑色线：电机电源线，接引脚JP1-11和JP1-12
//	红色和橙色线：测速模块电源线，接引脚JP1-29,JP1-30
//	
//	
module top
(
	input			clk,	//50MHz--AF14
	input			rst_n,	//key0--AA14
	input			speed,	//GPIO0[1],Y17	
	input	[2:0]	key_in,	//key_in[1]--key3--Y16,
							//key_in[0]--key2--W15,
							//key_in[2]--key1--AA15
	
	output	[ 6:0]	HEX0,
	output	[ 6:0]	HEX1,
	output	[ 6:0]	HEX2,
	output	[ 6:0]	HEX3,
	output	[ 6:0]	HEX4,
	output	[ 6:0]	HEX5,
	output			pwm_out1,	//GPIO0[35],AJ21
	output			pwm_out2,	//GPIO0[33],AG20
	output	[9:0]	LEDR

);

assign	LEDR[1:0]		=	{	2{pwm_out1}	};
assign	LEDR[4:3]		=	{	2{pwm_out2}	};

assign	LEDR[2]			=	1'b0;
assign	LEDR[9:5]		=	1'b0;


speed_display uspeed_display
(
	.clk	(	clk		),
	.rst_n	(	rst_n	),
	.speed	(	speed	),	//GPIO0[1],Y17
			
	.HEX0	(	HEX0	),
	.HEX1	(	HEX1	),
	.HEX2	(	HEX2	),
	.HEX3	(	HEX3	),
	.HEX4	(	HEX4	),
	.HEX5	(	HEX5	)
);

pwm_control upwm_control
(
	.clk		(	clk		),
	.rst_n		(	rst_n	),	
	.key_in		(	key_in	),
	.pwm_out1	(	pwm_out1),
	.pwm_out2	(	pwm_out2)

);



endmodule