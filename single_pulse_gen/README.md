# Single Pulse Generator
Purpose of this project is to generate a single pulse with a variable delay and duration programmed through the Zynq processor and AXI DMA.

## Instructions for setting up the project in Vivado
- Create a new project and change the `Target language` to `VHDL`
- navigate to `IP Integrator` -> `Create Block Design`.
- Under the `Diagram` tab, add the `ZYNQ7 Processing System` and click on `Run Block Automation` to apply the board presets.
- For now, connect `FCLK_CLK0` to `M_AXI_GP0_ACLK` and then click on `Validate Design`
- Navigate to `Tools` -> `Create and Package New IP`, click `Next` -> `Create a new AXI4 peripheral` -> `Next` -> Enter the name `single_pulse_gen` -> `Next` -> `Next` because the default AXI parameters will suffice for this project -> `Edit IP`
- Replace the auto-generated `single_pulse_gen_v1_0.vhd` and `single_pulse_gen_v1_0_S00_AXI` with the ones provided here (copy/paste).
- Navigate to `Sources` tab and click `Add Sources` -> `Add or create design sources` -> `Create File` or `Add Files` whichever is easier. Add or create the `counter.vhd` and `variable_pulse_gen.vhd` files.
- (Optional) Add the test files provided.
- Navigate to `RTL ANALYSIS` and click on `Open Elaborated Design` to compile and to check the design for correctness.
- If successful, navigate to `Package IP - single_pulse_gen` -> `File Groups` -> `Merge changes from File Groups Wizard`. Then `Ports and Interfaces` to merge project port changes. Finish packaging IP.
- Add the newly created IP.
- Right click on `pulse_out` and the click on `Create Port` to make it an output port. Then click on `Run connection automation`. Re-run and update IP as needed.
- Add the constraints file by navigating to `Sources` -> `Add Sources` -> `Add or create constraints`. Then click on `Validate Design` button.
- Navigate to `Sources` -> `Design Sources`. Right click on the design and create HDL wrapper.
- Finally, `Generate Bitstream`

- Copy hardware hand-off file from
    ```
    <prj>.gen/sources_1/bd/<bd_name>/hw_handoff/<bd_name>.hwh
    ```

- Copy tcl and bit files from
    ```
    <prj>.runs/impl_1/<project_name>.tcl or .bit
    ```