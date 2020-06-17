module speed_display
(
	input			clk,
	input			rst_n,
	input			speed,	//GPIO0[1],Y17
	
	output	[ 6:0]	HEX0,
	output	[ 6:0]	HEX1,
	output	[ 6:0]	HEX2,
	output	[ 6:0]	HEX3,
	output	[ 6:0]	HEX4,
	output	[ 6:0]	HEX5
	
);

parameter	time_ones	=	50_000_000;

reg		[ 3: 0]	seg0	;
reg		[ 3: 0]	seg1	;
reg		[ 3: 0]	seg2	;
reg		[ 3: 0]	seg3	;
reg		[ 3: 0]	seg4	;
reg		[ 3: 0]	seg5	;

reg				speed_reg1;
reg				speed_reg2;
reg				speed_rise;
reg		[40: 0] speed_count;

reg		[25: 0] speed_Average;

reg		[40: 0] time_cnt;

always@(posedge clk,negedge	rst_n)
begin
	if(!rst_n)
		begin
			speed_reg1	<=	1'b0;
			speed_reg2	<=	1'b0;
		end	
	else
		begin
			speed_reg1	<=	speed;
			speed_reg2	<=	speed_reg1;
		end	

end

always@(posedge clk,negedge	rst_n)
begin
	if(!rst_n)
		speed_rise	<=	1'b0;
	else if( !speed_reg2 && speed_reg1  )
		speed_rise	<=	1'b1;
	else
		speed_rise	<=	1'b0;
end

always@(posedge clk,negedge	rst_n)
begin
	if(!rst_n)
		speed_count	<=	'b0;
	else if( speed_rise )
		speed_count	<=	'b0;
	else 
		speed_count	<=	speed_count	+	1'b1;
end

always@(posedge clk,negedge	rst_n)
begin
	if(!rst_n)
		time_cnt	<=	'b0;
	else if( speed_rise && (  time_cnt >= time_ones))
		time_cnt	<=	'b0;
	else 
		time_cnt	<=	time_cnt	+	1'b1;
end


always@(posedge clk,negedge	rst_n)
begin
	if(!rst_n)
		speed_Average	<=	'b0;	
	else if( speed_rise && (  time_cnt >= time_ones))	
		speed_Average	<=	speed_count[40:14];
	else
		speed_Average	<=	speed_Average;
end		
		

always@(posedge clk,negedge rst_n)
begin
	if(!rst_n)
		begin
			seg0	<=	4'b0;
			seg1	<=	4'b0;
			seg2	<=	4'b0;
			seg3	<=	4'b0;
			seg4	<=	4'b0;
			seg5	<=	4'b0;
		end
	else
		begin
			seg5	<=	( speed_Average %1000000 ) / 100000	;
			seg4	<=	( speed_Average %100000 ) / 10000	;
			seg3	<=	( speed_Average %10000 ) / 1000		;
			seg2	<=	( speed_Average %1000 ) / 100		;
			seg1	<=	( speed_Average %100 ) / 10			;
			seg0	<=	( speed_Average %10 ) / 1			;
		end
end


Segled_Module Segled_Module0
(	
	
	.clk		(	clk		),
	.rst_n		(	rst_n	),
	
	.seg_num	(	seg0	),
	.SEG_HEX	(	HEX0	)
);

Segled_Module Segled_Module1
(	
		
	.clk		(	clk	),
	.rst_n		(	rst_n	),
	
	.seg_num	(	seg1	),
	.SEG_HEX	(	HEX1	)
);

Segled_Module Segled_Module2
(	
	
	.clk		(	clk	),
	.rst_n		(	rst_n	),
	
	.seg_num	(	seg2	),
	.SEG_HEX	(	HEX2	)
);

Segled_Module Segled_Module3
(	
	
	.clk		(	clk	),
	.rst_n		(	rst_n	),
	
	.seg_num	(	seg3	),
	.SEG_HEX	(	HEX3	)
);

Segled_Module Segled_Module4
(	
	
	.clk		(	clk	),
	.rst_n		(	rst_n	),
		
	.seg_num	(	seg4	),
	.SEG_HEX	(	HEX4	)
);

Segled_Module Segled_Module5
(	
	
	.clk		(	clk		),
	.rst_n		(	rst_n	),
	
	.seg_num	(	seg5	),
	.SEG_HEX	(	HEX5	)
);

endmodule