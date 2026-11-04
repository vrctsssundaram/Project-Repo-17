# Technical design

States OFF, POWERING, CLOCKING, RELEASE, RUN, SHUTDOWN and FAULT sequence an island through supply power, clock availability, reset release, and eventual de-isolation. A failure to receive an acknowledgment within the configured timeout forces FAULT. A high external fault masks the output enables and forces isolation without waiting for a state-clock edge; the state machine latches the event on the next clock.

## Scope boundary

Control-logic model only; no actual power gates, clock primitives, retention cells, domain crossing synchronizers, physical voltage timing or safety certification. External acknowledgments must be synchronized into `clk` and qualified by the platform.
