--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
--%%                      Centre for Development of Advanced Computing                            %%
--%%                          Vellayambalam, Thiruvananthapuram.                                  %%
--%%==============================================================================================%%
--%% This confidential and proprietary software may be used only as authorised by a licensing     %%
--%% agreement from Centre for Development of Advanced Computing, India (C-DAC).In the event of   %%
--%% publication, the following notice is applicable:                                             %%
--%% Copyright (c) 2025 C-DAC                                                                     %%
--%% ALL RIGHTS RESERVED                                                                          %%
--%% The entire notice above must be reproduced on all authorised copies.                         %%
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--%% File Name        : test_bench.vhd                                                   	      %%
--%% Title            : DVCON System Testbench   						                          %%
--%% Author           : HDG, CDAC Thiruvananthapuram						                      %%
--%% Description      : Testbench for DVCON System vivado Implementation  		                  %%
--%% Version          : 00                                                                        %%
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--%%%%%%%%%%%%%%%%%%%% Modification / Updation  History %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--%%    Date                By              Version          Change Description                   %%
--%%                                                                                              %%
--%%                                                                                              %%
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_bench is
--  Port ( );
end test_bench;

architecture Behavioral of test_bench is

component Top 
port(        
	    --------------- External reset from pin ---------------------
	    rst		                   : IN    STD_LOGIC;
	    serial_rst_n	           : IN    STD_LOGIC;
	    GPIO_rst_dip	           : IN    STD_LOGIC;
	    rst_led		               : OUT   STD_LOGIC;
	    locked_led                 : OUT   STD_LOGIC;
	    proc_beat                  : OUT   STD_LOGIC;

	    --------- differential clock for DDR controller -------------
	    clk_in1_p                  : IN    STD_LOGIC; 		-- 50MHz  
	    clk_in1_n                  : IN    STD_LOGIC; 		-- 50MHz  
	    
        ------------------------ DDR Pins ---------------------------
	    ddr3_addr	               : OUT STD_LOGIC_VECTOR       (14 DOWNTO 0);
	    ddr3_ba		               : OUT STD_LOGIC_VECTOR       (2 DOWNTO 0);
	    ddr3_ck_p	               : OUT STD_LOGIC_VECTOR       (0 TO 0 );
	    ddr3_ck_n	               : OUT STD_LOGIC_VECTOR       (0 TO 0 );
	    ddr3_cke	               : OUT STD_LOGIC_VECTOR       (0 DOWNTO 0);
	    ddr3_cs_n	               : OUT STD_LOGIC_VECTOR       (0 DOWNTO 0);
	    ddr3_ras_n	               : OUT STD_LOGIC;
	    ddr3_cas_n	               : OUT STD_LOGIC;
	    ddr3_we_n                  : OUT STD_LOGIC;
	    ddr3_dq		               : INOUT STD_LOGIC_VECTOR    (31 DOWNTO 0);
	    ddr3_dqs_p	               : INOUT STD_LOGIC_VECTOR    (3 DOWNTO 0);
	    ddr3_dqs_n	               : INOUT STD_LOGIC_VECTOR    (3 DOWNTO 0);
	    ddr3_dm		               : OUT STD_LOGIC_VECTOR      (3 DOWNTO 0);
	    ddr3_odt	               : OUT STD_LOGIC_VECTOR      (0 DOWNTO 0);
	    ddr3_reset_n               : OUT STD_LOGIC;
	    init_calib_complete        : OUT STD_LOGIC;
	
        ------------------------ GMAC Pins --------------------------    
    	eth_rxck                   : IN  STD_LOGIC;  -- 125
        eth_txck                   : OUT STD_LOGIC;                                                                                                     
        eth_txd                    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        eth_tx_en                  : OUT STD_LOGIC;
        eth_rxd                    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        eth_rxctl                  : IN  STD_LOGIC ;                 
        eth_mdio                   : INOUT STD_LOGIC;
        eth_mdc                    : OUT STD_LOGIC;                  
        eth_phyrst_n               : OUT STD_LOGIC;
        eth_int_b                  : IN  STD_LOGIC;
    	
    	------------------------ UART Pins ---------------------------
    	sin0	                   : IN  STD_LOGIC;  
    	sout0	                   : OUT STD_LOGIC;   
		
    	----------------------- SPI Pins ----------------------------
    	mosi0	                   : OUT   STD_LOGIC;
    	miso0	                   : IN    STD_LOGIC;
    	sclk0	                   : OUT   STD_LOGIC;
    	cs_n0	                   : OUT   STD_LOGIC;
   	            
        WP                         : OUT   STD_LOGIC;
        HOLD                       : OUT   STD_LOGIC;  
		
    	----------------------- IIC Pins ----------------------------
    	SDA                        : INOUT STD_LOGIC;
    	SCL                        : INOUT STD_LOGIC;    
		
        ----------------------- GPIO Pins ----------------------------
    	gpio_port0                 : INOUT   STD_LOGIC_VECTOR(15  DOWNTO 0);
    	gpio_port1                 : INOUT   STD_LOGIC_VECTOR(15  DOWNTO 0)    	
  
    ); 
end component;    
     
signal	    rst		                   :  STD_LOGIC;
signal	    rst_led		               :  STD_LOGIC;
signal	    locked_led                 :  STD_LOGIC;
signal	    serial_rst_n	           :  STD_LOGIC;
signal	    clk_in1_p                  :  STD_LOGIC    := '0'; 		-- 50MHZ  
signal	    clk_in1_n                  :  STD_LOGIC    := '1'; 		-- 50MHZ  
signal	    ddr3_addr	               :  STD_LOGIC_VECTOR              (14 DOWNTO 0);
signal	    ddr3_ba		               :  STD_LOGIC_VECTOR              (2 DOWNTO 0);
signal	    ddr3_ck_p	               :  STD_LOGIC_VECTOR              (0 TO 0 );
signal	    ddr3_ck_n	               :  STD_LOGIC_VECTOR              (0 TO 0 );
signal	    ddr3_cke	               :  STD_LOGIC_VECTOR              (0 DOWNTO 0);
signal	    ddr3_cs_n	               :  STD_LOGIC_VECTOR              (0 DOWNTO 0);
signal	    ddr3_ras_n	               :  STD_LOGIC;
signal	    ddr3_cas_n	               :  STD_LOGIC;
signal	    ddr3_we_n                  :  STD_LOGIC;
signal	    ddr3_dq		               :  STD_LOGIC_VECTOR           (31 DOWNTO 0);
signal	    ddr3_dqs_p	               :  STD_LOGIC_VECTOR           (3 DOWNTO 0);
signal	    ddr3_dqs_n	               :  STD_LOGIC_VECTOR           (3 DOWNTO 0);
signal	    ddr3_dm		               :  STD_LOGIC_VECTOR             (3 DOWNTO 0);
signal	    ddr3_odt	               :  STD_LOGIC_VECTOR             (0 DOWNTO 0);
signal	    ddr3_reset_n               :  STD_LOGIC;
signal	    init_calib_complete        :  STD_LOGIC;
signal    	eth_rxck                   :  STD_LOGIC;  -- 125
signal      eth_txck                   :  STD_LOGIC;                                                                                                     
signal      eth_txd                    :  STD_LOGIC_VECTOR(3 DOWNTO 0);
signal      eth_tx_en                  :  STD_LOGIC;
signal      eth_rxd                    :  STD_LOGIC_VECTOR(3 DOWNTO 0);
signal      eth_rxctl                  :  STD_LOGIC ;                 
signal      eth_mdio                   :  STD_LOGIC;
signal      eth_mdc                    :  STD_LOGIC;                  
signal      eth_phyrst_n               :  STD_LOGIC;
signal      eth_int_b                  :  STD_LOGIC;
signal    	sin0	                   :  STD_LOGIC;  
signal    	sout0	                   :  STD_LOGIC;      
signal    	mosi0	                   :  STD_LOGIC;
signal    	miso0	                   :  STD_LOGIC;
signal    	sclk0	                   :  STD_LOGIC;
signal    	cs_n0	                   :  STD_LOGIC;          
signal      WP                         :  STD_LOGIC;
signal      HOLD                       :  STD_LOGIC;             
signal    	SDA                        :  STD_LOGIC;
signal    	SCL                        :  STD_LOGIC;  
signal    	gpio_port0                 :  STD_LOGIC_VECTOR(15  DOWNTO 0);
signal    	gpio_port1                 :  STD_LOGIC_VECTOR(15  DOWNTO 0);              

signal	    proc_beat                  :  STD_LOGIC	;


begin

   	------------------ Clock Generation -----------------------
    clk_in1_p            <=  NOT clk_in1_p  			after 2500 ps; --200MHz
	clk_in1_n            <=  NOT clk_in1_n  			after 2500 ps; --200MHz
	eth_rxck             <=  NOT eth_rxck  		        after 4000 ps; --125MHz
		
	---------------- Reset Generation -------------------------
	reset_proc: process
	begin        
	-- hold reset state for 1000 ns.
		rst <= '0';
		wait for 3000 ns;   
		rst <= '1';
		wait;
	end process;


u_Top:  Top 
port map (    

	    rst		                   =>    rst		             ,
	    serial_rst_n	           =>    '1'	                 ,
	    GPIO_rst_dip	           =>    '0'	                 ,
	    rst_led		               =>    rst_led		         ,
	    locked_led                 =>    locked_led              ,
	    proc_beat                  =>    proc_beat               ,
		
	    clk_in1_p                  =>    clk_in1_p               ,
	    clk_in1_n                  =>    clk_in1_n               ,
	    ddr3_addr	               =>    ddr3_addr	             ,
	    ddr3_ba		               =>    ddr3_ba		         ,
	    ddr3_ck_p	               =>    ddr3_ck_p	             ,
	    ddr3_ck_n	               =>    ddr3_ck_n	             ,
	    ddr3_cke	               =>    ddr3_cke	             ,
	    ddr3_cs_n	               =>    ddr3_cs_n	             ,
	    ddr3_ras_n	               =>    ddr3_ras_n	             ,
	    ddr3_cas_n	               =>    ddr3_cas_n	             ,
	    ddr3_we_n                  =>    ddr3_we_n               ,
	    ddr3_dq		               =>    ddr3_dq		         ,
	    ddr3_dqs_p	               =>    ddr3_dqs_p	             ,
	    ddr3_dqs_n	               =>    ddr3_dqs_n	             ,
	    ddr3_dm		               =>    ddr3_dm		         ,
	    ddr3_odt	               =>    ddr3_odt	             ,
	    ddr3_reset_n               =>    ddr3_reset_n            ,
	    init_calib_complete        =>    init_calib_complete     ,
    	eth_rxck                   =>    eth_rxck                ,
        eth_txck                   =>    eth_txck                ,                                                      
        eth_txd                    =>    eth_txd                 ,
        eth_tx_en                  =>    eth_tx_en               ,
        eth_rxd                    =>    eth_rxd                 ,
        eth_rxctl                  =>    eth_rxctl               ,
        eth_mdio                   =>    eth_mdio                ,
        eth_mdc                    =>    eth_mdc                 ,
        eth_phyrst_n               =>    eth_phyrst_n            ,
        eth_int_b                  =>    eth_int_b               ,
		
    	sin0	                   =>    sout0	                 ,
    	sout0	                   =>    sout0	                 , 
		
    	mosi0	                   =>    mosi0	                 ,
    	miso0	                   =>    miso0	                 ,
    	sclk0	                   =>    sclk0	                 ,
    	cs_n0	                   =>    cs_n0	                 ,
		
        WP                         =>    WP                      ,
        HOLD                       =>    HOLD                    ,
														       
    	SDA                        =>    SDA                     ,
    	SCL                        =>    SCL                     ,
    			
    	gpio_port0                 =>    gpio_port0              ,
    	gpio_port1                 =>    gpio_port1              
  
    ); 


end Behavioral;
