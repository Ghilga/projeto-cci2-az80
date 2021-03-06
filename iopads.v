module iopads(nWAIT, nINT, nNMI, nRESET, nBUSRQ, CLK, nM1, nMREQ, nIORQ, nRD, nWR, nRFSH, nHALT, nBUSACK, A, D
	nWAIT_I, nINT_I, nNMI_I, nRESET_I, nBUSRQ_I, CLK_I, nM1_O, nMREQ_O, nIORQ_O, nRD_O, nWR_O, nRFSH_O, nHALT_O, nBUSACK_O, A_0, D_I);

	input nWAIT, nINT, nNMI, nRESET, nBUSRQ, CLK;
  	output nM1, nMREQ, nIORQ, nRD, nWR, nRFSH, nHALT, nBUSACK;
  	output [15:0] A;
  	inout [7:0] D;

	input nWAIT_I, nINT_I, nNMI_I, nRESET_I, nBUSRQ_I, CLK_I;
  	output nM1_O, nMREQ_O, nIORQ_O, nRD_O, nWR_O, nRFSH_O, nHALT_O, nBUSACK_O;
  	output [15:0] A_O;
  	inout [7:0] D_I;

	ICP PAD_nwait_i(.PAD(nWAIT), .Y(nWAIT_I));
	ICP PAD_nint_i(.PAD(nINT), .Y(nINT_I));
	ICP PAD_nmi_i(.PAD(nNMI), .Y(nNMI_I));
	ICP PAD_nreset_i(.PAD(nRESET), .Y(nRESET_I));
	ICP PAD_nbusrq_i(.PAD(nBUSRQ), .Y(nBUSRQ_I));
	ICP PAD_clk_i(.PAD(CLK), .Y(nCLK_I));

	BD8P PAD_nm1_o(.A(nM1_O), .PAD(nM1));
	BD8P PAD_nmreq_o(.A(nMREQ_O), .PAD(nMREQ));
	BD8P PAD_niorq_o(.A(nIORQ_O), .PAD(nIORQ));
	BD8P PAD_nrd_o(.A(nRD_O), .PAD(nRD));
	BD8P PAD_nwr_o(.A(nWR_O), .PAD(nWR));
	BD8P PAD_nrfsh_o(.A(nRFSH_O), .PAD(nRFSH));
	BD8P PAD_nhalt_o(.A(nHALT_O), .PAD(nHALT));
	BD8P PAD_nbusack_o(.A(nBUSACK_O), .PAD(nBUSACK));
	
	//BUS
	BD8P PAD_a0_o(.A(A_O[0]), .PAD(A[0]));
	BD8P PAD_a1_o(.A(A_O[1]), .PAD(A[1]));
	BD8P PAD_a2_o(.A(A_O[2]), .PAD(A[2]));
	BD8P PAD_a3_o(.A(A_O[3]), .PAD(A[3]));
	BD8P PAD_a4_o(.A(A_O[4]), .PAD(A[4]));
	BD8P PAD_a5_o(.A(A_O[5]), .PAD(A[5]));
	BD8P PAD_a6_o(.A(A_O[6]), .PAD(A[6]));
	BD8P PAD_a7_o(.A(A_O[7]), .PAD(A[7]));
	BD8P PAD_a0_o(.A(A_O[8]), .PAD(A[8]));
	BD8P PAD_a1_o(.A(A_O[9]), .PAD(A[9]));
	BD8P PAD_a2_o(.A(A_O[10]), .PAD(A[10]));
	BD8P PAD_a3_o(.A(A_O[11]), .PAD(A[11]));
	BD8P PAD_a4_o(.A(A_O[12]), .PAD(A[12]));
	BD8P PAD_a5_o(.A(A_O[13]), .PAD(A[13]));
	BD8P PAD_a6_o(.A(A_O[14]), .PAD(A[14]));
	BD8P PAD_a7_o(.A(A_O[15]), .PAD(A[15]));

	BBC8P PAD_d0_i(.D(D_I[0]), .PAD(D[0]));
	BBC8P PAD_d1_i(.D(D_I[1]), .PAD(D[1]));
	BBC8P PAD_d2_i(.D(D_I[2]), .PAD(D[2]));
	BBC8P PAD_d3_i(.D(D_I[3]), .PAD(D[3]));
	BBC8P PAD_d4_i(.D(D_I[4]), .PAD(D[4]));
	BBC8P PAD_d5_i(.D(D_I[5]), .PAD(D[5]));
	BBC8P PAD_d6_i(.D(D_I[6]), .PAD(D[6]));
	BBC8P PAD_d7_i(.D(D_I[7]), .PAD(D[7]));
	
	VDDORPADP PAD_vdd_E();
	VDDPADP PAD_vdd_core_E();

	VDDPADP PAD_vdd_core_N();
	GNDORPADP PAD_vss_core_N();

	GNDORPADP PAD_vss_W();

	GNDORPADP PAD_vss_S();

	CORNERP PAD_corner_ll();
	CORNERP PAD_corner_lr();
	CORNERP PAD_corner_ul();
	CORNERP PAD_corner_ur();

endmodule

	/*
	input Bus2IP_Clk, Bus2IP_Reset;
	input [7:0] Bus2IP_Data;
	input [0:14] Bus2IP_RdCE, Bus2IP_WrCE;
	output [7:0] IP2Bus_Data;
	output user_int;

	output Bus2IP_Clk_I, Bus2IP_Reset_I;
	output [7:0] Bus2IP_Data_I;
	output [0:14] Bus2IP_RdCE_I, Bus2IP_WrCE_I;
	input [7:0] IP2Bus_Data_O;
	input user_int_O;

	ICP PAD_bus2ip_clk_i(.PAD(Bus2IP_Clk), .Y(Bus2IP_Clk_I));
	ICP PAD_bus2ip_reset_i(.PAD(Bus2IP_Reset), .Y(Bus2IP_Reset_I));
	ICP PAD_bus2ip_data_i_0(.PAD(Bus2IP_Data[0]), .Y(Bus2IP_Data_I[0]));
	ICP PAD_bus2ip_data_i_1(.PAD(Bus2IP_Data[1]), .Y(Bus2IP_Data_I[1]));
	ICP PAD_bus2ip_data_i_2(.PAD(Bus2IP_Data[2]), .Y(Bus2IP_Data_I[2]));
	ICP PAD_bus2ip_data_i_3(.PAD(Bus2IP_Data[3]), .Y(Bus2IP_Data_I[3]));
	ICP PAD_bus2ip_data_i_4(.PAD(Bus2IP_Data[4]), .Y(Bus2IP_Data_I[4]));
	ICP PAD_bus2ip_data_i_5(.PAD(Bus2IP_Data[5]), .Y(Bus2IP_Data_I[5]));
	ICP PAD_bus2ip_data_i_6(.PAD(Bus2IP_Data[6]), .Y(Bus2IP_Data_I[6]));
	ICP PAD_bus2ip_data_i_7(.PAD(Bus2IP_Data[7]), .Y(Bus2IP_Data_I[7]));
	ICP PAD_bus2ip_rdce_i_0(.PAD(Bus2IP_RdCE[0]), .Y(Bus2IP_RdCE_I[0]));
	ICP PAD_bus2ip_rdce_i_1(.PAD(Bus2IP_RdCE[1]), .Y(Bus2IP_RdCE_I[1]));
	ICP PAD_bus2ip_rdce_i_2(.PAD(Bus2IP_RdCE[2]), .Y(Bus2IP_RdCE_I[2]));
	ICP PAD_bus2ip_rdce_i_3(.PAD(Bus2IP_RdCE[3]), .Y(Bus2IP_RdCE_I[3]));
	ICP PAD_bus2ip_rdce_i_4(.PAD(Bus2IP_RdCE[4]), .Y(Bus2IP_RdCE_I[4]));
	ICP PAD_bus2ip_rdce_i_5(.PAD(Bus2IP_RdCE[5]), .Y(Bus2IP_RdCE_I[5]));
	ICP PAD_bus2ip_rdce_i_6(.PAD(Bus2IP_RdCE[6]), .Y(Bus2IP_RdCE_I[6]));
	ICP PAD_bus2ip_rdce_i_7(.PAD(Bus2IP_RdCE[7]), .Y(Bus2IP_RdCE_I[7]));
	ICP PAD_bus2ip_rdce_i_8(.PAD(Bus2IP_RdCE[8]), .Y(Bus2IP_RdCE_I[8]));
	ICP PAD_bus2ip_rdce_i_9(.PAD(Bus2IP_RdCE[9]), .Y(Bus2IP_RdCE_I[9]));
	ICP PAD_bus2ip_rdce_i_10(.PAD(Bus2IP_RdCE[10]), .Y(Bus2IP_RdCE_I[10]));
	ICP PAD_bus2ip_rdce_i_11(.PAD(Bus2IP_RdCE[11]), .Y(Bus2IP_RdCE_I[11]));
	ICP PAD_bus2ip_rdce_i_12(.PAD(Bus2IP_RdCE[12]), .Y(Bus2IP_RdCE_I[12]));
	ICP PAD_bus2ip_rdce_i_13(.PAD(Bus2IP_RdCE[13]), .Y(Bus2IP_RdCE_I[13]));
	ICP PAD_bus2ip_rdce_i_14(.PAD(Bus2IP_RdCE[14]), .Y(Bus2IP_RdCE_I[14]));
	ICP PAD_bus2ip_wrce_i_0(.PAD(Bus2IP_WrCE[0]), .Y(Bus2IP_WrCE_I[0]));
	ICP PAD_bus2ip_wrce_i_1(.PAD(Bus2IP_WrCE[1]), .Y(Bus2IP_WrCE_I[1]));
	ICP PAD_bus2ip_wrce_i_2(.PAD(Bus2IP_WrCE[2]), .Y(Bus2IP_WrCE_I[2]));
	ICP PAD_bus2ip_wrce_i_3(.PAD(Bus2IP_WrCE[3]), .Y(Bus2IP_WrCE_I[3]));
	ICP PAD_bus2ip_wrce_i_4(.PAD(Bus2IP_WrCE[4]), .Y(Bus2IP_WrCE_I[4]));
	ICP PAD_bus2ip_wrce_i_5(.PAD(Bus2IP_WrCE[5]), .Y(Bus2IP_WrCE_I[5]));
	ICP PAD_bus2ip_wrce_i_6(.PAD(Bus2IP_WrCE[6]), .Y(Bus2IP_WrCE_I[6]));
	ICP PAD_bus2ip_wrce_i_7(.PAD(Bus2IP_WrCE[7]), .Y(Bus2IP_WrCE_I[7]));
	ICP PAD_bus2ip_wrce_i_8(.PAD(Bus2IP_WrCE[8]), .Y(Bus2IP_WrCE_I[8]));
	ICP PAD_bus2ip_wrce_i_9(.PAD(Bus2IP_WrCE[9]), .Y(Bus2IP_WrCE_I[9]));
	ICP PAD_bus2ip_wrce_i_10(.PAD(Bus2IP_WrCE[10]), .Y(Bus2IP_WrCE_I[10]));
	ICP PAD_bus2ip_wrce_i_11(.PAD(Bus2IP_WrCE[11]), .Y(Bus2IP_WrCE_I[11]));
	ICP PAD_bus2ip_wrce_i_12(.PAD(Bus2IP_WrCE[12]), .Y(Bus2IP_WrCE_I[12]));
	ICP PAD_bus2ip_wrce_i_13(.PAD(Bus2IP_WrCE[13]), .Y(Bus2IP_WrCE_I[13]));
	ICP PAD_bus2ip_wrce_i_14(.PAD(Bus2IP_WrCE[14]), .Y(Bus2IP_WrCE_I[14]));

	BD8P PAD_ip2bus_data0_o(.A(IP2Bus_Data_O[0]), .PAD(IP2Bus_Data[0]));
	BD8P PAD_ip2bus_data1_o(.A(IP2Bus_Data_O[1]), .PAD(IP2Bus_Data[1]));
	BD8P PAD_ip2bus_data2_o(.A(IP2Bus_Data_O[2]), .PAD(IP2Bus_Data[2]));
	BD8P PAD_ip2bus_data3_o(.A(IP2Bus_Data_O[3]), .PAD(IP2Bus_Data[3]));
	BD8P PAD_ip2bus_data4_o(.A(IP2Bus_Data_O[4]), .PAD(IP2Bus_Data[4]));
	BD8P PAD_ip2bus_data5_o(.A(IP2Bus_Data_O[5]), .PAD(IP2Bus_Data[5]));
	BD8P PAD_ip2bus_data6_o(.A(IP2Bus_Data_O[6]), .PAD(IP2Bus_Data[6]));
	BD8P PAD_ip2bus_data7_o(.A(IP2Bus_Data_O[7]), .PAD(IP2Bus_Data[7]));
	BD8P PAD_user_int_o(.A(user_int_O), .PAD(user_int));*/

module top(nM1, nMREQ, nIORQ, nRD, nWR, nRFSH, nHALT,
     nBUSACK, nWAIT, nINT, nNMI, nRESET, nBUSRQ, CLK, A, D);

	input nWAIT, nINT, nNMI, nRESET, nBUSRQ, CLK;
  	output nM1, nMREQ, nIORQ, nRD, nWR, nRFSH, nHALT, nBUSACK;
  	output [15:0] A;
  	inout [7:0] D;

	wire nWAIT_I, nINT_I, nNMI_I, nRESET_I, nBUSRQ_I, CLK_I;
  	wire nM1_O, nMREQ_O, nIORQ_O, nRD_O, nWR_O, nRFSH_O, nHALT_O, nBUSACK_O;
  	wire [15:0] A_O;
  	wire [7:0] D_I;

	z80_top_direct_n top_INST(
		.nM1(nM1_O),
		.nMREQ(nMREQ_O),
		.nIORQ(nIORQ_O),
		.nRD(nRD_O),
		.nWR(nWR_O),
		.nRFSH(nRFSH_O),
		.nHALT(nHALT_O),
		.nBUSACK(nBUSACK_O),
		.nWAIT(nWAIT_I),
		.nINT(nINT_I),
		.nNMI(nNMI_I),
		.nRESET(nRESET_I),
		.nBUSRQ(nBUSRQ_I),
		.CLK(CLK_I),
		.A(A_O),
		.D(D_I)
	);

	iopads IOPADS_INST(
		.nM1(nM1),
		.nMREQ(nMREQ),
		.nIORQ(nIORQ),
		.nRD(nRD),
		.nWR(nWR),
		.nRFSH(nRFSH),
		.nHALT(nHALT),
		.nBUSACK(nBUSACK),
		.nWAIT(nWAIT),
		.nINT(nINT),
		.nNMI(nNMI),
		.nRESET(nRESET),
		.nBUSRQ(nBUSRQ),
		.CLK(CLK),
		.A(A),
		.D(D),

		.nM1_O(nM1_O),
		.nMREQ_O(nMREQ_O),
		.nIORQ_O(nIORQ_O),
		.nRD_O(nRD_O),
		.nWR_O(nWR_O),
		.nRFSH_O(nRFSH_O),
		.nHALT_O(nHALT_O),
		.nBUSACK_O(nBUSACK_O),
		.nWAIT_I(nWAIT_I),
		.nINT_I(nINT_I),
		.nNMI_I(nNMI_I),
		.nRESET_I(nRESET_I),
		.nBUSRQ_I(nBUSRQ_I),
		.CLK_I(CLK_I),
		.A_O(A_O),
		.D_I(D_I)
	);
endmodule
