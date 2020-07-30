module comparitor_module(clock, selector0, selector1, source0, source1, destination0, destination1, destination2, destination3, destination4);

    parameter count0 = 0;
    parameter count1 = 0;

    input clock;
    input [$clog2(count0 + 1) - 1:0] selector0;
    input [$clog2(count1 + 1) - 1:0] selector1;
    input [count0 * `bit_width - 1:0] source0;
    input [count1 * `bit_width - 1:0] source1;

    output [`bit_width - 1:0] destination0, destination1, destination2, destination3, destination4;

    wire [`bit_width - 1:0] input_wire [1:0];
    wire [`bit_width - 1:0] buffer_wire [1:0];
    reg [`bit_width - 1:0] buffer [2:0];

    buffered_register #(count0) input_register0(clock, selector0, source0, buffer_wire[0], input_wire[0]);
    buffered_register #(count1) input_register1(clock, selector1, source1, buffer_wire[1], input_wire[1]);

    assign destination0 = input_wire[0];
    assign destination1 = input_wire[1];
    assign destination2 = buffer[0];
    assign destination3 = buffer[1];
    assign destination4 = buffer[2];

    always @(negedge clock) begin
        buffer[0] <= { `bit_width{ buffer_wire[0] == buffer_wire[1] } };
        buffer[1] <= { `bit_width{ buffer_wire[0] > buffer_wire[1] } };
        buffer[2] <= { `bit_width{ buffer_wire[0] < buffer_wire[1] } };
    end

endmodule
