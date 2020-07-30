module selector_module(clock, selector, source, destination, memory_selector);

    parameter count = 0;

    input clock;
    input [$clog2(count + 1) - 1:0] selector;
    input [count * `bit_width - 1:0] source;

    output [`bit_width - 1:0] destination;
    output [`selector_width - 1:0] memory_selector;

endmodule
