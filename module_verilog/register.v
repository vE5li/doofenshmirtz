module bus_register(clock, selector, source, destination);

    parameter count = 0;

    input clock;
    input [$clog2(count + 1) - 1:0] selector;
    input [count * `bit_width - 1:0] source;

    output [`bit_width - 1:0] destination;

    reg [`bit_width - 1:0] buffer = 0;
    reg [`bit_width - 1:0] data = 0;

    assign destination = data;

    always @(posedge clock) begin
        if (&selector == 0)
            buffer = source[selector * `bit_width +: `bit_width];
    end

    always @(negedge clock) begin
        data = buffer;
    end

endmodule

module memory_register(clock, selector, source, destination, memory_slot);

    parameter count = 0;

    input clock;
    input [$clog2(count + 1) - 1:0] selector;
    input [count * `bit_width - 1:0] source;
    input [`bit_width - 1:0] memory_slot;

    output [`bit_width - 1:0] destination;

    reg [`bit_width - 1:0] buffer = 0;
    reg [`bit_width - 1:0] data = 0;

    assign destination = data;

    always @(posedge clock) begin
        if (&selector == 0)
            buffer = source[selector * `bit_width +: `bit_width];
    end

    always @(negedge clock) begin
        data = buffer;
    end

endmodule

module buffered_register(clock, selector, source, internal, destination);

    parameter count = 0;

    input clock;
    input [$clog2(count + 1) - 1:0] selector;
    input [count * `bit_width - 1:0] source;

    output [`bit_width - 1:0] internal, destination;

    reg [`bit_width - 1:0] buffer;
    reg [`bit_width - 1:0] data;

    assign internal = buffer;
    assign destination = data;

    initial begin
        buffer <= 0;
        data <= 0;
    end

    always @(posedge clock) begin
        if (&selector == 0)
            buffer = source[selector * `bit_width +: `bit_width];
    end

    always @(negedge clock) begin
        data = buffer;
    end

endmodule

//module pseudo_register(source, destination);
//
//    parameter width = 8;
//
//    input [width - 1:0] source;
//    output [width - 1:0] destination;
//
//    assign destination = source;
//
//endmodule
