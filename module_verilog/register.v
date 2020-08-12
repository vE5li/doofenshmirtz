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

module binary_segment(clock, number, segment_a, segment_b, segment_c, segment_d, segment_e, segment_f, segment_g);

    input clock;
    input [3:0] number;

    output segment_a, segment_b, segment_c, segment_d, segment_e, segment_f, segment_g;

    reg [6:0] encoding = 7'h00;

    always @(posedge clock) begin
        case (number) // T RT RB B LB LT MD
            4'b0000 : encoding <= 7'b0000001;
            4'b0001 : encoding <= 7'b1001111;
            4'b0010 : encoding <= 7'b0010010;
            4'b0011 : encoding <= 7'b0000110;
            4'b0100 : encoding <= 7'b1001100;
            4'b0101 : encoding <= 7'b0100100;
            4'b0110 : encoding <= 7'b0100000;
            4'b0111 : encoding <= 7'b0001111;
            4'b1000 : encoding <= 7'b0000000;
            4'b1001 : encoding <= 7'b0000100;
            4'b1010 : encoding <= 7'b0001000;
            4'b1011 : encoding <= 7'b1100000;
            4'b1100 : encoding <= 7'b0110001;
            4'b1101 : encoding <= 7'b1000010;
            4'b1110 : encoding <= 7'b0110000;
            4'b1111 : encoding <= 7'b0111000;
        endcase
    end

    assign segment_a = encoding[6];
    assign segment_b = encoding[5];
    assign segment_c = encoding[4];
    assign segment_d = encoding[3];
    assign segment_e = encoding[2];
    assign segment_f = encoding[1];
    assign segment_g = encoding[0];

endmodule
