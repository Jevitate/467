// soc_system_mm_interconnect_2.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module soc_system_mm_interconnect_2 (
		input  wire        clk_hps_clk_clk,                                          //                                        clk_hps_clk.clk
		input  wire        jtag_mm1_clk_reset_reset_bridge_in_reset_reset,           //           jtag_mm1_clk_reset_reset_bridge_in_reset.reset
		input  wire        Qsys_top_alu_control_0_reset_reset_bridge_in_reset_reset, // Qsys_top_alu_control_0_reset_reset_bridge_in_reset.reset
		input  wire [31:0] jtag_mm1_master_address,                                  //                                    jtag_mm1_master.address
		output wire        jtag_mm1_master_waitrequest,                              //                                                   .waitrequest
		input  wire [3:0]  jtag_mm1_master_byteenable,                               //                                                   .byteenable
		input  wire        jtag_mm1_master_read,                                     //                                                   .read
		output wire [31:0] jtag_mm1_master_readdata,                                 //                                                   .readdata
		output wire        jtag_mm1_master_readdatavalid,                            //                                                   .readdatavalid
		input  wire        jtag_mm1_master_write,                                    //                                                   .write
		input  wire [31:0] jtag_mm1_master_writedata,                                //                                                   .writedata
		output wire [2:0]  Qsys_top_alu_control_0_s1_address,                        //                          Qsys_top_alu_control_0_s1.address
		output wire        Qsys_top_alu_control_0_s1_write,                          //                                                   .write
		output wire        Qsys_top_alu_control_0_s1_read,                           //                                                   .read
		input  wire [31:0] Qsys_top_alu_control_0_s1_readdata,                       //                                                   .readdata
		output wire [31:0] Qsys_top_alu_control_0_s1_writedata                       //                                                   .writedata
	);

	wire         jtag_mm1_master_translator_avalon_universal_master_0_waitrequest;   // Qsys_top_alu_control_0_s1_translator:uav_waitrequest -> jtag_mm1_master_translator:uav_waitrequest
	wire  [31:0] jtag_mm1_master_translator_avalon_universal_master_0_readdata;      // Qsys_top_alu_control_0_s1_translator:uav_readdata -> jtag_mm1_master_translator:uav_readdata
	wire         jtag_mm1_master_translator_avalon_universal_master_0_debugaccess;   // jtag_mm1_master_translator:uav_debugaccess -> Qsys_top_alu_control_0_s1_translator:uav_debugaccess
	wire  [31:0] jtag_mm1_master_translator_avalon_universal_master_0_address;       // jtag_mm1_master_translator:uav_address -> Qsys_top_alu_control_0_s1_translator:uav_address
	wire         jtag_mm1_master_translator_avalon_universal_master_0_read;          // jtag_mm1_master_translator:uav_read -> Qsys_top_alu_control_0_s1_translator:uav_read
	wire   [3:0] jtag_mm1_master_translator_avalon_universal_master_0_byteenable;    // jtag_mm1_master_translator:uav_byteenable -> Qsys_top_alu_control_0_s1_translator:uav_byteenable
	wire         jtag_mm1_master_translator_avalon_universal_master_0_readdatavalid; // Qsys_top_alu_control_0_s1_translator:uav_readdatavalid -> jtag_mm1_master_translator:uav_readdatavalid
	wire         jtag_mm1_master_translator_avalon_universal_master_0_lock;          // jtag_mm1_master_translator:uav_lock -> Qsys_top_alu_control_0_s1_translator:uav_lock
	wire         jtag_mm1_master_translator_avalon_universal_master_0_write;         // jtag_mm1_master_translator:uav_write -> Qsys_top_alu_control_0_s1_translator:uav_write
	wire  [31:0] jtag_mm1_master_translator_avalon_universal_master_0_writedata;     // jtag_mm1_master_translator:uav_writedata -> Qsys_top_alu_control_0_s1_translator:uav_writedata
	wire   [2:0] jtag_mm1_master_translator_avalon_universal_master_0_burstcount;    // jtag_mm1_master_translator:uav_burstcount -> Qsys_top_alu_control_0_s1_translator:uav_burstcount

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (32),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (32),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (0),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) jtag_mm1_master_translator (
		.clk                    (clk_hps_clk_clk),                                                    //                       clk.clk
		.reset                  (Qsys_top_alu_control_0_reset_reset_bridge_in_reset_reset),           //                     reset.reset
		.uav_address            (jtag_mm1_master_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount         (jtag_mm1_master_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read               (jtag_mm1_master_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write              (jtag_mm1_master_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest        (jtag_mm1_master_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid      (jtag_mm1_master_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable         (jtag_mm1_master_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata           (jtag_mm1_master_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata          (jtag_mm1_master_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock               (jtag_mm1_master_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess        (jtag_mm1_master_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address             (jtag_mm1_master_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest         (jtag_mm1_master_waitrequest),                                        //                          .waitrequest
		.av_byteenable          (jtag_mm1_master_byteenable),                                         //                          .byteenable
		.av_read                (jtag_mm1_master_read),                                               //                          .read
		.av_readdata            (jtag_mm1_master_readdata),                                           //                          .readdata
		.av_readdatavalid       (jtag_mm1_master_readdatavalid),                                      //                          .readdatavalid
		.av_write               (jtag_mm1_master_write),                                              //                          .write
		.av_writedata           (jtag_mm1_master_writedata),                                          //                          .writedata
		.av_burstcount          (1'b1),                                                               //               (terminated)
		.av_beginbursttransfer  (1'b0),                                                               //               (terminated)
		.av_begintransfer       (1'b0),                                                               //               (terminated)
		.av_chipselect          (1'b0),                                                               //               (terminated)
		.av_lock                (1'b0),                                                               //               (terminated)
		.av_debugaccess         (1'b0),                                                               //               (terminated)
		.uav_clken              (),                                                                   //               (terminated)
		.av_clken               (1'b1),                                                               //               (terminated)
		.uav_response           (2'b00),                                                              //               (terminated)
		.av_response            (),                                                                   //               (terminated)
		.uav_writeresponsevalid (1'b0),                                                               //               (terminated)
		.av_writeresponsevalid  ()                                                                    //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (3),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (32),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) qsys_top_alu_control_0_s1_translator (
		.clk                    (clk_hps_clk_clk),                                                    //                      clk.clk
		.reset                  (Qsys_top_alu_control_0_reset_reset_bridge_in_reset_reset),           //                    reset.reset
		.uav_address            (jtag_mm1_master_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount         (jtag_mm1_master_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read               (jtag_mm1_master_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write              (jtag_mm1_master_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest        (jtag_mm1_master_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid      (jtag_mm1_master_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable         (jtag_mm1_master_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata           (jtag_mm1_master_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata          (jtag_mm1_master_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock               (jtag_mm1_master_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess        (jtag_mm1_master_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address             (Qsys_top_alu_control_0_s1_address),                                  //      avalon_anti_slave_0.address
		.av_write               (Qsys_top_alu_control_0_s1_write),                                    //                         .write
		.av_read                (Qsys_top_alu_control_0_s1_read),                                     //                         .read
		.av_readdata            (Qsys_top_alu_control_0_s1_readdata),                                 //                         .readdata
		.av_writedata           (Qsys_top_alu_control_0_s1_writedata),                                //                         .writedata
		.av_begintransfer       (),                                                                   //              (terminated)
		.av_beginbursttransfer  (),                                                                   //              (terminated)
		.av_burstcount          (),                                                                   //              (terminated)
		.av_byteenable          (),                                                                   //              (terminated)
		.av_readdatavalid       (1'b0),                                                               //              (terminated)
		.av_waitrequest         (1'b0),                                                               //              (terminated)
		.av_writebyteenable     (),                                                                   //              (terminated)
		.av_lock                (),                                                                   //              (terminated)
		.av_chipselect          (),                                                                   //              (terminated)
		.av_clken               (),                                                                   //              (terminated)
		.uav_clken              (1'b0),                                                               //              (terminated)
		.av_debugaccess         (),                                                                   //              (terminated)
		.av_outputenable        (),                                                                   //              (terminated)
		.uav_response           (),                                                                   //              (terminated)
		.av_response            (2'b00),                                                              //              (terminated)
		.uav_writeresponsevalid (),                                                                   //              (terminated)
		.av_writeresponsevalid  (1'b0)                                                                //              (terminated)
	);

endmodule