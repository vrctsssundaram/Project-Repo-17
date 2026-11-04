module tb_power_island_fsm;
    reg clk=0;always #5 clk=~clk;
    reg rst_n=0,request_on=0,request_off=0,power_good=0,clock_ok=0;
    reg reset_done=0,fault=0,clear_fault=0;
    reg [15:0] cfg_timeout=16'd10;
    wire power_enable,clock_enable,reset_release_n,isolate,ready,fault_latched;
    wire [2:0] state_dbg;
    wire [31:0] fault_events;
    power_island_fsm dut(.*);
    task pulse_on;
        begin @(negedge clk);request_on=1;@(negedge clk);request_on=0;end
    endtask
    initial begin
        repeat(3) @(negedge clk);rst_n=1;
        if(power_enable || clock_enable || reset_release_n || !isolate || ready)
            $fatal(1,"Unsafe reset outputs");
        pulse_on();
        wait(state_dbg==1);
        @(negedge clk);
        if(!power_enable || clock_enable || reset_release_n || !isolate)
            $fatal(1,"Power phase outputs");
        repeat(2) @(negedge clk);power_good=1;
        wait(state_dbg==2);
        @(negedge clk);
        if(!power_enable || !clock_enable || reset_release_n || !isolate)
            $fatal(1,"Clock phase outputs");
        @(negedge clk);clock_ok=1;
        wait(state_dbg==3);
        @(negedge clk);
        if(!reset_release_n || !isolate || ready)
            $fatal(1,"Reset-release isolation");
        @(negedge clk);reset_done=1;
        wait(ready);
        @(negedge clk);
        if(isolate || !power_enable || !clock_enable || !reset_release_n)
            $fatal(1,"RUN outputs");
        @(negedge clk);request_off=1;
        @(negedge clk);request_off=0;
        wait(state_dbg==0);
        @(negedge clk);
        if(power_enable || clock_enable || reset_release_n || !isolate)
            $fatal(1,"Shutdown outputs");

        power_good=0;clock_ok=0;reset_done=0;cfg_timeout=3;
        pulse_on();
        wait(fault_latched);
        @(negedge clk);
        if(state_dbg!==6 || fault_events!==1 || power_enable || !isolate || ready)
            $fatal(1,"Startup timeout fault");
        @(negedge clk);clear_fault=1;
        @(negedge clk);clear_fault=0;
        wait(state_dbg==0);
        @(negedge clk);
        if(fault_latched) $fatal(1,"Fault clear");

        cfg_timeout=10;
        pulse_on();
        wait(state_dbg==1);
        @(negedge clk);fault=1;
        #1;
        if(power_enable || !isolate || clock_enable || reset_release_n)
            $fatal(1,"Combinational fault interlock");
        wait(state_dbg==6);
        @(negedge clk);
        if(fault_events!==2) $fatal(1,"Fault event count");
        $display("PASS: power/clock/reset sequencing, shutdown, timeout, fault interlock and clear");
        $finish;
    end
    initial begin #100000;$fatal(1,"Watchdog");end
endmodule
