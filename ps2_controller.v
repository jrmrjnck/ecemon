`timescale 1 ns / 100 ps

/****************************************************************************\
 *
 * Engineer:       Jonathan Doman
 * Company:        Virginia Tech
 * 
 * Design Name:    PS/2 transmit and receive controller
 * Project Name:   ECE 4514 Lab 3
 *
 * Implements a PS/2 controller, with both transmit (from the S3E board to the device)
 * and receive (from the device to the S3E board) functions.
 * The transmitter converts data bytes to a serial stream of start, data, parity
 * and stop bits, and the receiver converts a serial stream of start, data,
 * parity and stop bits to data bytes.
 *
\****************************************************************************/

// A PS/2 keyboard/mouse receiver that samples the PS/2 clock and data signals
// in order to read, validate, and return data bytes.
// The start, parity, and stop bits are checked.
// The rx_data_avail output is pulsed for one clock cycle when a new data byte
// is available on rx_data.

module ps2_receive(rx_data, rx_data_avail, rx_enable, ps2_clock, ps2_data, clock, reset);

   output reg [7:0] rx_data;            // a new data value
   output reg       rx_data_avail;      // pulsed high when a new rx_data is available
   input            rx_enable;          // high value enables the receive function
   input            ps2_clock;          // PS/2 interface clock signal
   input            ps2_data;           // PS/2 interface data signal
   input            clock;              // rising-edge active
   input            reset;              // active-high synchronous reset

   reg       [10:0] ps2_data_buf;       // all PS/2 data bit values in a frame
   reg        [7:0] ps2_clock_buf;      // the last 8 PS/2 clock samples
   reg        [3:0] bit_count;          // counts the PS/2 data bits in a frame
   wire             ps2_clock_negedge;  // true on a PS/2 falling edge

   always @(posedge clock) begin
      if (reset)
         ps2_data_buf <= 11'b0;
      else if (ps2_clock_negedge)
         ps2_data_buf <= {ps2_data, ps2_data_buf[10:1]};
   end

  always @(posedge clock) begin
      if (reset)
         ps2_clock_buf <= 8'd0;
      else
         ps2_clock_buf <= {ps2_clock_buf[6:0], ps2_clock};
   end

   always @(posedge clock) begin
      if (reset)
         bit_count <= 4'd0;
      else if (ps2_clock_negedge)
         bit_count <= bit_count + 4'd1;
      else if (bit_count == 4'd11)
         bit_count <= 4'd0;
   end

   always @(posedge clock) begin
      if (reset) begin
         rx_data <= 8'd0;
         rx_data_avail <= 1'b0;
      end
      else if ((bit_count == 4'd11) && (!ps2_data_buf[0]) &&
               (^(ps2_data_buf[9:1])) && (ps2_data_buf[10])) begin
         rx_data <= ps2_data_buf[8:1];
         rx_data_avail <= 1'b1;
      end
      else begin
        rx_data_avail <= 1'b0;
      end
   end

   assign ps2_clock_negedge = rx_enable && (ps2_clock_buf == 8'hf0);

endmodule

module ps2_kb( 
               input            ps2_clock, 
               input            ps2_data,
               input            clock, 
               input            reset,
               output reg       code_avail,
               output reg [7:0] code 
             );

   wire       rx_avail;
   wire [7:0] rx_data;

   reg [7:0] prev_code;

   ps2_receive ps2( .rx_data(rx_data), .rx_data_avail(rx_avail), .rx_enable(1'b1),
                    .ps2_clock(ps2_clock), .ps2_data(ps2_data),
                    .clock(clock), .reset(reset) );

   always @( posedge clock ) begin
      if( reset )
         prev_code <= 8'b0;
      else
         prev_code <= code;
   end

   always @( posedge clock ) begin
      if( reset )
         code <= 8'b0;

      else begin
         if( rx_avail ) begin
            code <= rx_data;
            code_avail <= (rx_data != 8'hF0) && (rx_data != 8'hE0) && (prev_code != 8'hF0);
         end
         else
            code_avail <= 1'b0;
      end
   end

endmodule
