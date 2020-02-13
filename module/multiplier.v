module multiplier(input0, input1, product);

    parameter width = 8;

    input [width - 1:0] input0, input1;
    output [(width * 2) - 1:0] product;

    wire [width - 1:0] partial [width - 1:0];
    wire [width - 1:0] sum [width - 2:0];
    wire carry [width - 1:0];

    genvar index;
    generate

        for (index = 0; index < width; index = index + 1) begin
            assign partial[index] = { width{input0[index]} } & input1[width - 1:0];
        end

        for (index = 0; index < width - 1; index = index + 1) begin
            if (index == 0)
                adder #(width + 1) adder({ 1'b1, ~partial[0][width - 1], partial[0][width - 2:0] }, { ~partial[1][width - 1], partial[1][width - 2:0], 1'b0 }, { sum[0], product[0] }, carry[0]);
            else if (index == width - 2)
                adder #(width + 2) adder({ 1'b0, carry[index - 1], sum[index - 1] }, { 1'b1, partial[index + 1][width - 1], ~partial[index + 1][width - 2:0], 1'b0 }, product[(width * 2) - 1:index ], carry[index]);
            else
                adder #(width + 1) adder({ carry[index - 1], sum[index - 1] }, { ~partial[index + 1][width - 1], partial[index + 1][width - 2:0], 1'b0 }, { sum[index], product[index] }, carry[index]);
        end

    endgenerate

endmodule
