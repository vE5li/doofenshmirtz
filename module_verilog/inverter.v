module inverter_module(clock, selector, source, destination0, destination1);

    parameter count = 0;

    input clock;
    input [$clog2(count + 1) - 1:0] selector;
    input [count * `bit_width - 1:0] source;

    output [`bit_width - 1:0] destination0, destination1;

    wire [`bit_width - 1:0] buffer_wire;

    bus_register #(count) input_register(clock, selector, source, buffer_wire);

    assign destination0 = buffer_wire;
    assign destination1 = ~buffer_wire;

endmodule
