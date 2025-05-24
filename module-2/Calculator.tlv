m5_TLV_version 1d: tl-x.org
\m5
   
   // ============================================
   // Welcome, new visitors! Try the "Learn" menu.
   // ============================================
   
   //use(m5-1.0)   /// uncomment to use M5 macro library.
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
	m4_include_lib(['https://raw.githubusercontent.com/stevehoover/LF-Building-a-RISC-V-CPU-Core/main/lib/calc_viz.tlv'])
                 
    
\TLV

   //calc circuit 

   //set upper word bits to assure small values
   // we are setting for val1 26 bits for full zeros and the rest random
   // for val2 28 bits zero and rest random 
   
   $zerob[25:0] = 26'b0;
   $zerob2[27:0] = 28'b0;
   // concatenating bit arrays to form a bigger word
   // we can do this directly in the final vairble 
   // val1 could have been this directly &val1[31:0] = { 26'b0, $val2_rand[3:0]}
   // we dont need to declare val2_rand as we want it random
   // with 26'b0 we specify that we want a binary zero inside a 26 bit word
   // we are using this structure $variable_name[finalsize] = {top bits, lower bits} 
   $val2[31:0] = {$zerob2, $val2_rand[3:0]};
   $val1[31:0] = {$zerob, $val1_rand[5:0]};

   //set of cases for calc (im abreviating calculator)

   $sum[31:0] = $val1[31:0] + $val2[31:0];
   $diff[31:0] = $val1 - $val2;
   $prod[31:0] = $val1 * $val2;
   $quot[31:0] = $val1 / $val2;
   //set the switch structure for the calculator
   // $variable_name[size array in bits higher bit:lower] = $if this true : then this happens ? else:

   $out[31:0] = $op[1:0] == 1 ? $sum:
          $op == 2 ? $diff:
          $op == 3 ? $prod:
          $quot;

   // set cicle count to 5 so we can see the numbers in the waveform better
   *passed = *cyc_cnt >5; 
   
   //vizualization import into the makerchip IDE
   m4+calc_viz()
   
\SV
   endmodule
