module half_adder(input0, input1, sum, carry);

    input input0, input1;
    output sum, carry;

    assign sum = input0 ^ input1;
    assign carry = input0 & input1;

endmodule

module full_adder(input0, input1, carry_in, sum, carry_out);

    input input0, input1, carry_in;
    output sum, carry_out;

    assign sum = input0 ^ input1 ^ carry_in;
    assign carry_out = (input0 & input1) | ((input0 ^ input1) & carry_in);

endmodule

module adder(input0, input1, sum, carry_out);

    parameter width = 8;

    input [width - 1:0] input0, input1;

    output [width - 1:0] sum;
    output carry_out;

    wire carry [width - 2:0];

    genvar index;
    generate

        for (index = 0; index < width; index = index + 1) begin
            if (index == 0)
                half_adder unit(input0[0], input1[0], sum[0], carry[0]);
            else if (index == width - 1)
                full_adder unit(input0[index], input1[index], carry[index - 1], sum[index], carry_out);
            else
                full_adder unit(input0[index], input1[index], carry[index - 1], sum[index], carry[index]);
        end

    endgenerate

endmodule

module adder_module(clock, selector0, selector1, source0, source1, destination0, destination1, destination2, destination3);

    parameter count0 = 0;
    parameter count1 = 0;

    input clock;
    input [$clog2(count0 + 1) - 1:0] selector0;
    input [$clog2(count1 + 1) - 1:0] selector1;
    input [count0 * `bit_width - 1:0] source0;
    input [count1 * `bit_width - 1:0] source1;

    output [`bit_width - 1:0] destination0, destination1, destination2, destination3;

    wire [`bit_width - 1:0] input_wire [1:0];
    wire carry_out;

    bus_register #(count0) input_register0(clock, selector0, source0, input_wire[0]);
    bus_register #(count1) input_register1(clock, selector1, source1, input_wire[1]);
    adder #(`bit_width) adder(input_wire[0], input_wire[1], destination2, carry_out);

    assign destination0 = input_wire[0];
    assign destination1 = input_wire[1];
    assign destination3 = { carry_out };

endmodule
