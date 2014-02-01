`timescale 1 ns / 100 ps

// Generates VGA control signals for a 256x256 three-bit color framebuffer.
// Horizontal and vertical sync pulse generation is based on an elegant design
// from Jason Stewart of UNC.

module vga_controller( clock, reset, hsync, vsync, row, column, video_on );

   input        clock;     // should be close to the VGA spec's 25.175 MHz
   input        reset;     // active-high, synchronous reset
   output       hsync;     // active-high VGA horizontal sync signal
   output       vsync;     // active-high VGA vertical sync signal
   output [7:0] row;       // framebuffer pixel row address; 0 is the top
   output [7:0] column;    // framebuffer pixel column address; 0 is the left
   output       video_on;  // pixels should be displayed

   // Parameters for horizontal
   localparam HBITS    = 10;     // number of counter bits
   localparam HCOUNT   = 800;    // total pixel count
   localparam HS_START = 8;      // start of hsync pulse
   localparam HS_LEN   = 96;     // length of hsync pulse
   localparam HA_START = 319;    // start of active video
   localparam HA_LEN   = 256;    // length of active video

   // Parameters for vertical
   localparam VBITS    = 10;     // number of counter bits
   localparam VCOUNT   = 525;    // total line count
   localparam VS_START = 2;      // start of vsync pulse
   localparam VS_LEN   = 2;      // length of vsync pulse
   localparam VA_START = 136;    // start of active video
   localparam VA_LEN   = 256;    // length of active video

   wire [HBITS-1:0] hcount;          // horizontal pixel counter
   wire [VBITS-1:0] vcount;          // vertical line counter
   wire             vcount_enable;   // vertical line counter clock enable
   wire             hactive;         // not currently performing horizontal retrace
   wire             vactive;         // not currently performing vertical flyback

   assign column = hcount - HA_START - 1;
   assign row    = vcount - VA_START;

   assign video_on = hactive && vactive;

   // Horizontal sync pulse generation

   counter   #(HBITS, HCOUNT)           h_count(.count(hcount), .enable(1'b1),
                                                .clock(clock), .reset(reset));
   pulse_gen #(HBITS, HS_START, HS_LEN) h_sync(.pulse(hsync), .count(hcount),
                                               .clock(clock), .reset(reset));
   pulse_gen #(HBITS, HA_START, HA_LEN) h_active(.pulse(hactive), .count(hcount),
                                                 .clock(clock), .reset(reset));

   // Vertical sync pulse generation

   pulse_high_low v_pulse(.pulse(vcount_enable), .data(hsync),
                          .clock(clock), .reset(reset));
   counter        #(VBITS, VCOUNT)           v_count(.count(vcount), .enable(vcount_enable),
                                                     .clock(clock), .reset(reset));
   pulse_gen      #(VBITS, VS_START, VS_LEN) v_sync(.pulse(vsync), .count(vcount),
                                                    .clock(clock), .reset(reset));
   pulse_gen      #(VBITS, VA_START, VA_LEN) v_active(.pulse(vactive), .count(vcount),
                                                      .clock(clock), .reset(reset));
				
endmodule

// Implements a clock-enabled counter with the specified number of bits.
// The count value cycles from 0 to TCOUNT and back to 0.

module counter(count, enable, clock, reset);

   parameter N = 8;         // number of bits
   parameter TCOUNT = 255;  // desired terminal count

   output reg [N-1:0] count;
   input              enable;
   input              clock;
   input              reset;

   always @(posedge clock) begin
      if (reset) begin
         count <= 0;
      end
      else begin
         if (enable) begin
            if (count == TCOUNT)
               count <= 0;
            else
               count <= count + 1;
         end
      end
   end

endmodule


// Generates a high output when the count value is in the specified range.

module pulse_gen(pulse, count, clock, reset);

   parameter N = 8;      // number of counter bits
   parameter START = 0;  // start count
   parameter LENGTH = 1; // pulse length (number of cycles)

   output reg    pulse;
   input [N-1:0] count;
   input         clock;
   input         reset;

   always @(posedge clock) begin
      if (reset)
         pulse <= 1'b0;
      else
         pulse <= (count >= START) && (count < (START+LENGTH));
   end

endmodule


// Generates a positive pulse when the there is a high-to-low transition on data.

module pulse_high_low(pulse, data, clock, reset);

   output reg pulse;
   input      data;
   input      clock;
   input      reset;

   reg        prev_data;  // one-cycle delay reg

   always @(posedge clock) begin
      if (reset)
         prev_data <= 1'b0;
      else
         prev_data <= data;
   end

   always @(posedge clock) begin
      if (reset)
         pulse <= 1'b0;
      else
         pulse <= prev_data && (~data);
   end

endmodule
