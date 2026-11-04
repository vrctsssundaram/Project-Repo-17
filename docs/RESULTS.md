# Verification record

Date: 05 November 2026
Source revision tested: `5635c9e7a84afefa56af9df524883b15adc498e8`
Hosted verification: https://github.com/vrctsssundaram/Project-Repo-17/actions/runs/41901968454

| Measurement | Recorded result |
|---|---|
| SystemVerilog compilation | **PASS** (Icarus Verilog, `-g2012 -Wall`) |
| Directed self-checking simulation | **PASS** (exit code 0) |
| Directed checks | ordered supply/clock/reset/isolator release, power-off, startup timeout, sticky fault clear and immediate fault output mask |
| Generic Yosys synthesis | **PASS**; 651 technology-independent cells |
| FPGA/ASIC mapped utilization | Not measured |
| Static timing, maximum clock, power | Not measured |
| Physical hardware behavior | Not tested |

The generic cell count is from the hosted Yosys top-module statistics, not device-specific resource utilization. The output ordering and fault behavior are verified only in bounded RTL simulation; no hardware safety certification is implied.
