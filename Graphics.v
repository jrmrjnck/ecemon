`include "ecemon.vh"

module Graphics
(
   input       clock,
   input       reset,
   input [2:0] state,
   input [2:0] prof,
   input [7:0] pix_x_raw,
   input [7:0] pix_y,
   input       kb_data_avail,
   input [7:0] kb_data,

   output reg [1:0] gb,
   output           at_prof,
   output           at_comp
);
   
   wire [7:0] pix_x;
   assign pix_x = pix_x_raw + 1;
   
   wire screen_tick;
   assign screen_tick = (pix_x == 8'b0) && (pix_y == 8'b0);

   reg [7:0] prof_x, prof_y;
   wire pressed_right;
   wire pressed_left;
   wire pressed_up;
   wire pressed_down;
   assign pressed_up    = (kb_data_avail && (kb_data == `UP_ARROW));
   assign pressed_down  = (kb_data_avail && (kb_data == `DOWN_ARROW));
   assign pressed_left  = (kb_data_avail && (kb_data == `LEFT_ARROW));
   assign pressed_right = (kb_data_avail && (kb_data == `RIGHT_ARROW));

   localparam FORWARD = 2'b00,
              BACKWARD = 2'b01,
              LEFT = 2'b10,
              RIGHT = 2'b11;
   reg [1:0] motion;

   // Splash screen logo
   wire [1:0] logo_color;
   wire       logo_on;
   //assign logo_on = 1'b0;
   Logo logo( .clock(clock), .x(pix_x), .y(pix_y), 
              .loc_x(8'd0), .loc_y(8'd10),
              .on(logo_on), .color(logo_color) );

   // Bob Lineberry
   wire [1:0] lb_color;
   wire       lb_on;
   //assign lb_on = 1'b0;
   //assign lb_color = 2'b01;
   Bob lb( .clock(clock), .x(pix_x), .y(pix_y),
           .loc_x(8'd64), .loc_y(8'd0),
           .on(lb_on), .color(lb_color) );

   // Floor tile
   wire [1:0] floor_color;
   Floor floor( .clock(clock), .x(pix_x), .y(pix_y), .color(floor_color) );

   // Wall tile
   wire [1:0] wall_color;
   reg        wall_on;
   always @( posedge clock )
      wall_on <= (pix_y[7:5] == 3'b0);
   assign wall_color = (pix_y[2:1]==2'b0) ? 2'b01 : 2'b10;

   // Door
   wire [1:0] door_color;
   reg        door_on;
   always @( posedge clock )
      door_on <= (pix_y[7:5] == 3'b0) && (pix_x[7:5] == 3'd6);
   Door door( .clock(clock), .x(pix_x), .y(pix_y), .color(door_color) );

   // Protagonist forward block
   wire       protag_on;
   reg  [2:0] protag_x, protag_y;
   reg  [1:0] protag_color;
   wire [1:0] protag_f_color, protag_b_color, protag_l_color, protag_r_color;
   Protag_F pf( .clock(clock), .x(pix_x), .y(pix_y),
                .loc_x({protag_x,5'b0}), .loc_y({protag_y,5'b0}),
                .on(protag_on), .color(protag_f_color) );
   Protag_B pb( .clock(clock), .x(pix_x), .y(pix_y),
                .loc_x({protag_x,5'b0}), .loc_y({protag_y,5'b0}),
                .on(), .color(protag_b_color) );
   Protag_L pl( .clock(clock), .x(pix_x), .y(pix_y),
                .loc_x({protag_x,5'b0}), .loc_y({protag_y,5'b0}),
                .on(), .color(protag_l_color) );
   Protag_R pr( .clock(clock), .x(pix_x), .y(pix_y),
                .loc_x({protag_x,5'b0}), .loc_y({protag_y,5'b0}),
                .on(), .color(protag_r_color) );

   always @( posedge clock ) begin
      if( reset )
         motion <= FORWARD;
      else if( state == `CEL_STATE ) begin
         if( pressed_up )
            motion <= BACKWARD;
         else if( pressed_down )
            motion <= FORWARD;
         else if( pressed_right )
            motion <= RIGHT;
         else if( pressed_left )
            motion <= LEFT;
      end
      else
         motion <= BACKWARD;
   end

   always @(*) begin
      case( motion )
         FORWARD: protag_color = protag_f_color;
         BACKWARD: protag_color = protag_b_color;
         RIGHT: protag_color = protag_r_color;
         LEFT: protag_color = protag_l_color;
         default: protag_color = protag_f_color;
      endcase
   end


   // Professor overhead
   wire [1:0] prof_f_color;
   wire       prof_f_on;
   reg  [2:0] prof_f_x, prof_f_y;
   Prof_F prof_f( .clock(clock), .x(pix_x), .y(pix_y),
                  .loc_x({prof_f_x,5'b0}), .loc_y({prof_f_y,5'b0}),
                  .on(prof_f_on), .color(prof_f_color) );

   // Computer
   wire [1:0] computer_color;
   wire       computer_on;
   //assign computer_on = 1'b0;
   Computer comp( .clock(clock), .x(pix_x), .y(pix_y),
                  .loc_x(8'd0), .loc_y(8'd0),
                  .on(computer_on), .color(computer_color) );

   // Desk
   wire [1:0] desk_color;
   wire       desk_on;
   // The middle of the screen
   assign desk_on = (^pix_y[7:6]) && (^pix_x[7:6]);
   //assign desk_on = 1'b0;
   Desk desk( .clock(clock), .x(pix_x+8'd64), .y(pix_y), .color(desk_color) );

   // Carpet
   reg [1:0] carpet_color;
   reg       carpet_on;
   always @( posedge clock ) begin
      carpet_on <= (pix_y[7:5] == 3'd7) && ((pix_x[7:5]==3'd3)||(pix_x[7:5]==3'd4))
                   && (pix_y[4:0]!=5'd0) && (pix_y[4:0]!=5'd31);
      carpet_color <= (pix_y[4:0]==5'd4)||(pix_y[4:0]==5'd5)
                      ||(pix_y[4:0]==5'd26)||(pix_y[4:0]==5'd27) ? `WHITE : `DARK;
   end

   wire [1:0] fight_color;
   wire       fight_on;
   //assign fight_on = 1'b0;
   Protag_Fight fight( .clock(clock), .x(pix_x), .y(pix_y),
                       .loc_x(8'd32), .loc_y(8'd64),
                       .on(fight_on), .color(fight_color) );


   // Dr. Plassmann
   wire [1:0] plass_color;
   wire       plass_on;
   wire [7:0] plass_x, plass_y;
   //assign plass_on = 1'b0;
   //assign plass_color = 2'b00;
   assign plass_x = (state == `SPLASH_STATE) ? 8'd0 : prof_x;
   assign plass_y = (state == `SPLASH_STATE) ? 8'd100 : prof_y;
   Paul plass( .clock(clock), .x(pix_x), .y(pix_y),
               .loc_x(plass_x), .loc_y(plass_y),
               .on(plass_on), .color(plass_color) );

   // Dr. Jones
   wire [1:0] jones_color;
   wire       jones_on;
   wire [7:0] jones_x, jones_y;
   //assign jones_on = 1'b0;
   //assign jones_color = 2'b00;
   assign jones_x = (state == `SPLASH_STATE) ? 8'd128 : prof_x;
   assign jones_y = (state == `SPLASH_STATE) ? 8'd100 : prof_y;
   Mark jones( .clock(clock), .x(pix_x), .y(pix_y),
               .loc_x(jones_x), .loc_y(jones_y),
               .on(jones_on), .color(jones_color) );

   // Instructor Thweatt
   wire [1:0] thweatt_color;
   wire       thweatt_on;
   //assign thweatt_on = 1'b0;
   Jason thweatt( .clock(clock), .x(pix_x), .y(pix_y),
                  .loc_x(prof_x), .loc_y(prof_y),
                  .on(thweatt_on), .color(thweatt_color) );

   // Dr. Martin
   wire [1:0] martin_color;
   wire       martin_on;
   //assign martin_on = 1'b0;
   Tom martin( .clock(clock), .x(pix_x), .y(pix_y),
               .loc_x(prof_x), .loc_y(prof_y),
               .on(martin_on), .color(martin_color) );

   always @( posedge clock ) begin
      if( reset ) begin
         prof_x <= 8'd127;
         prof_y <= 8'd0;
      end
      else if( state == `CEL_STATE ) begin
         prof_x <= 8'd0;
         prof_y <= 8'd0;
      end
      else if( screen_tick && (state==`ATTACK_STATE||state==`QUESTION_STATE)) begin
         if( !prof_x[7] ) // < 8'd128
            prof_x <= prof_x + 8'd1;
      end
   end

   reg [0:9] map[0:9];
   always @( posedge clock ) begin
      if( reset ) begin
         map[0] <= 10'b1111111111;
         map[1] <= 10'b1111111111;
         map[2] <= 10'b1100000001;
         map[3] <= 10'b1000110001;
         map[4] <= 10'b1000110001;
         map[5] <= 10'b1000110001;
         map[6] <= 10'b1000110001;
         map[7] <= 10'b1000000001;
         map[8] <= 10'b1000000001;
         map[9] <= 10'b1111111111;
      end
   end

   // Some kinda ugly hack because I couldn't figure out how to index the map properly
   wire [0:9] up_row;
   wire [0:9] same_row;
   wire [0:9] down_row;
   assign up_row   = map[{1'b0,protag_y}];
   assign same_row = map[protag_y+4'd1];
   assign down_row = map[protag_y+4'd2];

   always @( posedge clock ) begin
      if( reset ) begin
         protag_x <= 3'd3;
         protag_y <= 3'd7;
         prof_f_x <= 3'd7;
         prof_f_y <= 3'd1;
      end
      if( state == `CEL_STATE ) begin
         case( prof )
            `PROF_TOM:   {prof_f_y,prof_f_x} <= {3'd4,3'd7};
            `PROF_JASON: {prof_f_y,prof_f_x} <= {3'd1,3'd1};
            `PROF_PAUL:  {prof_f_y,prof_f_x} <= {3'd4,3'd2};
            `PROF_MARK:  {prof_f_y,prof_f_x} <= {3'd1,3'd6};
         endcase

         if( pressed_left && !same_row[{1'b0,protag_x}] )
            protag_x <= protag_x - 3'd1;
         else if( pressed_right && !same_row[protag_x+4'd2] )
            protag_x <= protag_x + 3'd1;
         else if( pressed_up && !up_row[protag_x+4'd1] )
            protag_y <= protag_y - 3'd1;
         else if( pressed_down && !down_row[protag_x+4'd1] )
            protag_y <= protag_y + 3'd1;
      end
      if( state == `ATTACK_STATE ) begin
         protag_x <= 3'd3;
         protag_y <= 3'd7;
      end
   end

   assign at_prof = (prof_f_x==protag_x) && (prof_f_y==protag_y);
   reg [1:0] prof_color;
   reg prof_on;

   assign at_comp = (protag_x == 0) && (protag_y == 2) && (motion == BACKWARD);

   always @(*) begin
      case( state )
         `SPLASH_STATE:
            if( logo_on )
               gb = logo_color;
            else if( jones_on )
               gb = jones_color;
            else if( plass_on )
               gb = plass_color;
            else
               gb = `WHITE;

         `INTRO_STATE:
            if( lb_on )
               gb = lb_color;
            else
               gb = `WHITE;

         `COMP_STATE,
         `CEL_STATE:
            if( state == `COMP_STATE && pix_y[7] )
               gb = `WHITE;
            else if( protag_on )
               gb = protag_color;
            else if( prof_f_on )
               gb = prof_f_color;
            else if( computer_on )
               gb = computer_color;
            else if( desk_on )
               gb = desk_color;
            else if( door_on )
               gb = door_color;
            else if( wall_on )
               gb = wall_color;
            else if( carpet_on )
               gb = carpet_color;
            else
               gb = floor_color;

         `ATTACK_STATE,
         `QUESTION_STATE:
            if( fight_on )
               gb = fight_color;
            else if( prof_on )
               gb = prof_color;
            else
               gb = `WHITE;

         default: gb = `WHITE;
      endcase
   end

   always @(*) begin
      case( prof )
         `PROF_TOM:
            prof_color = martin_color;
         `PROF_JASON:
            prof_color = thweatt_color;
         `PROF_PAUL:
            prof_color = plass_color;
         `PROF_MARK:
            prof_color = jones_color;
         default
            prof_color = `WHITE;
      endcase
   end
   always @(*) begin
      if( (state == `ATTACK_STATE) || (state == `QUESTION_STATE) )
         prof_on = martin_on || thweatt_on || plass_on || jones_on;
      else
         prof_on = 1'b0;
   end

endmodule
