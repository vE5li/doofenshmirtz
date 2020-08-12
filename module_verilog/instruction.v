module instruction_module(clock, selector0, selector1, source0, source1, destination0, destination1, destination2, program_counter);

    parameter count0 = 0;
    parameter count1 = 0;

    input clock;
    input [$clog2(count0 + 1) - 1:0] selector0;
    input [$clog2(count1 + 1) - 1:0] selector1;
    input [count0 * `bit_width - 1:0] source0;
    input [count1 * `bit_width - 1:0] source1;

    output [`bit_width - 1:0] destination0, destination1, destination2;
    output [`counter_width - 1:0] program_counter;

    reg [`bit_width - 1:0] buffer0 = 0;
    reg [`bit_width - 1:0] buffer1 = 0;
    reg [`bit_width - 1:0] buffer2 = 0;
    reg [`bit_width - 1:0] data0 = 0;
    reg [`bit_width - 1:0] data1 = 0;
    reg [`bit_width - 1:0] data2 = 0;

    assign destination0 = data0;
    assign destination1 = data1;
    assign destination2 = data2;
    assign program_counter = buffer2;

    initial begin
        buffer0 <= 0;
        buffer1 <= 0;
        buffer2 <= 0;
        data0 <= 0;
        data1 <= 0;
        data2 <= 0;
    end

    always @(posedge clock) begin

        if (&selector0 == 0)
            buffer0 = source0[selector0 * `bit_width +: `bit_width];

        if (&selector1 == 0)
            buffer1 = source1[selector1 * `bit_width +: `bit_width];

        if (buffer1 != 0) begin
            buffer2 <= buffer0;
            buffer1 <= 0;
        end else
            buffer2 <= buffer2 + 1;
    end

    always @(negedge clock) begin
        data0 <= buffer0;
        data1 <= buffer1;
        data2 <= buffer2;
    end

endmodule
