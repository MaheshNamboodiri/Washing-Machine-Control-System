// Code your design here
module auto_washing(input clk, rst, start, door, fill, soap_add, cycle_timeout, 					drain,spin_timeout,
                    output reg lock,fill_valve,soak,motor,done,drain_valve,wash);
  
  parameter s0 = 3'b000;
  parameter s1 = 3'b001;
  parameter s2 = 3'b010;
  parameter s3 = 3'b011;
  parameter s4 = 3'b100;
  parameter s5 = 3'b101;
  reg [2:0] state, next;
  
  //state register
  always @(posedge clk or negedge rst)
    begin
      if(rst)
        state<=s0;
      else
        state<=next;
    end
  
  
  //next state logic, includes output
  
  always @(state or start or door or fill or soap_add or cycle_timeout or drain or spin_timeout)
    begin
      case(state)
        s0:
          if(start&door)
            begin
              next=s1;
              lock=1;
              fill_valve=0; motor=0; soak=0; drain_valve=0; done=0;
              wash=0; 
            end
          else
            begin
              next=state;
              lock=0;
              fill_valve=0; motor=0; soak=0; drain_valve=0; done=0;wash=0; 
            end
        s1:
          if(!fill)
            begin
              next=state;
              lock=1;
              fill_valve=1; motor=0; soak=0; drain_valve=0; done=0;wash=0; 
            end
          else 
            begin 
              if(soap_add==0)
                begin
                  next=s2;     
                  lock=1;
              	  fill_valve=0; motor=0; soak=0; drain_valve=0; done=0;
                  wash=0; 
                end
              else 
                begin
                  next=s3;
                  lock=1;
              	  fill_valve=0; motor=0; soak=1; drain_valve=0; done=0;
                  wash=1; 
                end
            end
        s2:
          if(!soap_add)
            begin
               next=state;
               lock=1;
               fill_valve=0; motor=0; soak=1; drain_valve=0; done=0;
               wash=0; 
            end
          else
            begin
              next=s3;
               lock=1;
               fill_valve=0; motor=0; soak=1; drain_valve=0; done=0;
               wash=0;
            end
        s3:
          if(!cycle_timeout)
            begin
              next=state;
               lock=1;
               fill_valve=0; motor=1; soak=1; drain_valve=0; done=0;
//                wash=0;
            end
          else
            begin
              next=s4;
               lock=1;
               fill_valve=0; motor=0; soak=1; drain_valve=0; done=0;
//                wash=0;
            end
        s4:
          if(!drain)
            begin
              next=state;
              lock=1;
              fill_valve=0; motor=0; soak=1; drain_valve=1; done=0;
//                wash=0;
            end
          else
            begin
              if(!wash)
                begin
                  next=s1; lock=1;
                  fill_valve=0; motor=0; soak=1; drain_valve=0; done=0;
//                wash=0;
                end
              else
                begin
                	next=s5;lock=1;
                	fill_valve=0; motor=0; soak=1; drain_valve=0; done=0;
//              	wash=0;
                end
            end
        s5:
          if(!spin_timeout)
            begin
              next=state;lock=1;
              fill_valve=0; motor=0; soak=1; drain_valve=1; done=0; wash=1;
            end
          else
            begin
              next=s0; lock=1;
              fill_valve=0; motor=0; soak=1; drain_valve=0; done=1; wash=1;
            end
            
        default: next = s0;
      endcase
    end
  
endmodule       
        
        
        
        
          
