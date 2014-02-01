/****************************************************************************\
 *
 * Engineer:       Jonathan Doman
 * Company:        Virginia Tech
 * 
\****************************************************************************/
`include "ecemon.vh"

module ecemon
( 
   output       vga_red,         // drives the VGA red signal
   output       vga_green,       // drives the VGA green signal
   output       vga_blue,        // drives the VGA blue signal
   output       vga_hsync_n,     // active-low horizontal sync signal
   output       vga_vsync_n,     // active-low vertical sync signal
   //output [7:0] led,             // available for debug output

   //input  [3:0] switch,          // four slide switches SW3 - SW0
   //input        btn_north,       // north pushbutton, high when pressed
   //input        btn_east,        // east pushbutton,  high when pressed
   //input        btn_west,        // west pushbutton,  high when pressed
   //input        rotary_a,        // rotary knob contact A
   //input        rotary_b,        // rotary knob contact B
   //input        rotary_press,    // rotary pushbutton, high when pressed
   inout        ps2_clock,       // PS/2 interface clock signal
   inout        ps2_data,        // PS/2 interface data signal
   input        osc,             // 50 MHz board oscillator
   input        reset            // active-high synchronous system reset
);

   wire         clock_int;                  // 50 MHz input to the DCM 
   wire         clock_fb;                   // 50 MHz output from the DCM
   wire         clock_dcm;                  // 25 MHz raw output from the DCM
   wire         clock;                      // 25 MHz buffered output from the DCM

   wire         hsync;                      // inverted version of hsync
   wire         vsync;                      // inverted version of vsync
   wire         video_on;
   wire   [7:0] pix_x;
   wire   [7:0] pix_y;

   wire   [7:0] kb_data;
   wire         kb_data_avail; 

   reg [2:0] state;
   reg [2:0] prof;
   reg [1:0] gb;

   assign vga_hsync_n = ~hsync;
   assign vga_vsync_n = ~vsync;

   IBUFG ibufg( .I(osc), .O(clock_int) );  // clock pin buffer

   DCM_SP #(.CLKIN_PERIOD(20.0), .CLKDV_DIVIDE(2), .CLK_FEEDBACK("1X"))
          dcm( .CLKIN(clock_int), .CLKFB(clock_fb), .PSCLK(1'b0), .PSEN(1'b0),
               .PSINCDEC(1'b0), .CLK0(clock_fb), .CLKDV(clock_dcm)); 
   
   BUFG bufg(.I(clock_dcm), .O(clock));  // clock drive buffer

   // Translate our 4-color internal scheme to an RGB output
   assign {vga_red,vga_green,vga_blue} = (gb==2'b00) ? 3'b000 :
                                         (gb==2'b01) ? 3'b001 :
                                         (gb==2'b10) ? 3'b011 : 3'b111;

   // VGA Controller                                     
   vga_controller vga( .hsync(hsync), .vsync(vsync), .row(pix_y), .column(pix_x),
                       .clock(clock), .reset(reset), .video_on(video_on) );

   // PS/2 Keyboard receiver submodule
   wire pressed_enter, pressed_a, pressed_b;
   assign pressed_enter = kb_data_avail && (kb_data == `ENTER);
   assign pressed_a     = kb_data_avail && (kb_data == `KEY_A);
   assign pressed_b     = kb_data_avail && (kb_data == `KEY_B);
   ps2_kb keyboard( .ps2_clock(ps2_clock), .ps2_data(ps2_data), .clock(clock),
                    .reset(reset), .code_avail(kb_data_avail), .code(kb_data) );

   // Graphics generation submodule
   wire       at_prof;
   wire       at_comp;
   wire [1:0] gfx_gb;
   Graphics gfx( .clock(clock), .reset(reset), .state(state), .prof(prof),
                 .pix_x_raw(pix_x), .pix_y(pix_y),
                 .kb_data_avail(kb_data_avail), .kb_data(kb_data),
                 .gb(gfx_gb), .at_prof(at_prof), .at_comp(at_comp) );

   // Text generation submodule
   wire text_display;
   Text txt( .clock(clock), .reset(reset), .state(state), .prof(prof),
             .pix_x_raw(pix_x), .pix_y(pix_y),
             .kb_data_avail(kb_data_avail), .kb_data(kb_data),
             .text_display(text_display) );

   always @( posedge clock ) begin
      if( reset ) begin
         state <= `SPLASH_STATE;
         prof  <= `PROF_TOM;
      end
      else
         case( state )
            `SPLASH_STATE:
               if( pressed_enter )
                  state <= `INTRO_STATE;
            `INTRO_STATE:
               if( pressed_enter ) begin
                  state <= `CEL_STATE;
               end
            `CEL_STATE: begin
               if( at_prof )
                  state <= `ATTACK_STATE;
               if( at_comp && pressed_enter )
                  state <= `COMP_STATE;
            end
            `COMP_STATE:
               if( pressed_enter )
                  state <= `CEL_STATE;
            `ATTACK_STATE:
               if( pressed_enter )
                  state <= `QUESTION_STATE;
            `QUESTION_STATE:
               if( pressed_a || pressed_b ) begin
                  if( prof != `PROF_MARK )
                     prof <= prof + 1;
                  state <= `CEL_STATE;
               end
         endcase
   end

   // VGA source select "mux"
   always @(*) begin
      if( ~video_on )
         gb = `BLACK;
      else begin
         if( text_display )
            gb = `BLACK;
         else
            gb = gfx_gb;
      end
   end

endmodule
