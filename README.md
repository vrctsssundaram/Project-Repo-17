# Power-island sequencer

Ordered power, clock, reset, and isolation control for a hardware island.

## Features

- Power-good, clock-ready and reset-done handshakes
- Isolation retained until the island reaches RUN
- Startup-phase timeout and sticky fault accounting
- Immediate fault masking of enabled outputs, shutdown and fault clear

## Verification

Run `make test` and `make synth`. Interface, design, test procedure and measurements appear under `docs/`.

**Architecture:** Ordered power, clock, reset and isolation sequencing with acknowledgment and fault control.

Project owner: Sundaram S S.
