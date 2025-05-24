\m5_TLV_version 1d: tl-x.org
\m5
   
 
   
   //use(m5-1.0)   /// uncomment to use M5 macro library.
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset;
   
   // fibonacci sequence circuit 
   // using the expression >>1$var_name we can access the previous state of a variable
   // >>2$var_name access the one before that 
   // in this case every cycle of our clock it sums the last to states
   // we set the reset to 1 so the variables are set in 1 

   $fib[31:0] = $reset ? 1 : (>>1$fib + >>2$fib);
   
   // this simple counter is easier to see
   // in each sequence that we dont have the reset signal we are 
   // accessing the last state of $count and addding one
   
   $count[31:0] = $reset ? 1 : (>>1$count + 16'd1);
   // Assert these to end simulation (before the cycle limit).
   *passed = *cyc_cnt > 10;
   *failed = 1'b0;
\SV
   endmodule
