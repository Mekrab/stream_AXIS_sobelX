// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Fri May  1 18:07:50 2020
// Host        : HiveMind running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/Clarke/Desktop/Hardware-Software
//               Interface/Lab8/stream_AXIS/stream_AXIS.srcs/sources_1/bd/design_1/ip/design_1_stream_0_0/design_1_stream_0_0_stub.v}
// Design      : design_1_stream_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "stream_v1_0,Vivado 2018.3" *)
module design_1_stream_0_0(m00_axis_tdata, m00_axis_tlast, 
  m00_axis_tvalid, m00_axis_tready, m00_axis_aclk, m00_axis_aresetn, s00_axis_tdata, 
  s00_axis_tlast, s00_axis_tvalid, s00_axis_tready, s00_axis_aclk, s00_axis_aresetn)
/* synthesis syn_black_box black_box_pad_pin="m00_axis_tdata[31:0],m00_axis_tlast,m00_axis_tvalid,m00_axis_tready,m00_axis_aclk,m00_axis_aresetn,s00_axis_tdata[31:0],s00_axis_tlast,s00_axis_tvalid,s00_axis_tready,s00_axis_aclk,s00_axis_aresetn" */;
  output [31:0]m00_axis_tdata;
  output m00_axis_tlast;
  output m00_axis_tvalid;
  input m00_axis_tready;
  input m00_axis_aclk;
  input m00_axis_aresetn;
  input [31:0]s00_axis_tdata;
  input s00_axis_tlast;
  input s00_axis_tvalid;
  output s00_axis_tready;
  input s00_axis_aclk;
  input s00_axis_aresetn;
endmodule
