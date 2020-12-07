module tb;
	// Inputs
	reg [31:0] Aport;
	reg [31:0] Bport;
	reg [1:0] OP;
	reg [3:0] cmd;

	// Outputs
	wire [31:0] ALU_out;
	wire [3:0] flags;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.Aport(Aport), 
		.Bport(Bport), 
		.OP(OP), 
		.cmd(cmd), 
		.ALU_out(ALU_out), 
		.flags(flags)
	);

	initial begin
		// Initialize Inputs
		Aport = 0;
		Bport = 0;
		OP = 0;
		cmd = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		Aport = 32'h11111;
		Bport = 32'h00001; 
		OP=0;
		
		cmd = 1;
		#50;	cmd = 2;
		#50;	cmd = 3;
		#50;	cmd = 4;
		#50;	cmd = 10;
		#50;	cmd = 12;
		#50;		
		OP=1;
		Aport=15;
		Bport=14;
		cmd=0;
		#50;	cmd[3] = 1;
		
		#50;	OP=2;
		cmd = 4'b0100;
		Aport = 32'hFFFFFFFF;
		Bport = 20;
	end    
endmodule

