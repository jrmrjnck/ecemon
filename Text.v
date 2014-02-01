`include "ecemon.vh"

module Text
(
   input       clock,
   input       reset,
   input [2:0] state,
   input [2:0] prof,
   input [7:0] pix_x_raw,
   input [7:0] pix_y,
   input       kb_data_avail,
   input [7:0] kb_data,

   output      text_display
);

   wire [7:0] pix_x;
   assign pix_x = pix_x_raw + 1;

   // Instantiate a font ROM
   wire [10:0] font_rom_addr;
   wire [7:0]  font_word;
   font_rom fonts( .clk(clock), .addr(font_rom_addr), .data(font_word) );

   reg [6:0] char_addr;
   wire [3:0] row_addr;
   wire [7:0] bit_addr;
   wire font_bit;
   wire text_on;
   assign row_addr = pix_y[3:0];
   // Dumb solution
   assign bit_addr = pix_x[2:0]-3'b1;

   // "press start"
   localparam START_Y   = 4'd5,
              START_X   = 5'd10,
              START_LEN = 5'd11;
   wire text_on_start;
   reg  [6:0] char_addr_start;
   assign text_on_start  = (state==3'd0) && (pix_y[7:4] == START_Y) 
                           && (pix_x[7:3] >= START_X) && (pix_x[7:3] < START_X+START_LEN);
   always @(*) begin
      case( pix_x[7:3] )
         START_X+0: char_addr_start = "p";
         START_X+1: char_addr_start = "r";
         START_X+2: char_addr_start = "e";
         START_X+3: char_addr_start = "s";
         START_X+4: char_addr_start = "s";
         START_X+5: char_addr_start = " ";
         START_X+6: char_addr_start = "s";
         START_X+7: char_addr_start = "t";
         START_X+8: char_addr_start = "a";
         START_X+9: char_addr_start = "r";
         default:   char_addr_start = "t";
      endcase
   end

   // "by Jonathan Doman"
   localparam BYLINE_Y   = 4'd15,
              BYLINE_X   = 5'd8,
              BYLINE_LEN = 5'd17;
   wire text_on_byline;
   reg [6:0] char_addr_byline;
   assign text_on_byline = (state==3'd0) && (pix_y[7:4] == BYLINE_Y) 
                           && (pix_x[7:3] >= BYLINE_X) && (pix_x[7:3] < BYLINE_X+BYLINE_LEN);
   always @(*) begin
      case( pix_x[7:3] )
         BYLINE_X+0:  char_addr_byline = "b";
         BYLINE_X+1:  char_addr_byline = "y";
         BYLINE_X+2:  char_addr_byline = " ";
         BYLINE_X+3:  char_addr_byline = "J";
         BYLINE_X+4:  char_addr_byline = "o";
         BYLINE_X+5:  char_addr_byline = "n";
         BYLINE_X+6:  char_addr_byline = "a";
         BYLINE_X+7:  char_addr_byline = "t";
         BYLINE_X+8:  char_addr_byline = "h";
         BYLINE_X+9:  char_addr_byline = "a";
         BYLINE_X+10: char_addr_byline = "n";
         BYLINE_X+11: char_addr_byline = " ";
         BYLINE_X+12: char_addr_byline = "D";
         BYLINE_X+13: char_addr_byline = "o";
         BYLINE_X+14: char_addr_byline = "m";
         BYLINE_X+15: char_addr_byline = "a";
         default:     char_addr_byline = "n";
      endcase
   end

   // Bob's instructions
   localparam NUM_LINES_BOB = 17;
   wire text_on_bob;
   reg [6:0] char_addr_bob;
   reg [4:0] bob_addr_offset;
   wire [7:0] bob_rom_addr;
   assign text_on_bob = pix_y[7]==1;
   assign bob_rom_addr = {pix_y[6:4],pix_x[7:3]};
   always @(*) begin
      case( {2'b0,bob_rom_addr} + {bob_addr_offset,5'b0} )
         10'h22: char_addr_bob = "H";
         10'h23: char_addr_bob = "e";
         10'h24: char_addr_bob = "l";
         10'h25: char_addr_bob = "l";
         10'h26: char_addr_bob = "o";
         10'h28: char_addr_bob = "t";
         10'h29: char_addr_bob = "h";
         10'h2a: char_addr_bob = "e";
         10'h2b: char_addr_bob = "r";
         10'h2c: char_addr_bob = "e";
         10'h2d: char_addr_bob = ",";
         10'h2f: char_addr_bob = "a";
         10'h30: char_addr_bob = "n";
         10'h31: char_addr_bob = "d";
         10'h33: char_addr_bob = "w";
         10'h34: char_addr_bob = "e";
         10'h35: char_addr_bob = "l";
         10'h36: char_addr_bob = "c";
         10'h37: char_addr_bob = "o";
         10'h38: char_addr_bob = "m";
         10'h39: char_addr_bob = "e";
         10'h3b: char_addr_bob = "t";
         10'h3c: char_addr_bob = "o";

         10'h42: char_addr_bob = "t";
         10'h43: char_addr_bob = "h";
         10'h44: char_addr_bob = "e";
         10'h46: char_addr_bob = "C";
         10'h47: char_addr_bob = "E";
         10'h48: char_addr_bob = "L";
         10'h49: char_addr_bob = "!";
         10'h4b: char_addr_bob = "M";
         10'h4c: char_addr_bob = "y";
         10'h4e: char_addr_bob = "n";
         10'h4f: char_addr_bob = "a";
         10'h50: char_addr_bob = "m";
         10'h51: char_addr_bob = "e";
         10'h53: char_addr_bob = "i";
         10'h54: char_addr_bob = "s";
         10'h56: char_addr_bob = "B";
         10'h57: char_addr_bob = "o";
         10'h58: char_addr_bob = "b";
         10'h59: char_addr_bob = ".";

         10'h62: char_addr_bob = "P";
         10'h63: char_addr_bob = "e";
         10'h64: char_addr_bob = "o";
         10'h65: char_addr_bob = "p";
         10'h66: char_addr_bob = "l";
         10'h67: char_addr_bob = "e";
         10'h69: char_addr_bob = "c";
         10'h6a: char_addr_bob = "a";
         10'h6b: char_addr_bob = "l";
         10'h6c: char_addr_bob = "l";
         10'h6e: char_addr_bob = "m";
         10'h6f: char_addr_bob = "e";
         10'h71: char_addr_bob = "t";
         10'h72: char_addr_bob = "h";
         10'h73: char_addr_bob = "e";
         10'h75: char_addr_bob = "E";
         10'h76: char_addr_bob = "C";
         10'h77: char_addr_bob = "E";

         10'h82: char_addr_bob = "W";
         10'h83: char_addr_bob = "i";
         10'h84: char_addr_bob = "z";
         10'h85: char_addr_bob = "a";
         10'h86: char_addr_bob = "r";
         10'h87: char_addr_bob = "d";
         10'h88: char_addr_bob = ".";
         10'h8a: char_addr_bob = "T";
         10'h8b: char_addr_bob = "h";
         10'h8c: char_addr_bob = "i";
         10'h8d: char_addr_bob = "s";
         10'h8f: char_addr_bob = "w";
         10'h90: char_addr_bob = "o";
         10'h91: char_addr_bob = "r";
         10'h92: char_addr_bob = "l";
         10'h93: char_addr_bob = "d";
         10'h95: char_addr_bob = "i";
         10'h96: char_addr_bob = "s";

         10'ha2: char_addr_bob = "i";
         10'ha3: char_addr_bob = "n";
         10'ha4: char_addr_bob = "h";
         10'ha5: char_addr_bob = "a";
         10'ha6: char_addr_bob = "b";
         10'ha7: char_addr_bob = "i";
         10'ha8: char_addr_bob = "t";
         10'ha9: char_addr_bob = "e";
         10'haa: char_addr_bob = "d";
         10'hac: char_addr_bob = "b";
         10'had: char_addr_bob = "y";
         10'haf: char_addr_bob = "p";
         10'hb0: char_addr_bob = "r";
         10'hb1: char_addr_bob = "o";
         10'hb2: char_addr_bob = "f";
         10'hb3: char_addr_bob = "e";
         10'hb4: char_addr_bob = "s";
         10'hb5: char_addr_bob = "s";
         10'hb6: char_addr_bob = "o";
         10'hb7: char_addr_bob = "r";
         10'hb8: char_addr_bob = "s";
         10'hba: char_addr_bob = "a";
         10'hbb: char_addr_bob = "n";
         10'hbc: char_addr_bob = "d";

         10'hc2: char_addr_bob = "l";
         10'hc3: char_addr_bob = "a";
         10'hc4: char_addr_bob = "b";
         10'hc6: char_addr_bob = "g";
         10'hc7: char_addr_bob = "e";
         10'hc8: char_addr_bob = "a";
         10'hc9: char_addr_bob = "r";
         10'hca: char_addr_bob = "!";
         10'hcc: char_addr_bob = "F";
         10'hcd: char_addr_bob = "o";
         10'hce: char_addr_bob = "r";
         10'hd0: char_addr_bob = "s";
         10'hd1: char_addr_bob = "o";
         10'hd2: char_addr_bob = "m";
         10'hd3: char_addr_bob = "e";
         10'hd5: char_addr_bob = "p";
         10'hd6: char_addr_bob = "e";
         10'hd7: char_addr_bob = "o";
         10'hd8: char_addr_bob = "p";
         10'hd9: char_addr_bob = "l";
         10'hda: char_addr_bob = "e";
         10'hdb: char_addr_bob = ",";

         10'he2: char_addr_bob = "e";
         10'he3: char_addr_bob = "l";
         10'he4: char_addr_bob = "e";
         10'he5: char_addr_bob = "c";
         10'he6: char_addr_bob = "t";
         10'he7: char_addr_bob = "r";
         10'he8: char_addr_bob = "o";
         10'he9: char_addr_bob = "n";
         10'hea: char_addr_bob = "i";
         10'heb: char_addr_bob = "c";
         10'hec: char_addr_bob = "s";
         10'hee: char_addr_bob = "i";
         10'hef: char_addr_bob = "s";
         10'hf1: char_addr_bob = "j";
         10'hf2: char_addr_bob = "u";
         10'hf3: char_addr_bob = "s";
         10'hf4: char_addr_bob = "t";
         10'hf6: char_addr_bob = "a";
         10'hf8: char_addr_bob = "h";
         10'hf9: char_addr_bob = "o";
         10'hfa: char_addr_bob = "b";
         10'hfb: char_addr_bob = "b";
         10'hfc: char_addr_bob = "y";
         10'hfd: char_addr_bob = ".";

         10'h102: char_addr_bob = "O";
         10'h103: char_addr_bob = "t";
         10'h104: char_addr_bob = "h";
         10'h105: char_addr_bob = "e";
         10'h106: char_addr_bob = "r";
         10'h107: char_addr_bob = "s";
         10'h109: char_addr_bob = "u";
         10'h10a: char_addr_bob = "s";
         10'h10b: char_addr_bob = "e";
         10'h10d: char_addr_bob = "i";
         10'h10e: char_addr_bob = "t";
         10'h110: char_addr_bob = "t";
         10'h111: char_addr_bob = "o";
         10'h113: char_addr_bob = "d";
         10'h114: char_addr_bob = "r";
         10'h115: char_addr_bob = "i";
         10'h116: char_addr_bob = "v";
         10'h117: char_addr_bob = "e";

         10'h122: char_addr_bob = "t";
         10'h123: char_addr_bob = "r";
         10'h124: char_addr_bob = "a";
         10'h125: char_addr_bob = "i";
         10'h126: char_addr_bob = "n";
         10'h127: char_addr_bob = "s";
         10'h129: char_addr_bob = "a";
         10'h12a: char_addr_bob = "r";
         10'h12b: char_addr_bob = "o";
         10'h12c: char_addr_bob = "u";
         10'h12d: char_addr_bob = "n";
         10'h12e: char_addr_bob = "d";
         10'h12f: char_addr_bob = ".";
         10'h131: char_addr_bob = "M";
         10'h132: char_addr_bob = "y";
         10'h134: char_addr_bob = "p";
         10'h135: char_addr_bob = "r";
         10'h136: char_addr_bob = "o";
         10'h137: char_addr_bob = "f";
         10'h138: char_addr_bob = "e";
         10'h139: char_addr_bob = "s";
         10'h13a: char_addr_bob = "s";
         10'h13b: char_addr_bob = "i";
         10'h13c: char_addr_bob = "o";
         10'h13d: char_addr_bob = "n";

         10'h142: char_addr_bob = "i";
         10'h143: char_addr_bob = "s";
         10'h145: char_addr_bob = "t";
         10'h146: char_addr_bob = "o";
         10'h148: char_addr_bob = "h";
         10'h149: char_addr_bob = "e";
         10'h14a: char_addr_bob = "l";
         10'h14b: char_addr_bob = "p";
         10'h14d: char_addr_bob = "s";
         10'h14e: char_addr_bob = "t";
         10'h14f: char_addr_bob = "u";
         10'h150: char_addr_bob = "d";
         10'h151: char_addr_bob = "e";
         10'h152: char_addr_bob = "n";
         10'h153: char_addr_bob = "t";
         10'h154: char_addr_bob = "s";
         10'h156: char_addr_bob = "s";
         10'h157: char_addr_bob = "t";
         10'h158: char_addr_bob = "u";
         10'h159: char_addr_bob = "d";
         10'h15a: char_addr_bob = "y";

         10'h162: char_addr_bob = "e";
         10'h163: char_addr_bob = "l";
         10'h164: char_addr_bob = "e";
         10'h165: char_addr_bob = "c";
         10'h166: char_addr_bob = "t";
         10'h167: char_addr_bob = "r";
         10'h168: char_addr_bob = "o";
         10'h169: char_addr_bob = "n";
         10'h16a: char_addr_bob = "i";
         10'h16b: char_addr_bob = "c";
         10'h16c: char_addr_bob = "s";
         10'h16d: char_addr_bob = ".";

         10'h182: char_addr_bob = "A";
         10'h184: char_addr_bob = "p";
         10'h185: char_addr_bob = "r";
         10'h186: char_addr_bob = "o";
         10'h187: char_addr_bob = "f";
         10'h188: char_addr_bob = "e";
         10'h189: char_addr_bob = "s";
         10'h18a: char_addr_bob = "s";
         10'h18b: char_addr_bob = "o";
         10'h18c: char_addr_bob = "r";
         10'h18e: char_addr_bob = "c";
         10'h18f: char_addr_bob = "a";
         10'h190: char_addr_bob = "n";
         10'h192: char_addr_bob = "a";
         10'h193: char_addr_bob = "p";
         10'h194: char_addr_bob = "p";
         10'h195: char_addr_bob = "e";
         10'h196: char_addr_bob = "a";
         10'h197: char_addr_bob = "r";
         10'h199: char_addr_bob = "a";
         10'h19a: char_addr_bob = "t";

         10'h1a2: char_addr_bob = "a";
         10'h1a3: char_addr_bob = "n";
         10'h1a4: char_addr_bob = "y";
         10'h1a6: char_addr_bob = "t";
         10'h1a7: char_addr_bob = "i";
         10'h1a8: char_addr_bob = "m";
         10'h1a9: char_addr_bob = "e";
         10'h1ab: char_addr_bob = "w";
         10'h1ac: char_addr_bob = "h";
         10'h1ad: char_addr_bob = "e";
         10'h1ae: char_addr_bob = "n";
         10'h1b0: char_addr_bob = "y";
         10'h1b1: char_addr_bob = "o";
         10'h1b2: char_addr_bob = "u";
         10'h1b3: char_addr_bob = "'";
         10'h1b4: char_addr_bob = "r";
         10'h1b5: char_addr_bob = "e";
         10'h1b7: char_addr_bob = "i";
         10'h1b8: char_addr_bob = "n";
         10'h1ba: char_addr_bob = "t";
         10'h1bb: char_addr_bob = "h";
         10'h1bc: char_addr_bob = "e";

         10'h1c2: char_addr_bob = "l";
         10'h1c3: char_addr_bob = "a";
         10'h1c4: char_addr_bob = "b";
         10'h1c5: char_addr_bob = "!";
         10'h1c7: char_addr_bob = "Y";
         10'h1c8: char_addr_bob = "o";
         10'h1c9: char_addr_bob = "u";
         10'h1cb: char_addr_bob = "n";
         10'h1cc: char_addr_bob = "e";
         10'h1cd: char_addr_bob = "e";
         10'h1ce: char_addr_bob = "d";
         10'h1d0: char_addr_bob = "k";
         10'h1d1: char_addr_bob = "n";
         10'h1d2: char_addr_bob = "o";
         10'h1d3: char_addr_bob = "w";
         10'h1d4: char_addr_bob = "l";
         10'h1d5: char_addr_bob = "e";
         10'h1d6: char_addr_bob = "d";
         10'h1d7: char_addr_bob = "g";
         10'h1d8: char_addr_bob = "e";
         10'h1da: char_addr_bob = "f";
         10'h1db: char_addr_bob = "o";
         10'h1dc: char_addr_bob = "r";

         10'h1e2: char_addr_bob = "y";
         10'h1e3: char_addr_bob = "o";
         10'h1e4: char_addr_bob = "u";
         10'h1e5: char_addr_bob = "r";
         10'h1e7: char_addr_bob = "p";
         10'h1e8: char_addr_bob = "r";
         10'h1e9: char_addr_bob = "o";
         10'h1ea: char_addr_bob = "t";
         10'h1eb: char_addr_bob = "e";
         10'h1ec: char_addr_bob = "c";
         10'h1ed: char_addr_bob = "t";
         10'h1ee: char_addr_bob = "i";
         10'h1ef: char_addr_bob = "o";
         10'h1f0: char_addr_bob = "n";
         10'h1f1: char_addr_bob = ".";
         10'h1f3: char_addr_bob = "I";
         10'h1f5: char_addr_bob = "k";
         10'h1f6: char_addr_bob = "n";
         10'h1f7: char_addr_bob = "o";
         10'h1f8: char_addr_bob = "w";
         10'h1fa: char_addr_bob = "y";
         10'h1fb: char_addr_bob = "o";
         10'h1fc: char_addr_bob = "u";

         10'h202: char_addr_bob = "h";
         10'h203: char_addr_bob = "a";
         10'h204: char_addr_bob = "v";
         10'h205: char_addr_bob = "e";
         10'h207: char_addr_bob = "t";
         10'h208: char_addr_bob = "h";
         10'h209: char_addr_bob = "i";
         10'h20a: char_addr_bob = "s";
         10'h20c: char_addr_bob = "k";
         10'h20d: char_addr_bob = "n";
         10'h20e: char_addr_bob = "o";
         10'h20f: char_addr_bob = "w";
         10'h210: char_addr_bob = "l";
         10'h211: char_addr_bob = "e";
         10'h212: char_addr_bob = "d";
         10'h213: char_addr_bob = "g";
         10'h214: char_addr_bob = "e";
         10'h215: char_addr_bob = ".";

         10'h222: char_addr_bob = "G";
         10'h223: char_addr_bob = "o";
         10'h225: char_addr_bob = "o";
         10'h226: char_addr_bob = "n";
         10'h227: char_addr_bob = ",";
         10'h229: char_addr_bob = "u";
         10'h22a: char_addr_bob = "s";
         10'h22b: char_addr_bob = "e";
         10'h22d: char_addr_bob = "i";
         10'h22e: char_addr_bob = "t";
         10'h22f: char_addr_bob = "!";
         default: char_addr_bob = " ";
      endcase
   end

   wire fight_text_on;
   assign fight_text_on = pix_y[7] == 1'b1 && (pix_y[7:4] == 4'd8 || pix_y[7:4] == 4'd15
                          || pix_x[7:3] == 5'd0 || pix_x[7:3] == 5'd31);
   reg [6:0] char_addr_fight;
   wire [7:0] fight_rom_addr;
   assign fight_rom_addr = {pix_y[6:4],pix_x[7:3]};
   always @(*) begin
      case( fight_rom_addr )
         8'h00: char_addr_fight = 6'h6;
         8'h01, 8'h02, 8'h03, 8'h04, 
         8'h05, 8'h06, 8'h07, 8'h08, 
         8'h09, 8'h0A, 8'h0B, 8'h0C, 
         8'h0D, 8'h0E, 8'h0F, 8'h10, 
         8'h11, 8'h12, 8'h13, 8'h14, 
         8'h15, 8'h16, 8'h17, 8'h18, 
         8'h19, 8'h1A, 8'h1B, 8'h1C, 8'h1D, 
         8'h1E: char_addr_fight = 6'h5;
         8'h1F: char_addr_fight = 6'h7;

         8'h20: char_addr_fight = 6'h3;
         8'h3F: char_addr_fight = 6'h4;

         8'h40: char_addr_fight = 6'h3;
         8'h5F: char_addr_fight = 6'h4;

         8'h60: char_addr_fight = 6'h3;
         8'h7F: char_addr_fight = 6'h4;

         8'h80: char_addr_fight = 6'h3;
         8'h9F: char_addr_fight = 6'h4;

         8'hA0: char_addr_fight = 6'h3;
         8'hBF: char_addr_fight = 6'h4;

         8'hC0: char_addr_fight = 6'h3;
         8'hDF: char_addr_fight = 6'h4;

         8'hE0: char_addr_fight = 8'h1;
         8'hE1, 8'hE2, 8'hE3, 8'hE4, 
         8'hE5, 8'hE6, 8'hE7, 8'hE8, 
         8'hE9, 8'hEA, 8'hEB, 8'hEC, 
         8'hED, 8'hEE, 8'hEF, 8'hF0, 
         8'hF1, 8'hF2, 8'hF3, 8'hF4, 
         8'hF5, 8'hF6, 8'hF7, 8'hF8, 
         8'hF9, 8'hFA, 8'hFB, 8'hFC, 8'hFD, 
         8'hFE: char_addr_fight = 6'h8;
         8'hFF: char_addr_fight = 6'h2;
         default: char_addr_fight = 6'h0;
      endcase
   end

   wire martin_attack_on;
   reg [6:0] martin_attack_char;
   assign martin_attack_on = (prof == `PROF_TOM) && pix_y[7]==1'b1;
   always @(*) begin
      case( {pix_y[6:4],pix_x[7:3]} )
         8'h22: martin_attack_char = "W";
         8'h23: martin_attack_char = "i";
         8'h24: martin_attack_char = "l";
         8'h25: martin_attack_char = "d";
         8'h26: martin_attack_char = " ";
         8'h27: martin_attack_char = "M";
         8'h28: martin_attack_char = "A";
         8'h29: martin_attack_char = "R";
         8'h2A: martin_attack_char = "T";
         8'h2B: martin_attack_char = "I";
         8'h2C: martin_attack_char = "N";
         8'h2D: martin_attack_char = " ";
         8'h2E: martin_attack_char = "a";
         8'h2F: martin_attack_char = "p";
         8'h30: martin_attack_char = "p";
         8'h31: martin_attack_char = "e";
         8'h32: martin_attack_char = "a";
         8'h33: martin_attack_char = "r";
         8'h34: martin_attack_char = "e";
         8'h35: martin_attack_char = "d";
         8'h36: martin_attack_char = "!";

         8'h42: martin_attack_char = "H";
         8'h43: martin_attack_char = "e";
         8'h44: martin_attack_char = " ";
         8'h45: martin_attack_char = "u";
         8'h46: martin_attack_char = "s";
         8'h47: martin_attack_char = "e";
         8'h48: martin_attack_char = "d";
         8'h49: martin_attack_char = " ";
         8'h4A: martin_attack_char = "J";
         8'h4B: martin_attack_char = "e";
         8'h4C: martin_attack_char = "d";
         8'h4D: martin_attack_char = "i";
         8'h4E: martin_attack_char = " ";
         8'h4F: martin_attack_char = "M";
         8'h50: martin_attack_char = "i";
         8'h51: martin_attack_char = "n";
         8'h52: martin_attack_char = "d";
         8'h53: martin_attack_char = " ";
         8'h54: martin_attack_char = "T";
         8'h55: martin_attack_char = "r";
         8'h56: martin_attack_char = "i";
         8'h57: martin_attack_char = "c";
         8'h58: martin_attack_char = "k";
         8'h59: martin_attack_char = "!";
         default: martin_attack_char = " ";
      endcase
   end

   localparam MARTIN_Q_LINES = 3'd7;
   wire martin_question_on;
   reg [6:0] martin_question_char;
   assign martin_question_on = (prof == `PROF_TOM) && pix_y[7]==1'b1;
   always @(*) begin
   case( {pix_y[6:4],pix_x[7:3]} )
   8'h22: martin_question_char = "I";
   8'h23: martin_question_char = "n";
   8'h24: martin_question_char = " ";
   8'h25: martin_question_char = "i";
   8'h26: martin_question_char = "t";
   8'h27: martin_question_char = "s";
   8'h28: martin_question_char = " ";
   8'h29: martin_question_char = "m";
   8'h2a: martin_question_char = "i";
   8'h2b: martin_question_char = "n";
   8'h2c: martin_question_char = "i";
   8'h2d: martin_question_char = "m";
   8'h2e: martin_question_char = "a";
   8'h2f: martin_question_char = "l";
   8'h30: martin_question_char = " ";
   8'h31: martin_question_char = "t";
   8'h32: martin_question_char = "w";
   8'h33: martin_question_char = "o";
   8'h34: martin_question_char = "-";
   8'h35: martin_question_char = "l";
   8'h36: martin_question_char = "e";
   8'h37: martin_question_char = "v";
   8'h38: martin_question_char = "e";
   8'h39: martin_question_char = "l";

   8'h42: martin_question_char = "f";
   8'h43: martin_question_char = "o";
   8'h44: martin_question_char = "r";
   8'h45: martin_question_char = "m";
   8'h46: martin_question_char = ",";
   8'h47: martin_question_char = " ";
   8'h48: martin_question_char = "f";
   8'h49: martin_question_char = "=";
   8'h4a: martin_question_char = "S";
   8'h4b: martin_question_char = "U";
   8'h4c: martin_question_char = "M";
   8'h4d: martin_question_char = " ";
   8'h4e: martin_question_char = "m";
   8'h4f: martin_question_char = "(";
   8'h50: martin_question_char = "0";
   8'h51: martin_question_char = ",";
   8'h52: martin_question_char = "2";
   8'h53: martin_question_char = ",";
   8'h54: martin_question_char = "7";
   8'h55: martin_question_char = ",";
   8'h56: martin_question_char = "1";
   8'h57: martin_question_char = "0";
   8'h58: martin_question_char = ",";
   8'h59: martin_question_char = "1";
   8'h5a: martin_question_char = "1";
   8'h5b: martin_question_char = ",";

   8'h62: martin_question_char = "1";
   8'h63: martin_question_char = "2";
   8'h64: martin_question_char = ",";
   8'h65: martin_question_char = "1";
   8'h66: martin_question_char = "3";
   8'h67: martin_question_char = ",";
   8'h68: martin_question_char = "1";
   8'h69: martin_question_char = "4";
   8'h6a: martin_question_char = ")";
   8'h6b: martin_question_char = " ";
   8'h6c: martin_question_char = "n";
   8'h6d: martin_question_char = "e";
   8'h6e: martin_question_char = "e";
   8'h6f: martin_question_char = "d";
   8'h70: martin_question_char = "s";
   8'h71: martin_question_char = " ";
   8'h72: martin_question_char = "h";
   8'h73: martin_question_char = "o";
   8'h74: martin_question_char = "w";
   8'h75: martin_question_char = " ";
   8'h76: martin_question_char = "m";
   8'h77: martin_question_char = "a";
   8'h78: martin_question_char = "n";
   8'h79: martin_question_char = "y";
   8'h7a: martin_question_char = " ";
   8'h7b: martin_question_char = "O";
   8'h7c: martin_question_char = "R";

   8'h82: martin_question_char = "g";
   8'h83: martin_question_char = "a";
   8'h84: martin_question_char = "t";
   8'h85: martin_question_char = "e";
   8'h86: martin_question_char = "s";
   8'h87: martin_question_char = " ";
   8'h88: martin_question_char = "t";
   8'h89: martin_question_char = "o";
   8'h8a: martin_question_char = " ";
   8'h8b: martin_question_char = "b";
   8'h8c: martin_question_char = "e";
   8'h8d: martin_question_char = " ";
   8'h8e: martin_question_char = "i";
   8'h8f: martin_question_char = "m";
   8'h90: martin_question_char = "p";
   8'h91: martin_question_char = "l";
   8'h92: martin_question_char = "e";
   8'h93: martin_question_char = "m";
   8'h94: martin_question_char = "e";
   8'h95: martin_question_char = "n";
   8'h96: martin_question_char = "t";
   8'h97: martin_question_char = "e";
   8'h98: martin_question_char = "d";
   8'h99: martin_question_char = "?";

   8'ha3: martin_question_char = "A";
   8'ha4: martin_question_char = ":";
   8'ha5: martin_question_char = " ";
   8'ha6: martin_question_char = "4";

   8'hc3: martin_question_char = "B";
   8'hc4: martin_question_char = ":";
   8'hc5: martin_question_char = " ";
   8'hc6: martin_question_char = "5";
   default: martin_question_char = " ";
   endcase
   end

   wire jones_attack_on;
   reg [6:0] jones_attack_char;
   assign jones_attack_on = (prof == `PROF_MARK) && pix_y[7]==1'b1;
   always @(*) begin
   case( {pix_y[6:4],pix_x[7:3]} )
   8'h22: jones_attack_char = "J";
   8'h23: jones_attack_char = "O";
   8'h24: jones_attack_char = "N";
   8'h25: jones_attack_char = "E";
   8'h26: jones_attack_char = "S";
   8'h27: jones_attack_char = " ";
   8'h28: jones_attack_char = "a";
   8'h29: jones_attack_char = "p";
   8'h2a: jones_attack_char = "p";
   8'h2b: jones_attack_char = "e";
   8'h2c: jones_attack_char = "a";
   8'h2d: jones_attack_char = "r";
   8'h2e: jones_attack_char = "e";
   8'h2f: jones_attack_char = "d";
   8'h30: jones_attack_char = "!";

   8'h42: jones_attack_char = "H";
   8'h43: jones_attack_char = "e";
   8'h44: jones_attack_char = " ";
   8'h45: jones_attack_char = "u";
   8'h46: jones_attack_char = "s";
   8'h47: jones_attack_char = "e";
   8'h48: jones_attack_char = "d";
   8'h49: jones_attack_char = " ";
   8'h4a: jones_attack_char = "L";
   8'h4b: jones_attack_char = "e";
   8'h4c: jones_attack_char = "e";
   8'h4d: jones_attack_char = "r";
   8'h4e: jones_attack_char = ".";

   8'h62: jones_attack_char = "I";
   8'h63: jones_attack_char = "t";
   8'h64: jones_attack_char = "'";
   8'h65: jones_attack_char = "s";
   8'h66: jones_attack_char = " ";
   8'h67: jones_attack_char = "s";
   8'h68: jones_attack_char = "u";
   8'h69: jones_attack_char = "p";
   8'h6a: jones_attack_char = "e";
   8'h6b: jones_attack_char = "r";
   8'h6c: jones_attack_char = " ";
   8'h6d: jones_attack_char = "e";
   8'h6e: jones_attack_char = "f";
   8'h6f: jones_attack_char = "f";
   8'h70: jones_attack_char = "e";
   8'h71: jones_attack_char = "c";
   8'h72: jones_attack_char = "t";
   8'h73: jones_attack_char = "i";
   8'h74: jones_attack_char = "v";
   8'h75: jones_attack_char = "e";
   8'h76: jones_attack_char = "!";
   default: jones_attack_char = " ";
   endcase
   end


   wire jones_question_on;
   reg [6:0] jones_question_char;
   assign jones_question_on = (prof == `PROF_MARK) && pix_y[7]==1'b1;
   always @(*) begin
   case( {pix_y[6:4],pix_x[7:3]} )
   8'h22: jones_question_char = "S";
   8'h23: jones_question_char = "u";
   8'h24: jones_question_char = "r";
   8'h25: jones_question_char = "e";
   8'h26: jones_question_char = ",";
   8'h27: jones_question_char = " ";
   8'h28: jones_question_char = "i";
   8'h29: jones_question_char = "t";
   8'h2a: jones_question_char = " ";
   8'h2b: jones_question_char = "s";
   8'h2c: jones_question_char = "e";
   8'h2d: jones_question_char = "e";
   8'h2e: jones_question_char = "m";
   8'h2f: jones_question_char = "s";
   8'h30: jones_question_char = " ";
   8'h31: jones_question_char = "t";
   8'h32: jones_question_char = "o";
   8'h33: jones_question_char = " ";
   8'h34: jones_question_char = "w";
   8'h35: jones_question_char = "o";
   8'h36: jones_question_char = "r";
   8'h37: jones_question_char = "k";
   8'h38: jones_question_char = ",";
   8'h39: jones_question_char = " ";
   8'h3a: jones_question_char = "b";
   8'h3b: jones_question_char = "u";
   8'h3c: jones_question_char = "t";

   8'h42: jones_question_char = "h";
   8'h43: jones_question_char = "o";
   8'h44: jones_question_char = "w";
   8'h45: jones_question_char = " ";
   8'h46: jones_question_char = "d";
   8'h47: jones_question_char = "o";
   8'h48: jones_question_char = " ";
   8'h49: jones_question_char = "y";
   8'h4a: jones_question_char = "o";
   8'h4b: jones_question_char = "u";
   8'h4c: jones_question_char = " ";
   8'h4d: jones_question_char = "k";
   8'h4e: jones_question_char = "n";
   8'h4f: jones_question_char = "o";
   8'h50: jones_question_char = "w";
   8'h51: jones_question_char = " ";
   8'h52: jones_question_char = "i";
   8'h53: jones_question_char = "t";
   8'h54: jones_question_char = "'";
   8'h55: jones_question_char = "s";

   8'h62: jones_question_char = "r";
   8'h63: jones_question_char = "o";
   8'h64: jones_question_char = "b";
   8'h65: jones_question_char = "u";
   8'h66: jones_question_char = "s";
   8'h67: jones_question_char = "t";
   8'h68: jones_question_char = "?";

   8'h83: jones_question_char = "A";
   8'h84: jones_question_char = ":";
   8'h85: jones_question_char = " ";
   8'h86: jones_question_char = "U";
   8'h87: jones_question_char = "m";
   8'h88: jones_question_char = "m";
   8'h89: jones_question_char = ".";
   8'h8a: jones_question_char = ".";
   8'h8b: jones_question_char = ".";

   8'ha3: jones_question_char = "B";
   8'ha4: jones_question_char = ":";
   8'ha5: jones_question_char = " ";
   8'ha6: jones_question_char = "I";
   8'ha7: jones_question_char = " ";
   8'ha8: jones_question_char = "d";
   8'ha9: jones_question_char = "o";
   8'haa: jones_question_char = "n";
   8'hab: jones_question_char = "'";
   8'hac: jones_question_char = "t";
   default: jones_question_char = " ";
   endcase
   end


   wire plass_attack_on;
   reg [6:0] plass_attack_char;
   assign plass_attack_on = (prof == `PROF_PAUL) && pix_y[7]==1'b1;
   always @(*) begin
   case( {pix_y[6:4],pix_x[7:3]} )
   8'h22: plass_attack_char = "P";
   8'h23: plass_attack_char = "L";
   8'h24: plass_attack_char = "A";
   8'h25: plass_attack_char = "S";
   8'h26: plass_attack_char = "S";
   8'h27: plass_attack_char = "M";
   8'h28: plass_attack_char = "A";
   8'h29: plass_attack_char = "N";
   8'h2a: plass_attack_char = "N";
   8'h2b: plass_attack_char = " ";
   8'h2c: plass_attack_char = "s";
   8'h2d: plass_attack_char = "i";
   8'h2e: plass_attack_char = "g";
   8'h2f: plass_attack_char = "h";
   8'h30: plass_attack_char = "t";
   8'h31: plass_attack_char = "e";
   8'h32: plass_attack_char = "d";
   8'h33: plass_attack_char = " ";
   8'h34: plass_attack_char = "i";
   8'h35: plass_attack_char = "n";
   8'h36: plass_attack_char = " ";
   8'h37: plass_attack_char = "t";
   8'h38: plass_attack_char = "a";
   8'h39: plass_attack_char = "l";
   8'h3a: plass_attack_char = "l";

   8'h42: plass_attack_char = "g";
   8'h43: plass_attack_char = "r";
   8'h44: plass_attack_char = "a";
   8'h45: plass_attack_char = "s";
   8'h46: plass_attack_char = "s";
   8'h47: plass_attack_char = ".";
   8'h48: plass_attack_char = " ";
   8'h49: plass_attack_char = "W";
   8'h4a: plass_attack_char = "a";
   8'h4b: plass_attack_char = "t";
   8'h4c: plass_attack_char = "c";
   8'h4d: plass_attack_char = "h";
   8'h4e: plass_attack_char = " ";
   8'h4f: plass_attack_char = "o";
   8'h50: plass_attack_char = "u";
   8'h51: plass_attack_char = "t";
   8'h52: plass_attack_char = " ";
   8'h53: plass_attack_char = "f";
   8'h54: plass_attack_char = "o";
   8'h55: plass_attack_char = "r";
   8'h56: plass_attack_char = " ";
   8'h57: plass_attack_char = "h";
   8'h58: plass_attack_char = "i";
   8'h59: plass_attack_char = "s";

   8'h62: plass_attack_char = "i";
   8'h63: plass_attack_char = "P";
   8'h64: plass_attack_char = "h";
   8'h65: plass_attack_char = "o";
   8'h66: plass_attack_char = "n";
   8'h67: plass_attack_char = "e";
   8'h68: plass_attack_char = "!";
   default: plass_attack_char = " ";
   endcase
   end


   wire plass_question_on;
   reg [6:0] plass_question_char;
   assign plass_question_on = (prof == `PROF_PAUL) && pix_y[7]==1'b1;
   always @(*) begin
   case( {pix_y[6:4],pix_x[7:3]} )
   8'h22: plass_question_char = "T";
   8'h23: plass_question_char = "h";
   8'h24: plass_question_char = "e";
   8'h25: plass_question_char = " ";
   8'h26: plass_question_char = "d";
   8'h27: plass_question_char = "i";
   8'h28: plass_question_char = "n";
   8'h29: plass_question_char = "i";
   8'h2a: plass_question_char = "n";
   8'h2b: plass_question_char = "g";
   8'h2c: plass_question_char = " ";
   8'h2d: plass_question_char = "p";
   8'h2e: plass_question_char = "h";
   8'h2f: plass_question_char = "i";
   8'h30: plass_question_char = "l";
   8'h31: plass_question_char = "o";
   8'h32: plass_question_char = "s";
   8'h33: plass_question_char = "o";
   8'h34: plass_question_char = "p";
   8'h35: plass_question_char = "h";
   8'h36: plass_question_char = "e";
   8'h37: plass_question_char = "r";
   8'h38: plass_question_char = "s";

   8'h42: plass_question_char = "p";
   8'h43: plass_question_char = "r";
   8'h44: plass_question_char = "o";
   8'h45: plass_question_char = "b";
   8'h46: plass_question_char = "l";
   8'h47: plass_question_char = "e";
   8'h48: plass_question_char = "m";
   8'h49: plass_question_char = " ";
   8'h4a: plass_question_char = "i";
   8'h4b: plass_question_char = "s";
   8'h4c: plass_question_char = " ";
   8'h4d: plass_question_char = "b";
   8'h4e: plass_question_char = "e";
   8'h4f: plass_question_char = "s";
   8'h50: plass_question_char = "t";
   8'h51: plass_question_char = " ";
   8'h52: plass_question_char = "s";
   8'h53: plass_question_char = "o";
   8'h54: plass_question_char = "l";
   8'h55: plass_question_char = "v";
   8'h56: plass_question_char = "e";
   8'h57: plass_question_char = "d";

   8'h62: plass_question_char = "w";
   8'h63: plass_question_char = "i";
   8'h64: plass_question_char = "t";
   8'h65: plass_question_char = "h";
   8'h66: plass_question_char = " ";
   8'h67: plass_question_char = "a";
   8'h68: plass_question_char = ":";

   8'h83: plass_question_char = "A";
   8'h84: plass_question_char = ":";
   8'h85: plass_question_char = " ";
   8'h86: plass_question_char = "m";
   8'h87: plass_question_char = "u";
   8'h88: plass_question_char = "t";
   8'h89: plass_question_char = "e";
   8'h8a: plass_question_char = "x";

   8'ha3: plass_question_char = "B";
   8'ha4: plass_question_char = ":";
   8'ha5: plass_question_char = " ";
   8'ha6: plass_question_char = "s";
   8'ha7: plass_question_char = "e";
   8'ha8: plass_question_char = "m";
   8'ha9: plass_question_char = "a";
   8'haa: plass_question_char = "p";
   8'hab: plass_question_char = "h";
   8'hac: plass_question_char = "o";
   8'had: plass_question_char = "r";
   8'hae: plass_question_char = "e";
   default: plass_question_char = " ";
   endcase
   end

   wire thweatt_attack_on;
   reg [6:0] thweatt_attack_char;
   assign thweatt_attack_on = (prof == `PROF_JASON) && pix_y[7]==1'b1;
   always @(*) begin
   case( {pix_y[6:4],pix_x[7:3]} )
   8'h22: thweatt_attack_char = "W";
   8'h23: thweatt_attack_char = "i";
   8'h24: thweatt_attack_char = "l";
   8'h25: thweatt_attack_char = "d";
   8'h26: thweatt_attack_char = " ";
   8'h27: thweatt_attack_char = "T";
   8'h28: thweatt_attack_char = "H";
   8'h29: thweatt_attack_char = "W";
   8'h2a: thweatt_attack_char = "E";
   8'h2b: thweatt_attack_char = "A";
   8'h2c: thweatt_attack_char = "T";
   8'h2d: thweatt_attack_char = "T";
   8'h2e: thweatt_attack_char = " ";
   8'h2f: thweatt_attack_char = "a";
   8'h30: thweatt_attack_char = "p";
   8'h31: thweatt_attack_char = "p";
   8'h32: thweatt_attack_char = "e";
   8'h33: thweatt_attack_char = "a";
   8'h34: thweatt_attack_char = "r";
   8'h35: thweatt_attack_char = "e";
   8'h36: thweatt_attack_char = "d";
   8'h37: thweatt_attack_char = "!";
   8'h38: thweatt_attack_char = " ";
   8'h39: thweatt_attack_char = "H";
   8'h3a: thweatt_attack_char = "e";

   8'h42: thweatt_attack_char = "u";
   8'h43: thweatt_attack_char = "s";
   8'h44: thweatt_attack_char = "e";
   8'h45: thweatt_attack_char = "s";
   8'h46: thweatt_attack_char = " ";
   8'h47: thweatt_attack_char = "B";
   8'h48: thweatt_attack_char = "e";
   8'h49: thweatt_attack_char = "w";
   8'h4a: thweatt_attack_char = "i";
   8'h4b: thweatt_attack_char = "l";
   8'h4c: thweatt_attack_char = "d";
   8'h4d: thweatt_attack_char = "e";
   8'h4e: thweatt_attack_char = "r";
   8'h4f: thweatt_attack_char = "i";
   8'h50: thweatt_attack_char = "n";
   8'h51: thweatt_attack_char = "g";
   8'h52: thweatt_attack_char = " ";
   8'h53: thweatt_attack_char = "V";
   8'h54: thweatt_attack_char = "e";
   8'h55: thweatt_attack_char = "r";
   8'h56: thweatt_attack_char = "b";
   8'h57: thweatt_attack_char = "i";
   8'h58: thweatt_attack_char = "a";
   8'h59: thweatt_attack_char = "g";
   8'h5a: thweatt_attack_char = "e";
   8'h5b: thweatt_attack_char = "!";
   default: thweatt_attack_char = " ";
   endcase
   end

   localparam THWEATT_Q_LINES = 4'd15;
   wire thweatt_question_on;
   reg [6:0] thweatt_question_char;
   reg [3:0] thweatt_q_offset;
   assign thweatt_question_on = (prof == `PROF_JASON) && pix_y[7]==1'b1;
   always @(*) begin
   case( {1'b0,pix_y[6:4],pix_x[7:3]} + {thweatt_q_offset,5'b0})
   9'h22: thweatt_question_char = "C";
   9'h23: thweatt_question_char = "e";
   9'h24: thweatt_question_char = "r";
   9'h25: thweatt_question_char = "t";
   9'h26: thweatt_question_char = "a";
   9'h27: thweatt_question_char = "i";
   9'h28: thweatt_question_char = "n";
   9'h29: thweatt_question_char = " ";
   9'h2a: thweatt_question_char = "s";
   9'h2b: thweatt_question_char = "i";
   9'h2c: thweatt_question_char = "t";
   9'h2d: thweatt_question_char = "u";
   9'h2e: thweatt_question_char = "a";
   9'h2f: thweatt_question_char = "t";
   9'h30: thweatt_question_char = "i";
   9'h31: thweatt_question_char = "o";
   9'h32: thweatt_question_char = "n";
   9'h33: thweatt_question_char = "s";
   9'h34: thweatt_question_char = " ";
   9'h35: thweatt_question_char = "m";
   9'h36: thweatt_question_char = "a";
   9'h37: thweatt_question_char = "y";

   9'h42: thweatt_question_char = "r";
   9'h43: thweatt_question_char = "e";
   9'h44: thweatt_question_char = "s";
   9'h45: thweatt_question_char = "u";
   9'h46: thweatt_question_char = "l";
   9'h47: thweatt_question_char = "t";
   9'h48: thweatt_question_char = " ";
   9'h49: thweatt_question_char = "i";
   9'h4a: thweatt_question_char = "n";
   9'h4b: thweatt_question_char = " ";
   9'h4c: thweatt_question_char = "a";
   9'h4d: thweatt_question_char = " ";
   9'h4e: thweatt_question_char = "p";
   9'h4f: thweatt_question_char = "a";
   9'h50: thweatt_question_char = "r";
   9'h51: thweatt_question_char = "t";
   9'h52: thweatt_question_char = "i";
   9'h53: thweatt_question_char = "c";
   9'h54: thweatt_question_char = "u";
   9'h55: thweatt_question_char = "l";
   9'h56: thweatt_question_char = "a";
   9'h57: thweatt_question_char = "r";

   9'h62: thweatt_question_char = "p";
   9'h63: thweatt_question_char = "r";
   9'h64: thweatt_question_char = "e";
   9'h65: thweatt_question_char = "s";
   9'h66: thweatt_question_char = "e";
   9'h67: thweatt_question_char = "n";
   9'h68: thweatt_question_char = "t";
   9'h69: thweatt_question_char = " ";
   9'h6a: thweatt_question_char = "s";
   9'h6b: thweatt_question_char = "t";
   9'h6c: thweatt_question_char = "a";
   9'h6d: thweatt_question_char = "t";
   9'h6e: thweatt_question_char = "e";
   9'h6f: thweatt_question_char = " ";
   9'h70: thweatt_question_char = "a";
   9'h71: thweatt_question_char = "n";
   9'h72: thweatt_question_char = "d";
   9'h73: thweatt_question_char = " ";
   9'h74: thweatt_question_char = "i";
   9'h75: thweatt_question_char = "n";
   9'h76: thweatt_question_char = "p";
   9'h77: thweatt_question_char = "u";
   9'h78: thweatt_question_char = "t";

   9'h82: thweatt_question_char = "s";
   9'h83: thweatt_question_char = "i";
   9'h84: thweatt_question_char = "t";
   9'h85: thweatt_question_char = "u";
   9'h86: thweatt_question_char = "a";
   9'h87: thweatt_question_char = "t";
   9'h88: thweatt_question_char = "i";
   9'h89: thweatt_question_char = "o";
   9'h8a: thweatt_question_char = "n";
   9'h8b: thweatt_question_char = " ";
   9'h8c: thweatt_question_char = "r";
   9'h8d: thweatt_question_char = "e";
   9'h8e: thweatt_question_char = "s";
   9'h8f: thweatt_question_char = "u";
   9'h90: thweatt_question_char = "l";
   9'h91: thweatt_question_char = "t";
   9'h92: thweatt_question_char = "i";
   9'h93: thweatt_question_char = "n";
   9'h94: thweatt_question_char = "g";
   9'h95: thweatt_question_char = " ";
   9'h96: thweatt_question_char = "i";
   9'h97: thweatt_question_char = "n";

   9'ha2: thweatt_question_char = "a";
   9'ha3: thweatt_question_char = " ";
   9'ha4: thweatt_question_char = "d";
   9'ha5: thweatt_question_char = "o";
   9'ha6: thweatt_question_char = "n";
   9'ha7: thweatt_question_char = "'";
   9'ha8: thweatt_question_char = "t";
   9'ha9: thweatt_question_char = " ";
   9'haa: thweatt_question_char = "c";
   9'hab: thweatt_question_char = "a";
   9'hac: thweatt_question_char = "r";
   9'had: thweatt_question_char = "e";
   9'hae: thweatt_question_char = " ";
   9'haf: thweatt_question_char = "n";
   9'hb0: thweatt_question_char = "e";
   9'hb1: thweatt_question_char = "x";
   9'hb2: thweatt_question_char = "t";
   9'hb3: thweatt_question_char = " ";
   9'hb4: thweatt_question_char = "s";
   9'hb5: thweatt_question_char = "t";
   9'hb6: thweatt_question_char = "a";
   9'hb7: thweatt_question_char = "t";
   9'hb8: thweatt_question_char = "e";
   9'hb9: thweatt_question_char = ".";

   9'hc2: thweatt_question_char = "T";
   9'hc3: thweatt_question_char = "h";
   9'hc4: thweatt_question_char = "e";
   9'hc5: thweatt_question_char = " ";
   9'hc6: thweatt_question_char = "e";
   9'hc7: thweatt_question_char = "s";
   9'hc8: thweatt_question_char = "s";
   9'hc9: thweatt_question_char = "e";
   9'hca: thweatt_question_char = "n";
   9'hcb: thweatt_question_char = "c";
   9'hcc: thweatt_question_char = "e";
   9'hcd: thweatt_question_char = " ";
   9'hce: thweatt_question_char = "o";
   9'hcf: thweatt_question_char = "f";
   9'hd0: thweatt_question_char = " ";
   9'hd1: thweatt_question_char = "a";
   9'hd2: thweatt_question_char = " ";
   9'hd3: thweatt_question_char = "d";
   9'hd4: thweatt_question_char = "o";
   9'hd5: thweatt_question_char = "n";
   9'hd6: thweatt_question_char = "'";
   9'hd7: thweatt_question_char = "t";
   9'hd8: thweatt_question_char = " ";
   9'hd9: thweatt_question_char = "c";
   9'hda: thweatt_question_char = "a";
   9'hdb: thweatt_question_char = "r";
   9'hdc: thweatt_question_char = "e";

   9'he2: thweatt_question_char = "i";
   9'he3: thweatt_question_char = "s";
   9'he4: thweatt_question_char = " ";
   9'he5: thweatt_question_char = "b";
   9'he6: thweatt_question_char = "e";
   9'he7: thweatt_question_char = "s";
   9'he8: thweatt_question_char = "t";
   9'he9: thweatt_question_char = " ";
   9'hea: thweatt_question_char = "c";
   9'heb: thweatt_question_char = "a";
   9'hec: thweatt_question_char = "p";
   9'hed: thweatt_question_char = "t";
   9'hee: thweatt_question_char = "u";
   9'hef: thweatt_question_char = "r";
   9'hf0: thweatt_question_char = "e";
   9'hf1: thweatt_question_char = "d";
   9'hf2: thweatt_question_char = " ";
   9'hf3: thweatt_question_char = "a";
   9'hf4: thweatt_question_char = "s";

   9'h102: thweatt_question_char = "f";
   9'h103: thweatt_question_char = "o";
   9'h104: thweatt_question_char = "l";
   9'h105: thweatt_question_char = "l";
   9'h106: thweatt_question_char = "o";
   9'h107: thweatt_question_char = "w";
   9'h108: thweatt_question_char = "s";
   9'h109: thweatt_question_char = ":";
   9'h10a: thweatt_question_char = " ";
   9'h10b: thweatt_question_char = "\"";
   9'h10c: thweatt_question_char = "I";
   9'h10d: thweatt_question_char = "f";
   9'h10e: thweatt_question_char = " ";
   9'h10f: thweatt_question_char = "y";
   9'h110: thweatt_question_char = "o";
   9'h111: thweatt_question_char = "u";
   9'h112: thweatt_question_char = " ";
   9'h113: thweatt_question_char = "k";
   9'h114: thweatt_question_char = "n";
   9'h115: thweatt_question_char = "o";
   9'h116: thweatt_question_char = "w";

   9'h122: thweatt_question_char = "s";
   9'h123: thweatt_question_char = "o";
   9'h124: thweatt_question_char = "m";
   9'h125: thweatt_question_char = "e";
   9'h126: thweatt_question_char = "t";
   9'h127: thweatt_question_char = "h";
   9'h128: thweatt_question_char = "i";
   9'h129: thweatt_question_char = "n";
   9'h12a: thweatt_question_char = "g";
   9'h12b: thweatt_question_char = " ";
   9'h12c: thweatt_question_char = "c";
   9'h12d: thweatt_question_char = "a";
   9'h12e: thweatt_question_char = "n";
   9'h12f: thweatt_question_char = "'";
   9'h130: thweatt_question_char = "t";
   9'h131: thweatt_question_char = " ";
   9'h132: thweatt_question_char = "h";
   9'h133: thweatt_question_char = "a";
   9'h134: thweatt_question_char = "p";
   9'h135: thweatt_question_char = "p";
   9'h136: thweatt_question_char = "e";
   9'h137: thweatt_question_char = "n";
   9'h138: thweatt_question_char = ",";

   9'h142: thweatt_question_char = "t";
   9'h143: thweatt_question_char = "h";
   9'h144: thweatt_question_char = "e";
   9'h145: thweatt_question_char = "n";
   9'h146: thweatt_question_char = " ";
   9'h147: thweatt_question_char = "y";
   9'h148: thweatt_question_char = "o";
   9'h149: thweatt_question_char = "u";
   9'h14a: thweatt_question_char = " ";
   9'h14b: thweatt_question_char = "d";
   9'h14c: thweatt_question_char = "o";
   9'h14d: thweatt_question_char = "n";
   9'h14e: thweatt_question_char = "'";
   9'h14f: thweatt_question_char = "t";
   9'h150: thweatt_question_char = " ";
   9'h151: thweatt_question_char = "c";
   9'h152: thweatt_question_char = "a";
   9'h153: thweatt_question_char = "r";
   9'h154: thweatt_question_char = "e";
   9'h155: thweatt_question_char = " ";
   9'h156: thweatt_question_char = "w";
   9'h157: thweatt_question_char = "h";
   9'h158: thweatt_question_char = "a";
   9'h159: thweatt_question_char = "t";

   9'h162: thweatt_question_char = "w";
   9'h163: thweatt_question_char = "o";
   9'h164: thweatt_question_char = "u";
   9'h165: thweatt_question_char = "l";
   9'h166: thweatt_question_char = "d";
   9'h167: thweatt_question_char = " ";
   9'h168: thweatt_question_char = "h";
   9'h169: thweatt_question_char = "a";
   9'h16a: thweatt_question_char = "p";
   9'h16b: thweatt_question_char = "p";
   9'h16c: thweatt_question_char = "e";
   9'h16d: thweatt_question_char = "n";
   9'h16e: thweatt_question_char = " ";
   9'h16f: thweatt_question_char = "i";
   9'h170: thweatt_question_char = "f";
   9'h171: thweatt_question_char = " ";
   9'h172: thweatt_question_char = "i";
   9'h173: thweatt_question_char = "t";
   9'h174: thweatt_question_char = " ";
   9'h175: thweatt_question_char = "d";
   9'h176: thweatt_question_char = "i";
   9'h177: thweatt_question_char = "d";

   9'h182: thweatt_question_char = "h";
   9'h183: thweatt_question_char = "a";
   9'h184: thweatt_question_char = "p";
   9'h185: thweatt_question_char = "p";
   9'h186: thweatt_question_char = "e";
   9'h187: thweatt_question_char = "n";
   9'h188: thweatt_question_char = ",";
   9'h189: thweatt_question_char = " ";
   9'h18a: thweatt_question_char = "b";
   9'h18b: thweatt_question_char = "e";
   9'h18c: thweatt_question_char = "c";
   9'h18d: thweatt_question_char = "a";
   9'h18e: thweatt_question_char = "u";
   9'h18f: thweatt_question_char = "s";
   9'h190: thweatt_question_char = "e";
   9'h191: thweatt_question_char = " ";
   9'h192: thweatt_question_char = "i";
   9'h193: thweatt_question_char = "t";
   9'h194: thweatt_question_char = " ";
   9'h195: thweatt_question_char = "c";
   9'h196: thweatt_question_char = "a";
   9'h197: thweatt_question_char = "n";
   9'h198: thweatt_question_char = "'";
   9'h199: thweatt_question_char = "t";

   9'h1a2: thweatt_question_char = "h";
   9'h1a3: thweatt_question_char = "a";
   9'h1a4: thweatt_question_char = "p";
   9'h1a5: thweatt_question_char = "p";
   9'h1a6: thweatt_question_char = "e";
   9'h1a7: thweatt_question_char = "n";
   9'h1a8: thweatt_question_char = ".";
   9'h1a9: thweatt_question_char = "\"";

   9'h1c3: thweatt_question_char = "A";
   9'h1c4: thweatt_question_char = ":";
   9'h1c5: thweatt_question_char = " ";
   9'h1c6: thweatt_question_char = "H";
   9'h1c7: thweatt_question_char = "u";
   9'h1c8: thweatt_question_char = "h";
   9'h1c9: thweatt_question_char = "?";

   9'h1e3: thweatt_question_char = "B";
   9'h1e4: thweatt_question_char = ":";
   9'h1e5: thweatt_question_char = " ";
   9'h1e6: thweatt_question_char = "I";
   9'h1e7: thweatt_question_char = " ";
   9'h1e8: thweatt_question_char = "d";
   9'h1e9: thweatt_question_char = "o";
   9'h1ea: thweatt_question_char = "n";
   9'h1eb: thweatt_question_char = "'";
   9'h1ec: thweatt_question_char = "t";
   9'h1ed: thweatt_question_char = " ";
   9'h1ee: thweatt_question_char = "c";
   9'h1ef: thweatt_question_char = "a";
   9'h1f0: thweatt_question_char = "r";
   9'h1f1: thweatt_question_char = "e";
   default: thweatt_question_char = " ";
   endcase
   end

   wire comp_text_on;
   reg [6:0] char_addr_comp;
   assign comp_text_on = pix_y[7]==1'b1;
   always @(*) begin
      case( {pix_y[6:4],pix_x[7:3]} )
         16'h22: char_addr_comp = "B";
         16'h23: char_addr_comp = "e";
         16'h24: char_addr_comp = "e";
         16'h25: char_addr_comp = "p";
         16'h26: char_addr_comp = "!";
         16'h28: char_addr_comp = "B";
         16'h29: char_addr_comp = "o";
         16'h2a: char_addr_comp = "p";
         16'h2b: char_addr_comp = "!";
         16'h2d: char_addr_comp = "B";
         16'h2e: char_addr_comp = "o";
         16'h2f: char_addr_comp = "o";
         16'h30: char_addr_comp = "p";
         16'h31: char_addr_comp = "!";
         default: char_addr_comp = " ";
      endcase
   end

   wire attack_text_on;
   assign attack_text_on = martin_attack_on || jones_attack_on 
                           || plass_attack_on || thweatt_attack_on;
   reg [6:0] attack_text;
   always @(*) begin
      case( prof )
         `PROF_TOM: attack_text = martin_attack_char;
         `PROF_JASON: attack_text = thweatt_attack_char;
         `PROF_PAUL: attack_text = plass_attack_char;
         `PROF_MARK: attack_text = jones_attack_char;
         default attack_text = " ";
      endcase
   end

   wire question_text_on;
   assign question_text_on = martin_question_on || jones_question_on 
                             || plass_question_on || thweatt_question_on;
   reg [6:0] question_text;
   always @(*) begin
      case( prof )
         `PROF_TOM: question_text = martin_question_char;
         `PROF_JASON: question_text = thweatt_question_char;
         `PROF_PAUL: question_text = plass_question_char;
         `PROF_MARK: question_text = jones_question_char;
         default question_text = " ";
      endcase
   end

   always @( posedge clock ) begin
      if( reset ) begin
         bob_addr_offset <= 0;
         thweatt_q_offset <= 0;
      end
      if( kb_data_avail && (kb_data == `DOWN_ARROW) ) begin
         if( state == `INTRO_STATE && bob_addr_offset < (NUM_LINES_BOB-6) )
            bob_addr_offset <= bob_addr_offset + 1;
         else if( state == `QUESTION_STATE && thweatt_q_offset < (THWEATT_Q_LINES-6) )
            thweatt_q_offset <= thweatt_q_offset + 1;
      end
      else if( kb_data_avail && (kb_data == `UP_ARROW) ) begin
         if( state == `INTRO_STATE && bob_addr_offset != 0 )
            bob_addr_offset <= bob_addr_offset - 1;
         else if( state == `QUESTION_STATE && thweatt_q_offset != 0 )
            thweatt_q_offset <= thweatt_q_offset - 1;
      end
   end
         
   always @(*) begin
      case( state )
         `SPLASH_STATE: begin
            if( text_on_start )
               char_addr = char_addr_start;
            else if( text_on_byline )
               char_addr = char_addr_byline;
            else
               char_addr = 0;
         end
         `INTRO_STATE: begin
            if( fight_text_on )
               char_addr = char_addr_fight;
            else if( text_on_bob )
               char_addr = char_addr_bob;
            else
               char_addr = 0;
         end
         `COMP_STATE: begin
            if( fight_text_on )
               char_addr = char_addr_fight;
            else if( comp_text_on )
               char_addr = char_addr_comp;
            else
               char_addr = 8'b0;
         end
         `ATTACK_STATE: begin
            if( fight_text_on )
               char_addr = char_addr_fight;
            else if( attack_text_on )
               char_addr = attack_text;
            else
               char_addr = 8'h0;
         end
         `QUESTION_STATE: begin
            if( fight_text_on )
               char_addr = char_addr_fight;
            else if( question_text_on )
               char_addr = question_text;
            else
               char_addr = 8'h0;
         end
         default: char_addr = 0;
      endcase
   end

   assign text_on = text_on_byline || text_on_start 
                    || text_on_bob 
                    || fight_text_on
                    || attack_text_on
                    || question_text_on
                    || comp_text_on;
   assign font_rom_addr = {char_addr,row_addr};
   assign font_bit = font_word[~bit_addr];
   assign text_display = text_on && font_bit;

endmodule
