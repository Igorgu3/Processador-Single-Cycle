-- Copyright (C) 2025  Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Altera and sold by Altera or its authorized distributors.  Please
-- refer to the Altera Software License Subscription Agreements 
-- on the Quartus Prime software download page.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 24.1std.0 Build 1077 03/04/2025 SC Lite Edition"

-- DATE "11/21/2026 17:52:41"

-- 
-- Device: Altera 5CGXFC7C7F23C8 Package FBGA484
-- 

-- 
-- This VHDL file should be used for Questa Intel FPGA (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	src_top_board IS
    PORT (
	SW : IN std_logic_vector(11 DOWNTO 0);
	LEDR : OUT std_logic_vector(9 DOWNTO 0);
	HEX0 : OUT std_logic_vector(6 DOWNTO 0);
	HEX1 : OUT std_logic_vector(6 DOWNTO 0);
	HEX2 : OUT std_logic_vector(6 DOWNTO 0);
	HEX3 : OUT std_logic_vector(6 DOWNTO 0)
	);
END src_top_board;

-- Design Ports Information
-- LEDR[0]	=>  Location: PIN_Y21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[1]	=>  Location: PIN_M21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[2]	=>  Location: PIN_Y22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[3]	=>  Location: PIN_P14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[4]	=>  Location: PIN_V21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[5]	=>  Location: PIN_P16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[6]	=>  Location: PIN_K17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[7]	=>  Location: PIN_U21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[8]	=>  Location: PIN_K16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDR[9]	=>  Location: PIN_M7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[0]	=>  Location: PIN_N20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[1]	=>  Location: PIN_U17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[2]	=>  Location: PIN_M18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[3]	=>  Location: PIN_U20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[4]	=>  Location: PIN_R21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[5]	=>  Location: PIN_P22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX0[6]	=>  Location: PIN_R16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[0]	=>  Location: PIN_Y19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[1]	=>  Location: PIN_AA12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[2]	=>  Location: PIN_L18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[3]	=>  Location: PIN_W21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[4]	=>  Location: PIN_W22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[5]	=>  Location: PIN_L22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX1[6]	=>  Location: PIN_M20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX2[0]	=>  Location: PIN_P18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX2[1]	=>  Location: PIN_R15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX2[2]	=>  Location: PIN_P19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX2[3]	=>  Location: PIN_N21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX2[4]	=>  Location: PIN_P17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX2[5]	=>  Location: PIN_R17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX2[6]	=>  Location: PIN_T22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX3[0]	=>  Location: PIN_U22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX3[1]	=>  Location: PIN_V6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX3[2]	=>  Location: PIN_T15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX3[3]	=>  Location: PIN_V18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX3[4]	=>  Location: PIN_N19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX3[5]	=>  Location: PIN_R22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HEX3[6]	=>  Location: PIN_AB17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[8]	=>  Location: PIN_U16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[6]	=>  Location: PIN_T19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[7]	=>  Location: PIN_T17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[9]	=>  Location: PIN_N16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[10]	=>  Location: PIN_T18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[11]	=>  Location: PIN_T20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[0]	=>  Location: PIN_K22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[1]	=>  Location: PIN_M22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[2]	=>  Location: PIN_M16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[3]	=>  Location: PIN_V19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[4]	=>  Location: PIN_L17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[5]	=>  Location: PIN_U15,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF src_top_board IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_SW : std_logic_vector(11 DOWNTO 0);
SIGNAL ww_LEDR : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_HEX0 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_HEX1 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_HEX2 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_HEX3 : std_logic_vector(6 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \SW[6]~input_o\ : std_logic;
SIGNAL \SW[7]~input_o\ : std_logic;
SIGNAL \SW[8]~input_o\ : std_logic;
SIGNAL \SW[11]~input_o\ : std_logic;
SIGNAL \SW[10]~input_o\ : std_logic;
SIGNAL \SW[9]~input_o\ : std_logic;
SIGNAL \u_dut|u_control|Mux4~0_combout\ : std_logic;
SIGNAL \u_dut|u_control|Mux3~0_combout\ : std_logic;
SIGNAL \u_dut|u_control|Mux5~0_combout\ : std_logic;
SIGNAL \u_dut|u_control|Mux6~0_combout\ : std_logic;
SIGNAL \u_dut|u_control|Mux2~0_combout\ : std_logic;
SIGNAL \u_dut|u_control|Mux1~0_combout\ : std_logic;
SIGNAL \SW[1]~input_o\ : std_logic;
SIGNAL \SW[2]~input_o\ : std_logic;
SIGNAL \SW[0]~input_o\ : std_logic;
SIGNAL \SW[3]~input_o\ : std_logic;
SIGNAL \u_dut|u_decoder|Mux1~0_combout\ : std_logic;
SIGNAL \SW[5]~input_o\ : std_logic;
SIGNAL \SW[4]~input_o\ : std_logic;
SIGNAL \u_hex_f_hi|Mux1~0_combout\ : std_logic;
SIGNAL \u_dut|u_decoder|Mux3~0_combout\ : std_logic;
SIGNAL \u_dut|u_decoder|Mux2~0_combout\ : std_logic;
SIGNAL \u_hex_ctrl|Mux6~0_combout\ : std_logic;
SIGNAL \u_hex_ctrl|Mux5~0_combout\ : std_logic;
SIGNAL \u_hex_ctrl|Mux4~0_combout\ : std_logic;
SIGNAL \u_hex_ctrl|Mux3~0_combout\ : std_logic;
SIGNAL \u_hex_ctrl|Mux2~0_combout\ : std_logic;
SIGNAL \u_hex_ctrl|Mux1~0_combout\ : std_logic;
SIGNAL \u_hex_ctrl|Mux0~0_combout\ : std_logic;
SIGNAL \u_hex_aluop|Mux1~0_combout\ : std_logic;
SIGNAL \u_hex_f_lo|Mux6~0_combout\ : std_logic;
SIGNAL \u_hex_f_lo|Mux5~0_combout\ : std_logic;
SIGNAL \u_hex_f_lo|Mux4~0_combout\ : std_logic;
SIGNAL \u_hex_f_lo|Mux3~0_combout\ : std_logic;
SIGNAL \u_hex_f_lo|Mux2~0_combout\ : std_logic;
SIGNAL \u_hex_f_lo|Mux1~0_combout\ : std_logic;
SIGNAL \u_hex_f_lo|Mux0~0_combout\ : std_logic;
SIGNAL \u_hex_f_hi|Mux1~1_combout\ : std_logic;
SIGNAL \u_hex_f_hi|Mux1~2_combout\ : std_logic;
SIGNAL \ALT_INV_SW[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[11]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[10]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[9]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[8]~input_o\ : std_logic;
SIGNAL \u_dut|u_control|ALT_INV_Mux1~0_combout\ : std_logic;
SIGNAL \u_hex_f_lo|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \u_dut|u_decoder|ALT_INV_Mux3~0_combout\ : std_logic;
SIGNAL \u_dut|u_decoder|ALT_INV_Mux2~0_combout\ : std_logic;
SIGNAL \u_hex_f_hi|ALT_INV_Mux1~0_combout\ : std_logic;
SIGNAL \u_dut|u_decoder|ALT_INV_Mux1~0_combout\ : std_logic;
SIGNAL \u_dut|u_control|ALT_INV_Mux3~0_combout\ : std_logic;
SIGNAL \u_dut|u_control|ALT_INV_Mux4~0_combout\ : std_logic;

BEGIN

ww_SW <= SW;
LEDR <= ww_LEDR;
HEX0 <= ww_HEX0;
HEX1 <= ww_HEX1;
HEX2 <= ww_HEX2;
HEX3 <= ww_HEX3;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_SW[5]~input_o\ <= NOT \SW[5]~input_o\;
\ALT_INV_SW[4]~input_o\ <= NOT \SW[4]~input_o\;
\ALT_INV_SW[3]~input_o\ <= NOT \SW[3]~input_o\;
\ALT_INV_SW[2]~input_o\ <= NOT \SW[2]~input_o\;
\ALT_INV_SW[1]~input_o\ <= NOT \SW[1]~input_o\;
\ALT_INV_SW[0]~input_o\ <= NOT \SW[0]~input_o\;
\ALT_INV_SW[11]~input_o\ <= NOT \SW[11]~input_o\;
\ALT_INV_SW[10]~input_o\ <= NOT \SW[10]~input_o\;
\ALT_INV_SW[9]~input_o\ <= NOT \SW[9]~input_o\;
\ALT_INV_SW[7]~input_o\ <= NOT \SW[7]~input_o\;
\ALT_INV_SW[6]~input_o\ <= NOT \SW[6]~input_o\;
\ALT_INV_SW[8]~input_o\ <= NOT \SW[8]~input_o\;
\u_dut|u_control|ALT_INV_Mux1~0_combout\ <= NOT \u_dut|u_control|Mux1~0_combout\;
\u_hex_f_lo|ALT_INV_Mux0~0_combout\ <= NOT \u_hex_f_lo|Mux0~0_combout\;
\u_dut|u_decoder|ALT_INV_Mux3~0_combout\ <= NOT \u_dut|u_decoder|Mux3~0_combout\;
\u_dut|u_decoder|ALT_INV_Mux2~0_combout\ <= NOT \u_dut|u_decoder|Mux2~0_combout\;
\u_hex_f_hi|ALT_INV_Mux1~0_combout\ <= NOT \u_hex_f_hi|Mux1~0_combout\;
\u_dut|u_decoder|ALT_INV_Mux1~0_combout\ <= NOT \u_dut|u_decoder|Mux1~0_combout\;
\u_dut|u_control|ALT_INV_Mux3~0_combout\ <= NOT \u_dut|u_control|Mux3~0_combout\;
\u_dut|u_control|ALT_INV_Mux4~0_combout\ <= NOT \u_dut|u_control|Mux4~0_combout\;

-- Location: IOOBUF_X68_Y0_N53
\LEDR[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_dut|u_control|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_LEDR(0));

-- Location: IOOBUF_X89_Y37_N56
\LEDR[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_dut|u_control|Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_LEDR(1));

-- Location: IOOBUF_X66_Y0_N93
\LEDR[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_dut|u_control|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_LEDR(2));

-- Location: IOOBUF_X68_Y0_N19
\LEDR[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_dut|u_control|Mux5~0_combout\,
	devoe => ww_devoe,
	o => ww_LEDR(3));

-- Location: IOOBUF_X70_Y0_N36
\LEDR[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_dut|u_control|Mux6~0_combout\,
	devoe => ww_devoe,
	o => ww_LEDR(4));

-- Location: IOOBUF_X89_Y9_N5
\LEDR[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_dut|u_control|Mux2~0_combout\,
	devoe => ww_devoe,
	o => ww_LEDR(5));

-- Location: IOOBUF_X89_Y37_N5
\LEDR[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_dut|u_control|Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_LEDR(6));

-- Location: IOOBUF_X72_Y0_N53
\LEDR[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_dut|u_control|ALT_INV_Mux1~0_combout\,
	devoe => ww_devoe,
	o => ww_LEDR(7));

-- Location: IOOBUF_X64_Y81_N53
\LEDR[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDR(8));

-- Location: IOOBUF_X8_Y0_N2
\LEDR[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDR(9));

-- Location: IOOBUF_X89_Y35_N79
\HEX0[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_ctrl|Mux6~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(0));

-- Location: IOOBUF_X72_Y0_N2
\HEX0[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_ctrl|Mux5~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(1));

-- Location: IOOBUF_X89_Y36_N22
\HEX0[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_ctrl|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(2));

-- Location: IOOBUF_X72_Y0_N36
\HEX0[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_ctrl|Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(3));

-- Location: IOOBUF_X89_Y8_N39
\HEX0[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_ctrl|Mux2~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(4));

-- Location: IOOBUF_X89_Y8_N56
\HEX0[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_ctrl|Mux1~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(5));

-- Location: IOOBUF_X89_Y8_N5
\HEX0[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_ctrl|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX0(6));

-- Location: IOOBUF_X66_Y0_N42
\HEX1[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_dut|u_control|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX1(0));

-- Location: IOOBUF_X40_Y0_N36
\HEX1[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_HEX1(1));

-- Location: IOOBUF_X89_Y38_N22
\HEX1[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_dut|u_control|Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX1(2));

-- Location: IOOBUF_X68_Y0_N36
\HEX1[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_dut|u_control|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX1(3));

-- Location: IOOBUF_X66_Y0_N76
\HEX1[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_dut|u_control|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX1(4));

-- Location: IOOBUF_X89_Y36_N56
\HEX1[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_aluop|Mux1~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX1(5));

-- Location: IOOBUF_X89_Y37_N39
\HEX1[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_dut|u_control|ALT_INV_Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX1(6));

-- Location: IOOBUF_X89_Y9_N56
\HEX2[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_f_lo|Mux6~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX2(0));

-- Location: IOOBUF_X89_Y6_N22
\HEX2[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_f_lo|Mux5~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX2(1));

-- Location: IOOBUF_X89_Y9_N39
\HEX2[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_f_lo|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX2(2));

-- Location: IOOBUF_X89_Y35_N96
\HEX2[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_f_lo|Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX2(3));

-- Location: IOOBUF_X89_Y9_N22
\HEX2[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_f_lo|Mux2~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX2(4));

-- Location: IOOBUF_X89_Y8_N22
\HEX2[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_f_lo|Mux1~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX2(5));

-- Location: IOOBUF_X89_Y6_N39
\HEX2[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_f_lo|ALT_INV_Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX2(6));

-- Location: IOOBUF_X70_Y0_N53
\HEX3[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_f_hi|Mux1~1_combout\,
	devoe => ww_devoe,
	o => ww_HEX3(0));

-- Location: IOOBUF_X6_Y0_N36
\HEX3[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_HEX3(1));

-- Location: IOOBUF_X89_Y6_N5
\HEX3[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_f_hi|Mux1~0_combout\,
	devoe => ww_devoe,
	o => ww_HEX3(2));

-- Location: IOOBUF_X70_Y0_N2
\HEX3[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_f_hi|Mux1~1_combout\,
	devoe => ww_devoe,
	o => ww_HEX3(3));

-- Location: IOOBUF_X89_Y36_N5
\HEX3[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SW[4]~input_o\,
	devoe => ww_devoe,
	o => ww_HEX3(4));

-- Location: IOOBUF_X89_Y6_N56
\HEX3[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \u_hex_f_hi|Mux1~2_combout\,
	devoe => ww_devoe,
	o => ww_HEX3(5));

-- Location: IOOBUF_X56_Y0_N53
\HEX3[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_SW[5]~input_o\,
	devoe => ww_devoe,
	o => ww_HEX3(6));

-- Location: IOIBUF_X89_Y4_N78
\SW[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(6),
	o => \SW[6]~input_o\);

-- Location: IOIBUF_X89_Y4_N61
\SW[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(7),
	o => \SW[7]~input_o\);

-- Location: IOIBUF_X72_Y0_N18
\SW[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(8),
	o => \SW[8]~input_o\);

-- Location: IOIBUF_X89_Y4_N95
\SW[11]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(11),
	o => \SW[11]~input_o\);

-- Location: IOIBUF_X89_Y4_N44
\SW[10]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(10),
	o => \SW[10]~input_o\);

-- Location: IOIBUF_X89_Y35_N44
\SW[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(9),
	o => \SW[9]~input_o\);

-- Location: MLABCELL_X82_Y4_N0
\u_dut|u_control|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_dut|u_control|Mux4~0_combout\ = ( !\SW[10]~input_o\ & ( !\SW[9]~input_o\ & ( (!\SW[6]~input_o\ & (!\SW[7]~input_o\ & (\SW[8]~input_o\ & !\SW[11]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000100000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[6]~input_o\,
	datab => \ALT_INV_SW[7]~input_o\,
	datac => \ALT_INV_SW[8]~input_o\,
	datad => \ALT_INV_SW[11]~input_o\,
	datae => \ALT_INV_SW[10]~input_o\,
	dataf => \ALT_INV_SW[9]~input_o\,
	combout => \u_dut|u_control|Mux4~0_combout\);

-- Location: MLABCELL_X82_Y4_N6
\u_dut|u_control|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_dut|u_control|Mux3~0_combout\ = ( !\SW[10]~input_o\ & ( !\SW[9]~input_o\ & ( (!\SW[6]~input_o\ & (!\SW[7]~input_o\ & (!\SW[8]~input_o\ & !\SW[11]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[6]~input_o\,
	datab => \ALT_INV_SW[7]~input_o\,
	datac => \ALT_INV_SW[8]~input_o\,
	datad => \ALT_INV_SW[11]~input_o\,
	datae => \ALT_INV_SW[10]~input_o\,
	dataf => \ALT_INV_SW[9]~input_o\,
	combout => \u_dut|u_control|Mux3~0_combout\);

-- Location: MLABCELL_X82_Y4_N42
\u_dut|u_control|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_dut|u_control|Mux5~0_combout\ = ( !\SW[10]~input_o\ & ( \SW[9]~input_o\ & ( (\SW[6]~input_o\ & (\SW[7]~input_o\ & (!\SW[8]~input_o\ & \SW[11]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000100000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[6]~input_o\,
	datab => \ALT_INV_SW[7]~input_o\,
	datac => \ALT_INV_SW[8]~input_o\,
	datad => \ALT_INV_SW[11]~input_o\,
	datae => \ALT_INV_SW[10]~input_o\,
	dataf => \ALT_INV_SW[9]~input_o\,
	combout => \u_dut|u_control|Mux5~0_combout\);

-- Location: MLABCELL_X82_Y4_N18
\u_dut|u_control|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_dut|u_control|Mux6~0_combout\ = ( !\SW[10]~input_o\ & ( !\SW[9]~input_o\ & ( (\SW[6]~input_o\ & (\SW[7]~input_o\ & (!\SW[8]~input_o\ & \SW[11]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000010000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[6]~input_o\,
	datab => \ALT_INV_SW[7]~input_o\,
	datac => \ALT_INV_SW[8]~input_o\,
	datad => \ALT_INV_SW[11]~input_o\,
	datae => \ALT_INV_SW[10]~input_o\,
	dataf => \ALT_INV_SW[9]~input_o\,
	combout => \u_dut|u_control|Mux6~0_combout\);

-- Location: MLABCELL_X82_Y4_N54
\u_dut|u_control|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_dut|u_control|Mux2~0_combout\ = ( !\SW[10]~input_o\ & ( \SW[9]~input_o\ & ( (!\SW[8]~input_o\ & ((!\SW[6]~input_o\ & (!\SW[7]~input_o\ & !\SW[11]~input_o\)) # (\SW[6]~input_o\ & (\SW[7]~input_o\ & \SW[11]~input_o\)))) ) ) ) # ( !\SW[10]~input_o\ & ( 
-- !\SW[9]~input_o\ & ( (\SW[6]~input_o\ & (\SW[7]~input_o\ & (!\SW[8]~input_o\ & \SW[11]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000010000000000000000000010000000000100000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[6]~input_o\,
	datab => \ALT_INV_SW[7]~input_o\,
	datac => \ALT_INV_SW[8]~input_o\,
	datad => \ALT_INV_SW[11]~input_o\,
	datae => \ALT_INV_SW[10]~input_o\,
	dataf => \ALT_INV_SW[9]~input_o\,
	combout => \u_dut|u_control|Mux2~0_combout\);

-- Location: MLABCELL_X82_Y4_N48
\u_dut|u_control|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_dut|u_control|Mux1~0_combout\ = ( \SW[10]~input_o\ & ( \SW[9]~input_o\ ) ) # ( !\SW[10]~input_o\ & ( \SW[9]~input_o\ & ( (((\SW[11]~input_o\) # (\SW[8]~input_o\)) # (\SW[7]~input_o\)) # (\SW[6]~input_o\) ) ) ) # ( \SW[10]~input_o\ & ( !\SW[9]~input_o\ 
-- ) ) # ( !\SW[10]~input_o\ & ( !\SW[9]~input_o\ & ( ((!\SW[6]~input_o\ & ((\SW[11]~input_o\) # (\SW[7]~input_o\))) # (\SW[6]~input_o\ & ((!\SW[7]~input_o\) # (!\SW[11]~input_o\)))) # (\SW[8]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111111111101111111111111111111101111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[6]~input_o\,
	datab => \ALT_INV_SW[7]~input_o\,
	datac => \ALT_INV_SW[8]~input_o\,
	datad => \ALT_INV_SW[11]~input_o\,
	datae => \ALT_INV_SW[10]~input_o\,
	dataf => \ALT_INV_SW[9]~input_o\,
	combout => \u_dut|u_control|Mux1~0_combout\);

-- Location: IOIBUF_X89_Y36_N38
\SW[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(1),
	o => \SW[1]~input_o\);

-- Location: IOIBUF_X89_Y35_N61
\SW[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(2),
	o => \SW[2]~input_o\);

-- Location: IOIBUF_X89_Y38_N55
\SW[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(0),
	o => \SW[0]~input_o\);

-- Location: IOIBUF_X70_Y0_N18
\SW[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(3),
	o => \SW[3]~input_o\);

-- Location: LABCELL_X88_Y8_N33
\u_dut|u_decoder|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_dut|u_decoder|Mux1~0_combout\ = ( \SW[3]~input_o\ & ( (\SW[1]~input_o\ & !\SW[2]~input_o\) ) ) # ( !\SW[3]~input_o\ & ( (!\SW[2]~input_o\ & !\SW[0]~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1100110000000000110011000000000001000100010001000100010001000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[1]~input_o\,
	datab => \ALT_INV_SW[2]~input_o\,
	datad => \ALT_INV_SW[0]~input_o\,
	dataf => \ALT_INV_SW[3]~input_o\,
	combout => \u_dut|u_decoder|Mux1~0_combout\);

-- Location: IOIBUF_X60_Y0_N1
\SW[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(5),
	o => \SW[5]~input_o\);

-- Location: IOIBUF_X89_Y37_N21
\SW[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(4),
	o => \SW[4]~input_o\);

-- Location: MLABCELL_X82_Y4_N27
\u_hex_f_hi|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_f_hi|Mux1~0_combout\ = (\SW[5]~input_o\ & !\SW[4]~input_o\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100000000000011110000000000001111000000000000111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_SW[5]~input_o\,
	datad => \ALT_INV_SW[4]~input_o\,
	combout => \u_hex_f_hi|Mux1~0_combout\);

-- Location: LABCELL_X88_Y8_N30
\u_dut|u_decoder|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_dut|u_decoder|Mux3~0_combout\ = (\SW[1]~input_o\ & (!\SW[2]~input_o\ & !\SW[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100000001000000010000000100000001000000010000000100000001000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[1]~input_o\,
	datab => \ALT_INV_SW[2]~input_o\,
	datac => \ALT_INV_SW[0]~input_o\,
	combout => \u_dut|u_decoder|Mux3~0_combout\);

-- Location: LABCELL_X88_Y8_N6
\u_dut|u_decoder|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_dut|u_decoder|Mux2~0_combout\ = ( \SW[3]~input_o\ & ( (!\SW[2]~input_o\ & \SW[1]~input_o\) ) ) # ( !\SW[3]~input_o\ & ( (\SW[2]~input_o\ & (!\SW[1]~input_o\ & \SW[0]~input_o\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110000000000000011000000001100000011000000110000001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_SW[2]~input_o\,
	datac => \ALT_INV_SW[1]~input_o\,
	datad => \ALT_INV_SW[0]~input_o\,
	dataf => \ALT_INV_SW[3]~input_o\,
	combout => \u_dut|u_decoder|Mux2~0_combout\);

-- Location: LABCELL_X88_Y8_N12
\u_hex_ctrl|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_ctrl|Mux6~0_combout\ = ( \u_dut|u_control|Mux3~0_combout\ & ( \u_dut|u_decoder|Mux2~0_combout\ & ( (!\u_dut|u_decoder|Mux1~0_combout\ & (\u_hex_f_hi|Mux1~0_combout\ & (!\u_dut|u_control|Mux4~0_combout\ $ (\u_dut|u_decoder|Mux3~0_combout\)))) ) ) ) 
-- # ( \u_dut|u_control|Mux3~0_combout\ & ( !\u_dut|u_decoder|Mux2~0_combout\ & ( (!\u_dut|u_decoder|Mux1~0_combout\ & (\u_hex_f_hi|Mux1~0_combout\ & \u_dut|u_decoder|Mux3~0_combout\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000010001000000000000000000010000000000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \u_dut|u_decoder|ALT_INV_Mux1~0_combout\,
	datab => \u_hex_f_hi|ALT_INV_Mux1~0_combout\,
	datac => \u_dut|u_control|ALT_INV_Mux4~0_combout\,
	datad => \u_dut|u_decoder|ALT_INV_Mux3~0_combout\,
	datae => \u_dut|u_control|ALT_INV_Mux3~0_combout\,
	dataf => \u_dut|u_decoder|ALT_INV_Mux2~0_combout\,
	combout => \u_hex_ctrl|Mux6~0_combout\);

-- Location: MLABCELL_X82_Y4_N30
\u_hex_ctrl|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_ctrl|Mux5~0_combout\ = ( \u_dut|u_decoder|Mux1~0_combout\ & ( \u_dut|u_decoder|Mux3~0_combout\ & ( (!\u_dut|u_control|Mux3~0_combout\ & (((\u_dut|u_control|Mux4~0_combout\)))) # (\u_dut|u_control|Mux3~0_combout\ & (\u_hex_f_hi|Mux1~0_combout\ & 
-- ((!\u_dut|u_decoder|Mux2~0_combout\) # (\u_dut|u_control|Mux4~0_combout\)))) ) ) ) # ( !\u_dut|u_decoder|Mux1~0_combout\ & ( \u_dut|u_decoder|Mux3~0_combout\ & ( (!\u_dut|u_control|Mux4~0_combout\ & (\u_dut|u_decoder|Mux2~0_combout\ & 
-- (\u_hex_f_hi|Mux1~0_combout\ & \u_dut|u_control|Mux3~0_combout\))) # (\u_dut|u_control|Mux4~0_combout\ & (((!\u_dut|u_control|Mux3~0_combout\)))) ) ) ) # ( \u_dut|u_decoder|Mux1~0_combout\ & ( !\u_dut|u_decoder|Mux3~0_combout\ & ( 
-- (\u_dut|u_control|Mux4~0_combout\ & !\u_dut|u_control|Mux3~0_combout\) ) ) ) # ( !\u_dut|u_decoder|Mux1~0_combout\ & ( !\u_dut|u_decoder|Mux3~0_combout\ & ( (\u_dut|u_control|Mux4~0_combout\ & !\u_dut|u_control|Mux3~0_combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100000000000011110000000000001111000100000000111100100011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \u_dut|u_decoder|ALT_INV_Mux2~0_combout\,
	datab => \u_hex_f_hi|ALT_INV_Mux1~0_combout\,
	datac => \u_dut|u_control|ALT_INV_Mux4~0_combout\,
	datad => \u_dut|u_control|ALT_INV_Mux3~0_combout\,
	datae => \u_dut|u_decoder|ALT_INV_Mux1~0_combout\,
	dataf => \u_dut|u_decoder|ALT_INV_Mux3~0_combout\,
	combout => \u_hex_ctrl|Mux5~0_combout\);

-- Location: LABCELL_X88_Y8_N18
\u_hex_ctrl|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_ctrl|Mux4~0_combout\ = ( \u_dut|u_control|Mux3~0_combout\ & ( \u_dut|u_decoder|Mux2~0_combout\ & ( (\u_dut|u_decoder|Mux1~0_combout\ & (\u_hex_f_hi|Mux1~0_combout\ & (\u_dut|u_control|Mux4~0_combout\ & !\u_dut|u_decoder|Mux3~0_combout\))) ) ) ) # ( 
-- !\u_dut|u_control|Mux3~0_combout\ & ( \u_dut|u_decoder|Mux2~0_combout\ & ( !\u_dut|u_control|Mux4~0_combout\ ) ) ) # ( \u_dut|u_control|Mux3~0_combout\ & ( !\u_dut|u_decoder|Mux2~0_combout\ & ( (\u_dut|u_decoder|Mux1~0_combout\ & 
-- (\u_hex_f_hi|Mux1~0_combout\ & !\u_dut|u_decoder|Mux3~0_combout\)) ) ) ) # ( !\u_dut|u_control|Mux3~0_combout\ & ( !\u_dut|u_decoder|Mux2~0_combout\ & ( !\u_dut|u_control|Mux4~0_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000011110000000100010000000011110000111100000000000100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \u_dut|u_decoder|ALT_INV_Mux1~0_combout\,
	datab => \u_hex_f_hi|ALT_INV_Mux1~0_combout\,
	datac => \u_dut|u_control|ALT_INV_Mux4~0_combout\,
	datad => \u_dut|u_decoder|ALT_INV_Mux3~0_combout\,
	datae => \u_dut|u_control|ALT_INV_Mux3~0_combout\,
	dataf => \u_dut|u_decoder|ALT_INV_Mux2~0_combout\,
	combout => \u_hex_ctrl|Mux4~0_combout\);

-- Location: MLABCELL_X82_Y4_N36
\u_hex_ctrl|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_ctrl|Mux3~0_combout\ = ( \u_dut|u_decoder|Mux1~0_combout\ & ( \u_dut|u_decoder|Mux3~0_combout\ & ( (\u_dut|u_decoder|Mux2~0_combout\ & (\u_hex_f_hi|Mux1~0_combout\ & (!\u_dut|u_control|Mux4~0_combout\ & \u_dut|u_control|Mux3~0_combout\))) ) ) ) # ( 
-- !\u_dut|u_decoder|Mux1~0_combout\ & ( \u_dut|u_decoder|Mux3~0_combout\ & ( (\u_hex_f_hi|Mux1~0_combout\ & (\u_dut|u_control|Mux3~0_combout\ & ((!\u_dut|u_decoder|Mux2~0_combout\) # (\u_dut|u_control|Mux4~0_combout\)))) ) ) ) # ( 
-- !\u_dut|u_decoder|Mux1~0_combout\ & ( !\u_dut|u_decoder|Mux3~0_combout\ & ( (\u_dut|u_decoder|Mux2~0_combout\ & (\u_hex_f_hi|Mux1~0_combout\ & (!\u_dut|u_control|Mux4~0_combout\ & \u_dut|u_control|Mux3~0_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000010000000000000000000000000000001000110000000000010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \u_dut|u_decoder|ALT_INV_Mux2~0_combout\,
	datab => \u_hex_f_hi|ALT_INV_Mux1~0_combout\,
	datac => \u_dut|u_control|ALT_INV_Mux4~0_combout\,
	datad => \u_dut|u_control|ALT_INV_Mux3~0_combout\,
	datae => \u_dut|u_decoder|ALT_INV_Mux1~0_combout\,
	dataf => \u_dut|u_decoder|ALT_INV_Mux3~0_combout\,
	combout => \u_hex_ctrl|Mux3~0_combout\);

-- Location: LABCELL_X88_Y8_N54
\u_hex_ctrl|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_ctrl|Mux2~0_combout\ = ( \u_dut|u_control|Mux3~0_combout\ & ( \u_dut|u_decoder|Mux2~0_combout\ & ( (\u_hex_f_hi|Mux1~0_combout\ & ((!\u_dut|u_control|Mux4~0_combout\) # ((!\u_dut|u_decoder|Mux1~0_combout\ & \u_dut|u_decoder|Mux3~0_combout\)))) ) ) 
-- ) # ( \u_dut|u_control|Mux3~0_combout\ & ( !\u_dut|u_decoder|Mux2~0_combout\ & ( (!\u_dut|u_decoder|Mux1~0_combout\ & (\u_hex_f_hi|Mux1~0_combout\ & \u_dut|u_decoder|Mux3~0_combout\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000010001000000000000000000011000000110010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \u_dut|u_decoder|ALT_INV_Mux1~0_combout\,
	datab => \u_hex_f_hi|ALT_INV_Mux1~0_combout\,
	datac => \u_dut|u_control|ALT_INV_Mux4~0_combout\,
	datad => \u_dut|u_decoder|ALT_INV_Mux3~0_combout\,
	datae => \u_dut|u_control|ALT_INV_Mux3~0_combout\,
	dataf => \u_dut|u_decoder|ALT_INV_Mux2~0_combout\,
	combout => \u_hex_ctrl|Mux2~0_combout\);

-- Location: LABCELL_X88_Y8_N0
\u_hex_ctrl|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_ctrl|Mux1~0_combout\ = ( \u_dut|u_control|Mux3~0_combout\ & ( \u_dut|u_decoder|Mux2~0_combout\ & ( (\u_hex_f_hi|Mux1~0_combout\ & ((!\u_dut|u_decoder|Mux1~0_combout\ & (!\u_dut|u_control|Mux4~0_combout\ & !\u_dut|u_decoder|Mux3~0_combout\)) # 
-- (\u_dut|u_decoder|Mux1~0_combout\ & ((!\u_dut|u_control|Mux4~0_combout\) # (!\u_dut|u_decoder|Mux3~0_combout\))))) ) ) ) # ( !\u_dut|u_control|Mux3~0_combout\ & ( \u_dut|u_decoder|Mux2~0_combout\ & ( !\u_dut|u_control|Mux4~0_combout\ ) ) ) # ( 
-- \u_dut|u_control|Mux3~0_combout\ & ( !\u_dut|u_decoder|Mux2~0_combout\ & ( (\u_dut|u_decoder|Mux1~0_combout\ & (\u_hex_f_hi|Mux1~0_combout\ & !\u_dut|u_decoder|Mux3~0_combout\)) ) ) ) # ( !\u_dut|u_control|Mux3~0_combout\ & ( 
-- !\u_dut|u_decoder|Mux2~0_combout\ & ( !\u_dut|u_control|Mux4~0_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000011110000000100010000000011110000111100000011000100010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \u_dut|u_decoder|ALT_INV_Mux1~0_combout\,
	datab => \u_hex_f_hi|ALT_INV_Mux1~0_combout\,
	datac => \u_dut|u_control|ALT_INV_Mux4~0_combout\,
	datad => \u_dut|u_decoder|ALT_INV_Mux3~0_combout\,
	datae => \u_dut|u_control|ALT_INV_Mux3~0_combout\,
	dataf => \u_dut|u_decoder|ALT_INV_Mux2~0_combout\,
	combout => \u_hex_ctrl|Mux1~0_combout\);

-- Location: LABCELL_X88_Y8_N36
\u_hex_ctrl|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_ctrl|Mux0~0_combout\ = ( \u_dut|u_control|Mux3~0_combout\ & ( \u_dut|u_decoder|Mux2~0_combout\ & ( (!\u_hex_f_hi|Mux1~0_combout\) # ((!\u_dut|u_decoder|Mux1~0_combout\ & ((!\u_dut|u_decoder|Mux3~0_combout\))) # (\u_dut|u_decoder|Mux1~0_combout\ & 
-- (!\u_dut|u_control|Mux4~0_combout\ & \u_dut|u_decoder|Mux3~0_combout\))) ) ) ) # ( \u_dut|u_control|Mux3~0_combout\ & ( !\u_dut|u_decoder|Mux2~0_combout\ & ( (!\u_hex_f_hi|Mux1~0_combout\) # ((!\u_dut|u_decoder|Mux1~0_combout\ & 
-- !\u_dut|u_decoder|Mux3~0_combout\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111011101100110000000000000000001110111011011100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \u_dut|u_decoder|ALT_INV_Mux1~0_combout\,
	datab => \u_hex_f_hi|ALT_INV_Mux1~0_combout\,
	datac => \u_dut|u_control|ALT_INV_Mux4~0_combout\,
	datad => \u_dut|u_decoder|ALT_INV_Mux3~0_combout\,
	datae => \u_dut|u_control|ALT_INV_Mux3~0_combout\,
	dataf => \u_dut|u_decoder|ALT_INV_Mux2~0_combout\,
	combout => \u_hex_ctrl|Mux0~0_combout\);

-- Location: MLABCELL_X82_Y4_N24
\u_hex_aluop|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_aluop|Mux1~0_combout\ = ( !\SW[9]~input_o\ & ( (!\SW[10]~input_o\ & (!\SW[7]~input_o\ & (!\SW[6]~input_o\ & !\SW[11]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000100000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[10]~input_o\,
	datab => \ALT_INV_SW[7]~input_o\,
	datac => \ALT_INV_SW[6]~input_o\,
	datad => \ALT_INV_SW[11]~input_o\,
	dataf => \ALT_INV_SW[9]~input_o\,
	combout => \u_hex_aluop|Mux1~0_combout\);

-- Location: LABCELL_X88_Y8_N9
\u_hex_f_lo|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_f_lo|Mux6~0_combout\ = ( \SW[3]~input_o\ & ( (\SW[0]~input_o\ & (!\SW[1]~input_o\ $ (!\SW[2]~input_o\))) ) ) # ( !\SW[3]~input_o\ & ( (!\SW[1]~input_o\ & (!\SW[2]~input_o\ $ (!\SW[0]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001010001000001000101000100000000000011001100000000001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[1]~input_o\,
	datab => \ALT_INV_SW[2]~input_o\,
	datad => \ALT_INV_SW[0]~input_o\,
	dataf => \ALT_INV_SW[3]~input_o\,
	combout => \u_hex_f_lo|Mux6~0_combout\);

-- Location: LABCELL_X88_Y8_N42
\u_hex_f_lo|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_f_lo|Mux5~0_combout\ = ( \SW[3]~input_o\ & ( (!\SW[0]~input_o\ & (\SW[2]~input_o\)) # (\SW[0]~input_o\ & ((\SW[1]~input_o\))) ) ) # ( !\SW[3]~input_o\ & ( (\SW[2]~input_o\ & (!\SW[1]~input_o\ $ (!\SW[0]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001100110000000000110011000000110011000011110011001100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_SW[2]~input_o\,
	datac => \ALT_INV_SW[1]~input_o\,
	datad => \ALT_INV_SW[0]~input_o\,
	dataf => \ALT_INV_SW[3]~input_o\,
	combout => \u_hex_f_lo|Mux5~0_combout\);

-- Location: LABCELL_X88_Y8_N45
\u_hex_f_lo|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_f_lo|Mux4~0_combout\ = ( \SW[3]~input_o\ & ( (\SW[2]~input_o\ & ((!\SW[0]~input_o\) # (\SW[1]~input_o\))) ) ) # ( !\SW[3]~input_o\ & ( (\SW[1]~input_o\ & (!\SW[2]~input_o\ & !\SW[0]~input_o\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010000000000010001000000000000110011000100010011001100010001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[1]~input_o\,
	datab => \ALT_INV_SW[2]~input_o\,
	datad => \ALT_INV_SW[0]~input_o\,
	dataf => \ALT_INV_SW[3]~input_o\,
	combout => \u_hex_f_lo|Mux4~0_combout\);

-- Location: LABCELL_X88_Y8_N48
\u_hex_f_lo|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_f_lo|Mux3~0_combout\ = ( \SW[3]~input_o\ & ( (\SW[1]~input_o\ & (!\SW[2]~input_o\ $ (\SW[0]~input_o\))) ) ) # ( !\SW[3]~input_o\ & ( (!\SW[2]~input_o\ & (!\SW[1]~input_o\ & \SW[0]~input_o\)) # (\SW[2]~input_o\ & (!\SW[1]~input_o\ $ 
-- (\SW[0]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011000011000011001100001100001100001100000000110000110000000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_SW[2]~input_o\,
	datac => \ALT_INV_SW[1]~input_o\,
	datad => \ALT_INV_SW[0]~input_o\,
	dataf => \ALT_INV_SW[3]~input_o\,
	combout => \u_hex_f_lo|Mux3~0_combout\);

-- Location: LABCELL_X88_Y8_N51
\u_hex_f_lo|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_f_lo|Mux2~0_combout\ = ( \SW[3]~input_o\ & ( (!\SW[1]~input_o\ & (!\SW[2]~input_o\ & \SW[0]~input_o\)) ) ) # ( !\SW[3]~input_o\ & ( ((!\SW[1]~input_o\ & \SW[2]~input_o\)) # (\SW[0]~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001011111111001000101111111100000000100010000000000010001000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[1]~input_o\,
	datab => \ALT_INV_SW[2]~input_o\,
	datad => \ALT_INV_SW[0]~input_o\,
	dataf => \ALT_INV_SW[3]~input_o\,
	combout => \u_hex_f_lo|Mux2~0_combout\);

-- Location: LABCELL_X88_Y8_N24
\u_hex_f_lo|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_f_lo|Mux1~0_combout\ = ( \SW[3]~input_o\ & ( (\SW[2]~input_o\ & (!\SW[1]~input_o\ & \SW[0]~input_o\)) ) ) # ( !\SW[3]~input_o\ & ( (!\SW[2]~input_o\ & ((\SW[0]~input_o\) # (\SW[1]~input_o\))) # (\SW[2]~input_o\ & (\SW[1]~input_o\ & 
-- \SW[0]~input_o\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110011001111000011001100111100000000001100000000000000110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_SW[2]~input_o\,
	datac => \ALT_INV_SW[1]~input_o\,
	datad => \ALT_INV_SW[0]~input_o\,
	dataf => \ALT_INV_SW[3]~input_o\,
	combout => \u_hex_f_lo|Mux1~0_combout\);

-- Location: LABCELL_X88_Y8_N27
\u_hex_f_lo|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_f_lo|Mux0~0_combout\ = ( \SW[3]~input_o\ & ( ((!\SW[2]~input_o\) # (\SW[0]~input_o\)) # (\SW[1]~input_o\) ) ) # ( !\SW[3]~input_o\ & ( (!\SW[1]~input_o\ & (\SW[2]~input_o\)) # (\SW[1]~input_o\ & ((!\SW[2]~input_o\) # (!\SW[0]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111011101100110011101110110011011011101111111111101110111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[1]~input_o\,
	datab => \ALT_INV_SW[2]~input_o\,
	datad => \ALT_INV_SW[0]~input_o\,
	dataf => \ALT_INV_SW[3]~input_o\,
	combout => \u_hex_f_lo|Mux0~0_combout\);

-- Location: MLABCELL_X82_Y4_N12
\u_hex_f_hi|Mux1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_f_hi|Mux1~1_combout\ = (\SW[4]~input_o\ & !\SW[5]~input_o\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100010001000100010001000100010001000100010001000100010001000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[4]~input_o\,
	datab => \ALT_INV_SW[5]~input_o\,
	combout => \u_hex_f_hi|Mux1~1_combout\);

-- Location: MLABCELL_X82_Y4_N15
\u_hex_f_hi|Mux1~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \u_hex_f_hi|Mux1~2_combout\ = (\SW[5]~input_o\) # (\SW[4]~input_o\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111011101110111011101110111011101110111011101110111011101110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[4]~input_o\,
	datab => \ALT_INV_SW[5]~input_o\,
	combout => \u_hex_f_hi|Mux1~2_combout\);

-- Location: LABCELL_X63_Y57_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


