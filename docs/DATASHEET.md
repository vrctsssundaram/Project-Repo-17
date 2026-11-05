# Interface summary

| Item | Meaning |
|---|---|
| Requests | `request_on`, `request_off`, `clear_fault` |
| Acknowledgments | `power_good`, `clock_ok`, `reset_done` |
| `cfg_timeout[15:0]` | Per-phase maximum wait; minimum effective 2 cycles |
| Outputs | `power_enable`, `clock_enable`, `reset_release_n`, `isolate`, `ready` |
| Diagnostics | `state_dbg[2:0]`, sticky fault and 32-bit fault-event count |

## Integration profile

The controller sequences power, clock, reset and isolation acknowledgments. Platform-facing acknowledgments enter the local clock domain synchronously.
