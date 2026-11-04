# Interface summary

| Item | Meaning |
|---|---|
| Requests | `request_on`, `request_off`, `clear_fault` |
| Acknowledgments | `power_good`, `clock_ok`, `reset_done` |
| `cfg_timeout[15:0]` | Per-phase maximum wait; minimum effective 2 cycles |
| Outputs | `power_enable`, `clock_enable`, `reset_release_n`, `isolate`, `ready` |
| Diagnostics | `state_dbg[2:0]`, sticky fault and 32-bit fault-event count |

## Assumptions and limitations

Control-logic model only; no actual power gates, clock primitives, retention cells, domain crossing synchronizers, physical voltage timing or safety certification. External acknowledgments must be synchronized into `clk` and qualified by the platform.
