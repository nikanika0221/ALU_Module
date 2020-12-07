`timescale 1ns / 1ps

module ALU(
		input[31:0] Aport,
		input[31:0] Bport,
		input[1:0] OP,
		input[3:0] cmd,
		output reg [31:0] ALU_out,
		output reg[3:0] flags
    );
	 
	parameter [3:0] AND_OP = 0, XOR_OP = 1, OOR_OP = 12, SUB_OP = 2, RSB_OP = 3, ADD_OP = 4, CMP_OP = 10;
	 
	 always @(*) 
		begin
			if(!OP) 
				begin // process data
					case(cmd) 
						AND_OP : ALU_out = Aport&Bport;
						XOR_OP : ALU_out = Aport^Bport; 
						SUB_OP : ALU_out = Aport-Bport; 
						RSB_OP : ALU_out = Bport-Aport;
						ADD_OP : ALU_out = Aport+Bport;
						CMP_OP : ALU_out = Aport-Bport; 
						OOR_OP : ALU_out = Aport|Bport; 
						default: ALU_out = 0;
					endcase
				end
			else if(OP == 1) ALU_out = cmd[3] ? Aport+Bport : Aport;
			else if(OP == 2) ALU_out= Aport+Bport;
			else ALU_out= 0;
		end
	 
	 
	 always @(*) 
		begin
			// for N flag
			flags[3] = ALU_out[31] ? 1 : 0;
			
			// for Z flag
			flags[2] = ALU_out ? 0 : 1;
			
			// C-O flags for sub and cmp
			if((cmd == 0) | (cmd==10)) 
				begin 
					flags[1] = Aport < Bport ? 1 : 0;
					flags[0] = ((Aport[31] != Bport[31]) & (Bport[31] != ALU_out[31])) ? 1 : 0;
				end
			
			// C-O flags for RST 
			else if(cmd == 3) 
				begin
					flags[1] = Aport > Bport ? 1 : 0;
					flags[0] = ((Aport[31] == Bport[31]) & (Aport[31] != ALU_out[31])) ? 1 : 0;
				end
			
			else if(cmd == 4) 
				begin
					flags[1] = ((Aport > ALU_out) || (ALU_out < Bport)) ? 1 : 0;
					flags[0] = ((Aport[31] == Bport[31]) & (Aport[31] != ALU_out[31])) ? 1 : 0;
				end
			else 
				begin
					flags[1] = 0;
					flags[0] = 0;
				end
		end
	endmodule
