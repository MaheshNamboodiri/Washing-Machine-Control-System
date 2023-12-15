module test_machine();
  reg clk, rst, start, door, fill, soap_add, cycle_timeout,drain, spin_timeout;
  wire lock,fill_valve,soak,motor,done,drain_valve,wash;
  
  auto_washing uut(clk, rst, start, door, fill, soap_add, cycle_timeout,drain, spin_timeout,lock,fill_valve,soak,motor,done,drain_valve,wash);
  
  initial begin

    clk=0;
    rst = 1;
		start = 0;
		door = 0;
		fill = 0;
		drain = 0;
		soap_add = 0;
		cycle_timeout = 0;
		spin_timeout = 0;
		
		#5 rst=0;
		#5 start=1;door=1;
		#10 fill=1;
		#10 soap_add=1;
		//filled=0;
		#10 cycle_timeout=1;
		//detergent_added=0;
		#10 drain=1;
		//cycle_timeout=0;
		#10 spin_timeout=1;
		//drained=0;
  end
  
  always
    begin
      #5 clk = ~clk;
    end
  
  
  
    initial
	begin
//               $dumpfile("dump.vcd");
//     $dumpvars(1);
      
      $monitor("Time=%d, Clock=%b, Reset=%b, start=%b, door=%b, fill=%b, soap_added=%b, cycle_timeout=%b, drain=%b, spin_timeout=%b, lock=%b, motor=%b, fill_valve=%b, drain_valve=%b, soak=%b, wash=%b, done=%b",$time, clk, rst, start, door, fill, soap_add, cycle_timeout, drain, spin_timeout, lock, motor, fill_valve, drain_valve, soak, wash, done);
	end
endmodule
  
