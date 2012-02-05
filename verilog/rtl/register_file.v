//
// Register file, contains general purpose registers
// Allows two register reads and one register write per cycle
// Reads are asynchronous, writes are synchronous.
// Note that external logic ensures register 0 is always 0.  Register 31 is the PC,
// but is not stored here.
//

module register_file(
	clock_i,
	select1_i,
	reg1_o,
	select2_i,
	reg2_o,
	select_write_i,
	write_enable_i,
	write_value_i);

	input 			clock_i,
					select1_i,
					select2_i,
					select_write_i,
					write_enable_i,
					write_value_i;
	output 			reg1_o,
					reg2_o;
	
	wire[31:0]		reg1_o,
					reg2_o,
					write_value_i;
	reg[31:0]		registers[0:30];
	wire[4:0]		select1_i,
					select2_i,
					select_write_i;
	wire 			clock_i,
					write_enable_i,
					write_enable;

	integer i;
	initial
	begin
		for (i = 0; i < 31; i = i + 1)
			registers[i] <= 0;
	end
	
	assign write_enable = write_enable_i;
	assign reg1_o = registers[select1_i];
	assign reg2_o = registers[select2_i];

	always @(posedge clock_i)
	begin
		if (write_enable)
			registers[select_write_i] <= write_value_i;
	end
endmodule
