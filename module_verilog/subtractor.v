`include "system.vh"

module half_subtractor(input0, input1, difference, borrow);

    input input0, input1;
    output difference, borrow;

    assign difference = input0 ^ input1;
    assign borrow = !input0 & input1;

endmodule

module full_subtractor(input0, input1, borrow_in, difference, borrow_out);

    input input0, input1, borrow_in;
    output difference, borrow_out;

    assign difference = input0 ^ input1 ^ borrow_in;
    assign borrow_out = (!input0 & input1) | (!(input0 ^ input1) & borrow_in);

endmodule

module subtractor(input0, input1, difference, borrow_out);

    parameter width = 8;

    input [width - 1:0] input0, input1;
    output [width - 1:0] difference;
    output borrow_out;

    wire borrow [width - 2:0];

    genvar index;
    generate

        for (index = 0; index < width; index = index + 1) begin
            if (index == 0)
                half_subtractor unit(input0[0], input1[0], difference[0], borrow[0]);
            else if (index == width - 1)
                full_subtractor unit(input0[index], input1[index], borrow[index - 1], difference[index], borrow_out);
            else
                full_subtractor unit(input0[index], input1[index], borrow[index - 1], difference[index], borrow[index]);
        end

    endgenerate

endmodule

module subtractor_module(clock, selector0, selector1, source0, source1, destination0, destination1, destination2, destination3);

    parameter count0 = 0;
    parameter count1 = 0;

    input clock;
    input [$clog2(count0 + 1) - 1:0] selector0;
    input [$clog2(count1 + 1) - 1:0] selector1;
    input [count0 * `bit_width - 1:0] source0;
    input [count1 * `bit_width - 1:0] source1;

    output [`bit_width - 1:0] destination0, destination1, destination2, destination3;

    wire [`bit_width - 1:0] input_wire [1:0];
    wire borrow_out;

    bus_register #(count0) input_register0(clock, selector0, source0, input_wire[0]);
    bus_register #(count1) input_register1(clock, selector1, source1, input_wire[1]);
    subtractor #(`bit_width) subtractor(input_wire[0], input_wire[1], destination2, borrow_out);

    assign destination0 = input_wire[0];
    assign destination1 = input_wire[1];
    assign destination3 = { borrow_out };

endmodule
