module Floor
( 
   input            clock, 
   input      [7:0] x,
   input      [7:0] y,
   output reg [1:0] color
);

   reg [9:0] addr;

   always @( posedge clock )
      addr <= {y[4:0],x[4:0]};

always @(*) begin
   case( addr )
      10'h000: color = 2'b11;
      10'h001: color = 2'b11;
      10'h002: color = 2'b11;
      10'h003: color = 2'b11;
      10'h004: color = 2'b10;
      10'h005: color = 2'b10;
      10'h006: color = 2'b11;
      10'h007: color = 2'b11;
      10'h008: color = 2'b10;
      10'h009: color = 2'b10;
      10'h00a: color = 2'b11;
      10'h00b: color = 2'b11;
      10'h00c: color = 2'b11;
      10'h00d: color = 2'b11;
      10'h00e: color = 2'b11;
      10'h00f: color = 2'b11;
      10'h010: color = 2'b11;
      10'h011: color = 2'b11;
      10'h012: color = 2'b11;
      10'h013: color = 2'b11;
      10'h014: color = 2'b10;
      10'h015: color = 2'b10;
      10'h016: color = 2'b11;
      10'h017: color = 2'b11;
      10'h018: color = 2'b10;
      10'h019: color = 2'b10;
      10'h01a: color = 2'b11;
      10'h01b: color = 2'b11;
      10'h01c: color = 2'b11;
      10'h01d: color = 2'b11;
      10'h01e: color = 2'b11;
      10'h01f: color = 2'b11;
      10'h020: color = 2'b11;
      10'h021: color = 2'b11;
      10'h022: color = 2'b11;
      10'h023: color = 2'b11;
      10'h024: color = 2'b10;
      10'h025: color = 2'b10;
      10'h026: color = 2'b11;
      10'h027: color = 2'b11;
      10'h028: color = 2'b10;
      10'h029: color = 2'b10;
      10'h02a: color = 2'b11;
      10'h02b: color = 2'b11;
      10'h02c: color = 2'b11;
      10'h02d: color = 2'b11;
      10'h02e: color = 2'b11;
      10'h02f: color = 2'b11;
      10'h030: color = 2'b11;
      10'h031: color = 2'b11;
      10'h032: color = 2'b11;
      10'h033: color = 2'b11;
      10'h034: color = 2'b10;
      10'h035: color = 2'b10;
      10'h036: color = 2'b11;
      10'h037: color = 2'b11;
      10'h038: color = 2'b10;
      10'h039: color = 2'b10;
      10'h03a: color = 2'b11;
      10'h03b: color = 2'b11;
      10'h03c: color = 2'b11;
      10'h03d: color = 2'b11;
      10'h03e: color = 2'b11;
      10'h03f: color = 2'b11;
      10'h040: color = 2'b11;
      10'h041: color = 2'b11;
      10'h042: color = 2'b10;
      10'h043: color = 2'b10;
      10'h044: color = 2'b11;
      10'h045: color = 2'b11;
      10'h046: color = 2'b11;
      10'h047: color = 2'b11;
      10'h048: color = 2'b11;
      10'h049: color = 2'b11;
      10'h04a: color = 2'b10;
      10'h04b: color = 2'b10;
      10'h04c: color = 2'b11;
      10'h04d: color = 2'b11;
      10'h04e: color = 2'b11;
      10'h04f: color = 2'b11;
      10'h050: color = 2'b11;
      10'h051: color = 2'b11;
      10'h052: color = 2'b10;
      10'h053: color = 2'b10;
      10'h054: color = 2'b11;
      10'h055: color = 2'b11;
      10'h056: color = 2'b11;
      10'h057: color = 2'b11;
      10'h058: color = 2'b11;
      10'h059: color = 2'b11;
      10'h05a: color = 2'b10;
      10'h05b: color = 2'b10;
      10'h05c: color = 2'b11;
      10'h05d: color = 2'b11;
      10'h05e: color = 2'b11;
      10'h05f: color = 2'b11;
      10'h060: color = 2'b11;
      10'h061: color = 2'b11;
      10'h062: color = 2'b10;
      10'h063: color = 2'b10;
      10'h064: color = 2'b11;
      10'h065: color = 2'b11;
      10'h066: color = 2'b11;
      10'h067: color = 2'b11;
      10'h068: color = 2'b11;
      10'h069: color = 2'b11;
      10'h06a: color = 2'b10;
      10'h06b: color = 2'b10;
      10'h06c: color = 2'b11;
      10'h06d: color = 2'b11;
      10'h06e: color = 2'b11;
      10'h06f: color = 2'b11;
      10'h070: color = 2'b11;
      10'h071: color = 2'b11;
      10'h072: color = 2'b10;
      10'h073: color = 2'b10;
      10'h074: color = 2'b11;
      10'h075: color = 2'b11;
      10'h076: color = 2'b11;
      10'h077: color = 2'b11;
      10'h078: color = 2'b11;
      10'h079: color = 2'b11;
      10'h07a: color = 2'b10;
      10'h07b: color = 2'b10;
      10'h07c: color = 2'b11;
      10'h07d: color = 2'b11;
      10'h07e: color = 2'b11;
      10'h07f: color = 2'b11;
      10'h080: color = 2'b10;
      10'h081: color = 2'b10;
      10'h082: color = 2'b11;
      10'h083: color = 2'b11;
      10'h084: color = 2'b11;
      10'h085: color = 2'b11;
      10'h086: color = 2'b11;
      10'h087: color = 2'b11;
      10'h088: color = 2'b11;
      10'h089: color = 2'b11;
      10'h08a: color = 2'b11;
      10'h08b: color = 2'b11;
      10'h08c: color = 2'b10;
      10'h08d: color = 2'b10;
      10'h08e: color = 2'b11;
      10'h08f: color = 2'b11;
      10'h090: color = 2'b10;
      10'h091: color = 2'b10;
      10'h092: color = 2'b11;
      10'h093: color = 2'b11;
      10'h094: color = 2'b11;
      10'h095: color = 2'b11;
      10'h096: color = 2'b11;
      10'h097: color = 2'b11;
      10'h098: color = 2'b11;
      10'h099: color = 2'b11;
      10'h09a: color = 2'b11;
      10'h09b: color = 2'b11;
      10'h09c: color = 2'b10;
      10'h09d: color = 2'b10;
      10'h09e: color = 2'b11;
      10'h09f: color = 2'b11;
      10'h0a0: color = 2'b10;
      10'h0a1: color = 2'b10;
      10'h0a2: color = 2'b11;
      10'h0a3: color = 2'b11;
      10'h0a4: color = 2'b11;
      10'h0a5: color = 2'b11;
      10'h0a6: color = 2'b11;
      10'h0a7: color = 2'b11;
      10'h0a8: color = 2'b11;
      10'h0a9: color = 2'b11;
      10'h0aa: color = 2'b11;
      10'h0ab: color = 2'b11;
      10'h0ac: color = 2'b10;
      10'h0ad: color = 2'b10;
      10'h0ae: color = 2'b11;
      10'h0af: color = 2'b11;
      10'h0b0: color = 2'b10;
      10'h0b1: color = 2'b10;
      10'h0b2: color = 2'b11;
      10'h0b3: color = 2'b11;
      10'h0b4: color = 2'b11;
      10'h0b5: color = 2'b11;
      10'h0b6: color = 2'b11;
      10'h0b7: color = 2'b11;
      10'h0b8: color = 2'b11;
      10'h0b9: color = 2'b11;
      10'h0ba: color = 2'b11;
      10'h0bb: color = 2'b11;
      10'h0bc: color = 2'b10;
      10'h0bd: color = 2'b10;
      10'h0be: color = 2'b11;
      10'h0bf: color = 2'b11;
      10'h0c0: color = 2'b11;
      10'h0c1: color = 2'b11;
      10'h0c2: color = 2'b11;
      10'h0c3: color = 2'b11;
      10'h0c4: color = 2'b11;
      10'h0c5: color = 2'b11;
      10'h0c6: color = 2'b11;
      10'h0c7: color = 2'b11;
      10'h0c8: color = 2'b11;
      10'h0c9: color = 2'b11;
      10'h0ca: color = 2'b11;
      10'h0cb: color = 2'b11;
      10'h0cc: color = 2'b11;
      10'h0cd: color = 2'b11;
      10'h0ce: color = 2'b10;
      10'h0cf: color = 2'b10;
      10'h0d0: color = 2'b11;
      10'h0d1: color = 2'b11;
      10'h0d2: color = 2'b11;
      10'h0d3: color = 2'b11;
      10'h0d4: color = 2'b11;
      10'h0d5: color = 2'b11;
      10'h0d6: color = 2'b11;
      10'h0d7: color = 2'b11;
      10'h0d8: color = 2'b11;
      10'h0d9: color = 2'b11;
      10'h0da: color = 2'b11;
      10'h0db: color = 2'b11;
      10'h0dc: color = 2'b11;
      10'h0dd: color = 2'b11;
      10'h0de: color = 2'b10;
      10'h0df: color = 2'b10;
      10'h0e0: color = 2'b11;
      10'h0e1: color = 2'b11;
      10'h0e2: color = 2'b11;
      10'h0e3: color = 2'b11;
      10'h0e4: color = 2'b11;
      10'h0e5: color = 2'b11;
      10'h0e6: color = 2'b11;
      10'h0e7: color = 2'b11;
      10'h0e8: color = 2'b11;
      10'h0e9: color = 2'b11;
      10'h0ea: color = 2'b11;
      10'h0eb: color = 2'b11;
      10'h0ec: color = 2'b11;
      10'h0ed: color = 2'b11;
      10'h0ee: color = 2'b10;
      10'h0ef: color = 2'b10;
      10'h0f0: color = 2'b11;
      10'h0f1: color = 2'b11;
      10'h0f2: color = 2'b11;
      10'h0f3: color = 2'b11;
      10'h0f4: color = 2'b11;
      10'h0f5: color = 2'b11;
      10'h0f6: color = 2'b11;
      10'h0f7: color = 2'b11;
      10'h0f8: color = 2'b11;
      10'h0f9: color = 2'b11;
      10'h0fa: color = 2'b11;
      10'h0fb: color = 2'b11;
      10'h0fc: color = 2'b11;
      10'h0fd: color = 2'b11;
      10'h0fe: color = 2'b10;
      10'h0ff: color = 2'b10;
      10'h100: color = 2'b10;
      10'h101: color = 2'b10;
      10'h102: color = 2'b11;
      10'h103: color = 2'b11;
      10'h104: color = 2'b11;
      10'h105: color = 2'b11;
      10'h106: color = 2'b11;
      10'h107: color = 2'b11;
      10'h108: color = 2'b11;
      10'h109: color = 2'b11;
      10'h10a: color = 2'b11;
      10'h10b: color = 2'b11;
      10'h10c: color = 2'b11;
      10'h10d: color = 2'b11;
      10'h10e: color = 2'b11;
      10'h10f: color = 2'b11;
      10'h110: color = 2'b10;
      10'h111: color = 2'b10;
      10'h112: color = 2'b11;
      10'h113: color = 2'b11;
      10'h114: color = 2'b11;
      10'h115: color = 2'b11;
      10'h116: color = 2'b11;
      10'h117: color = 2'b11;
      10'h118: color = 2'b11;
      10'h119: color = 2'b11;
      10'h11a: color = 2'b11;
      10'h11b: color = 2'b11;
      10'h11c: color = 2'b11;
      10'h11d: color = 2'b11;
      10'h11e: color = 2'b11;
      10'h11f: color = 2'b11;
      10'h120: color = 2'b10;
      10'h121: color = 2'b10;
      10'h122: color = 2'b11;
      10'h123: color = 2'b11;
      10'h124: color = 2'b11;
      10'h125: color = 2'b11;
      10'h126: color = 2'b11;
      10'h127: color = 2'b11;
      10'h128: color = 2'b11;
      10'h129: color = 2'b11;
      10'h12a: color = 2'b11;
      10'h12b: color = 2'b11;
      10'h12c: color = 2'b11;
      10'h12d: color = 2'b11;
      10'h12e: color = 2'b11;
      10'h12f: color = 2'b11;
      10'h130: color = 2'b10;
      10'h131: color = 2'b10;
      10'h132: color = 2'b11;
      10'h133: color = 2'b11;
      10'h134: color = 2'b11;
      10'h135: color = 2'b11;
      10'h136: color = 2'b11;
      10'h137: color = 2'b11;
      10'h138: color = 2'b11;
      10'h139: color = 2'b11;
      10'h13a: color = 2'b11;
      10'h13b: color = 2'b11;
      10'h13c: color = 2'b11;
      10'h13d: color = 2'b11;
      10'h13e: color = 2'b11;
      10'h13f: color = 2'b11;
      10'h140: color = 2'b11;
      10'h141: color = 2'b11;
      10'h142: color = 2'b10;
      10'h143: color = 2'b10;
      10'h144: color = 2'b11;
      10'h145: color = 2'b11;
      10'h146: color = 2'b11;
      10'h147: color = 2'b11;
      10'h148: color = 2'b11;
      10'h149: color = 2'b11;
      10'h14a: color = 2'b11;
      10'h14b: color = 2'b11;
      10'h14c: color = 2'b11;
      10'h14d: color = 2'b11;
      10'h14e: color = 2'b11;
      10'h14f: color = 2'b11;
      10'h150: color = 2'b11;
      10'h151: color = 2'b11;
      10'h152: color = 2'b10;
      10'h153: color = 2'b10;
      10'h154: color = 2'b11;
      10'h155: color = 2'b11;
      10'h156: color = 2'b11;
      10'h157: color = 2'b11;
      10'h158: color = 2'b11;
      10'h159: color = 2'b11;
      10'h15a: color = 2'b11;
      10'h15b: color = 2'b11;
      10'h15c: color = 2'b11;
      10'h15d: color = 2'b11;
      10'h15e: color = 2'b11;
      10'h15f: color = 2'b11;
      10'h160: color = 2'b11;
      10'h161: color = 2'b11;
      10'h162: color = 2'b10;
      10'h163: color = 2'b10;
      10'h164: color = 2'b11;
      10'h165: color = 2'b11;
      10'h166: color = 2'b11;
      10'h167: color = 2'b11;
      10'h168: color = 2'b11;
      10'h169: color = 2'b11;
      10'h16a: color = 2'b11;
      10'h16b: color = 2'b11;
      10'h16c: color = 2'b11;
      10'h16d: color = 2'b11;
      10'h16e: color = 2'b11;
      10'h16f: color = 2'b11;
      10'h170: color = 2'b11;
      10'h171: color = 2'b11;
      10'h172: color = 2'b10;
      10'h173: color = 2'b10;
      10'h174: color = 2'b11;
      10'h175: color = 2'b11;
      10'h176: color = 2'b11;
      10'h177: color = 2'b11;
      10'h178: color = 2'b11;
      10'h179: color = 2'b11;
      10'h17a: color = 2'b11;
      10'h17b: color = 2'b11;
      10'h17c: color = 2'b11;
      10'h17d: color = 2'b11;
      10'h17e: color = 2'b11;
      10'h17f: color = 2'b11;
      10'h180: color = 2'b11;
      10'h181: color = 2'b11;
      10'h182: color = 2'b11;
      10'h183: color = 2'b11;
      10'h184: color = 2'b10;
      10'h185: color = 2'b10;
      10'h186: color = 2'b11;
      10'h187: color = 2'b11;
      10'h188: color = 2'b11;
      10'h189: color = 2'b11;
      10'h18a: color = 2'b11;
      10'h18b: color = 2'b11;
      10'h18c: color = 2'b11;
      10'h18d: color = 2'b11;
      10'h18e: color = 2'b11;
      10'h18f: color = 2'b11;
      10'h190: color = 2'b11;
      10'h191: color = 2'b11;
      10'h192: color = 2'b11;
      10'h193: color = 2'b11;
      10'h194: color = 2'b10;
      10'h195: color = 2'b10;
      10'h196: color = 2'b11;
      10'h197: color = 2'b11;
      10'h198: color = 2'b11;
      10'h199: color = 2'b11;
      10'h19a: color = 2'b11;
      10'h19b: color = 2'b11;
      10'h19c: color = 2'b11;
      10'h19d: color = 2'b11;
      10'h19e: color = 2'b11;
      10'h19f: color = 2'b11;
      10'h1a0: color = 2'b11;
      10'h1a1: color = 2'b11;
      10'h1a2: color = 2'b11;
      10'h1a3: color = 2'b11;
      10'h1a4: color = 2'b10;
      10'h1a5: color = 2'b10;
      10'h1a6: color = 2'b11;
      10'h1a7: color = 2'b11;
      10'h1a8: color = 2'b11;
      10'h1a9: color = 2'b11;
      10'h1aa: color = 2'b11;
      10'h1ab: color = 2'b11;
      10'h1ac: color = 2'b11;
      10'h1ad: color = 2'b11;
      10'h1ae: color = 2'b11;
      10'h1af: color = 2'b11;
      10'h1b0: color = 2'b11;
      10'h1b1: color = 2'b11;
      10'h1b2: color = 2'b11;
      10'h1b3: color = 2'b11;
      10'h1b4: color = 2'b10;
      10'h1b5: color = 2'b10;
      10'h1b6: color = 2'b11;
      10'h1b7: color = 2'b11;
      10'h1b8: color = 2'b11;
      10'h1b9: color = 2'b11;
      10'h1ba: color = 2'b11;
      10'h1bb: color = 2'b11;
      10'h1bc: color = 2'b11;
      10'h1bd: color = 2'b11;
      10'h1be: color = 2'b11;
      10'h1bf: color = 2'b11;
      10'h1c0: color = 2'b11;
      10'h1c1: color = 2'b11;
      10'h1c2: color = 2'b11;
      10'h1c3: color = 2'b11;
      10'h1c4: color = 2'b11;
      10'h1c5: color = 2'b11;
      10'h1c6: color = 2'b10;
      10'h1c7: color = 2'b10;
      10'h1c8: color = 2'b11;
      10'h1c9: color = 2'b11;
      10'h1ca: color = 2'b11;
      10'h1cb: color = 2'b11;
      10'h1cc: color = 2'b11;
      10'h1cd: color = 2'b11;
      10'h1ce: color = 2'b11;
      10'h1cf: color = 2'b11;
      10'h1d0: color = 2'b11;
      10'h1d1: color = 2'b11;
      10'h1d2: color = 2'b11;
      10'h1d3: color = 2'b11;
      10'h1d4: color = 2'b11;
      10'h1d5: color = 2'b11;
      10'h1d6: color = 2'b10;
      10'h1d7: color = 2'b10;
      10'h1d8: color = 2'b11;
      10'h1d9: color = 2'b11;
      10'h1da: color = 2'b11;
      10'h1db: color = 2'b11;
      10'h1dc: color = 2'b11;
      10'h1dd: color = 2'b11;
      10'h1de: color = 2'b11;
      10'h1df: color = 2'b11;
      10'h1e0: color = 2'b11;
      10'h1e1: color = 2'b11;
      10'h1e2: color = 2'b11;
      10'h1e3: color = 2'b11;
      10'h1e4: color = 2'b11;
      10'h1e5: color = 2'b11;
      10'h1e6: color = 2'b10;
      10'h1e7: color = 2'b10;
      10'h1e8: color = 2'b11;
      10'h1e9: color = 2'b11;
      10'h1ea: color = 2'b11;
      10'h1eb: color = 2'b11;
      10'h1ec: color = 2'b11;
      10'h1ed: color = 2'b11;
      10'h1ee: color = 2'b11;
      10'h1ef: color = 2'b11;
      10'h1f0: color = 2'b11;
      10'h1f1: color = 2'b11;
      10'h1f2: color = 2'b11;
      10'h1f3: color = 2'b11;
      10'h1f4: color = 2'b11;
      10'h1f5: color = 2'b11;
      10'h1f6: color = 2'b10;
      10'h1f7: color = 2'b10;
      10'h1f8: color = 2'b11;
      10'h1f9: color = 2'b11;
      10'h1fa: color = 2'b11;
      10'h1fb: color = 2'b11;
      10'h1fc: color = 2'b11;
      10'h1fd: color = 2'b11;
      10'h1fe: color = 2'b11;
      10'h1ff: color = 2'b11;
      10'h200: color = 2'b11;
      10'h201: color = 2'b11;
      10'h202: color = 2'b11;
      10'h203: color = 2'b11;
      10'h204: color = 2'b10;
      10'h205: color = 2'b10;
      10'h206: color = 2'b11;
      10'h207: color = 2'b11;
      10'h208: color = 2'b10;
      10'h209: color = 2'b10;
      10'h20a: color = 2'b11;
      10'h20b: color = 2'b11;
      10'h20c: color = 2'b11;
      10'h20d: color = 2'b11;
      10'h20e: color = 2'b11;
      10'h20f: color = 2'b11;
      10'h210: color = 2'b11;
      10'h211: color = 2'b11;
      10'h212: color = 2'b11;
      10'h213: color = 2'b11;
      10'h214: color = 2'b10;
      10'h215: color = 2'b10;
      10'h216: color = 2'b11;
      10'h217: color = 2'b11;
      10'h218: color = 2'b10;
      10'h219: color = 2'b10;
      10'h21a: color = 2'b11;
      10'h21b: color = 2'b11;
      10'h21c: color = 2'b11;
      10'h21d: color = 2'b11;
      10'h21e: color = 2'b11;
      10'h21f: color = 2'b11;
      10'h220: color = 2'b11;
      10'h221: color = 2'b11;
      10'h222: color = 2'b11;
      10'h223: color = 2'b11;
      10'h224: color = 2'b10;
      10'h225: color = 2'b10;
      10'h226: color = 2'b11;
      10'h227: color = 2'b11;
      10'h228: color = 2'b10;
      10'h229: color = 2'b10;
      10'h22a: color = 2'b11;
      10'h22b: color = 2'b11;
      10'h22c: color = 2'b11;
      10'h22d: color = 2'b11;
      10'h22e: color = 2'b11;
      10'h22f: color = 2'b11;
      10'h230: color = 2'b11;
      10'h231: color = 2'b11;
      10'h232: color = 2'b11;
      10'h233: color = 2'b11;
      10'h234: color = 2'b10;
      10'h235: color = 2'b10;
      10'h236: color = 2'b11;
      10'h237: color = 2'b11;
      10'h238: color = 2'b10;
      10'h239: color = 2'b10;
      10'h23a: color = 2'b11;
      10'h23b: color = 2'b11;
      10'h23c: color = 2'b11;
      10'h23d: color = 2'b11;
      10'h23e: color = 2'b11;
      10'h23f: color = 2'b11;
      10'h240: color = 2'b11;
      10'h241: color = 2'b11;
      10'h242: color = 2'b10;
      10'h243: color = 2'b10;
      10'h244: color = 2'b11;
      10'h245: color = 2'b11;
      10'h246: color = 2'b11;
      10'h247: color = 2'b11;
      10'h248: color = 2'b11;
      10'h249: color = 2'b11;
      10'h24a: color = 2'b10;
      10'h24b: color = 2'b10;
      10'h24c: color = 2'b11;
      10'h24d: color = 2'b11;
      10'h24e: color = 2'b11;
      10'h24f: color = 2'b11;
      10'h250: color = 2'b11;
      10'h251: color = 2'b11;
      10'h252: color = 2'b10;
      10'h253: color = 2'b10;
      10'h254: color = 2'b11;
      10'h255: color = 2'b11;
      10'h256: color = 2'b11;
      10'h257: color = 2'b11;
      10'h258: color = 2'b11;
      10'h259: color = 2'b11;
      10'h25a: color = 2'b10;
      10'h25b: color = 2'b10;
      10'h25c: color = 2'b11;
      10'h25d: color = 2'b11;
      10'h25e: color = 2'b11;
      10'h25f: color = 2'b11;
      10'h260: color = 2'b11;
      10'h261: color = 2'b11;
      10'h262: color = 2'b10;
      10'h263: color = 2'b10;
      10'h264: color = 2'b11;
      10'h265: color = 2'b11;
      10'h266: color = 2'b11;
      10'h267: color = 2'b11;
      10'h268: color = 2'b11;
      10'h269: color = 2'b11;
      10'h26a: color = 2'b10;
      10'h26b: color = 2'b10;
      10'h26c: color = 2'b11;
      10'h26d: color = 2'b11;
      10'h26e: color = 2'b11;
      10'h26f: color = 2'b11;
      10'h270: color = 2'b11;
      10'h271: color = 2'b11;
      10'h272: color = 2'b10;
      10'h273: color = 2'b10;
      10'h274: color = 2'b11;
      10'h275: color = 2'b11;
      10'h276: color = 2'b11;
      10'h277: color = 2'b11;
      10'h278: color = 2'b11;
      10'h279: color = 2'b11;
      10'h27a: color = 2'b10;
      10'h27b: color = 2'b10;
      10'h27c: color = 2'b11;
      10'h27d: color = 2'b11;
      10'h27e: color = 2'b11;
      10'h27f: color = 2'b11;
      10'h280: color = 2'b10;
      10'h281: color = 2'b10;
      10'h282: color = 2'b11;
      10'h283: color = 2'b11;
      10'h284: color = 2'b11;
      10'h285: color = 2'b11;
      10'h286: color = 2'b11;
      10'h287: color = 2'b11;
      10'h288: color = 2'b11;
      10'h289: color = 2'b11;
      10'h28a: color = 2'b11;
      10'h28b: color = 2'b11;
      10'h28c: color = 2'b10;
      10'h28d: color = 2'b10;
      10'h28e: color = 2'b11;
      10'h28f: color = 2'b11;
      10'h290: color = 2'b10;
      10'h291: color = 2'b10;
      10'h292: color = 2'b11;
      10'h293: color = 2'b11;
      10'h294: color = 2'b11;
      10'h295: color = 2'b11;
      10'h296: color = 2'b11;
      10'h297: color = 2'b11;
      10'h298: color = 2'b11;
      10'h299: color = 2'b11;
      10'h29a: color = 2'b11;
      10'h29b: color = 2'b11;
      10'h29c: color = 2'b10;
      10'h29d: color = 2'b10;
      10'h29e: color = 2'b11;
      10'h29f: color = 2'b11;
      10'h2a0: color = 2'b10;
      10'h2a1: color = 2'b10;
      10'h2a2: color = 2'b11;
      10'h2a3: color = 2'b11;
      10'h2a4: color = 2'b11;
      10'h2a5: color = 2'b11;
      10'h2a6: color = 2'b11;
      10'h2a7: color = 2'b11;
      10'h2a8: color = 2'b11;
      10'h2a9: color = 2'b11;
      10'h2aa: color = 2'b11;
      10'h2ab: color = 2'b11;
      10'h2ac: color = 2'b10;
      10'h2ad: color = 2'b10;
      10'h2ae: color = 2'b11;
      10'h2af: color = 2'b11;
      10'h2b0: color = 2'b10;
      10'h2b1: color = 2'b10;
      10'h2b2: color = 2'b11;
      10'h2b3: color = 2'b11;
      10'h2b4: color = 2'b11;
      10'h2b5: color = 2'b11;
      10'h2b6: color = 2'b11;
      10'h2b7: color = 2'b11;
      10'h2b8: color = 2'b11;
      10'h2b9: color = 2'b11;
      10'h2ba: color = 2'b11;
      10'h2bb: color = 2'b11;
      10'h2bc: color = 2'b10;
      10'h2bd: color = 2'b10;
      10'h2be: color = 2'b11;
      10'h2bf: color = 2'b11;
      10'h2c0: color = 2'b11;
      10'h2c1: color = 2'b11;
      10'h2c2: color = 2'b11;
      10'h2c3: color = 2'b11;
      10'h2c4: color = 2'b11;
      10'h2c5: color = 2'b11;
      10'h2c6: color = 2'b11;
      10'h2c7: color = 2'b11;
      10'h2c8: color = 2'b11;
      10'h2c9: color = 2'b11;
      10'h2ca: color = 2'b11;
      10'h2cb: color = 2'b11;
      10'h2cc: color = 2'b11;
      10'h2cd: color = 2'b11;
      10'h2ce: color = 2'b10;
      10'h2cf: color = 2'b10;
      10'h2d0: color = 2'b11;
      10'h2d1: color = 2'b11;
      10'h2d2: color = 2'b11;
      10'h2d3: color = 2'b11;
      10'h2d4: color = 2'b11;
      10'h2d5: color = 2'b11;
      10'h2d6: color = 2'b11;
      10'h2d7: color = 2'b11;
      10'h2d8: color = 2'b11;
      10'h2d9: color = 2'b11;
      10'h2da: color = 2'b11;
      10'h2db: color = 2'b11;
      10'h2dc: color = 2'b11;
      10'h2dd: color = 2'b11;
      10'h2de: color = 2'b10;
      10'h2df: color = 2'b10;
      10'h2e0: color = 2'b11;
      10'h2e1: color = 2'b11;
      10'h2e2: color = 2'b11;
      10'h2e3: color = 2'b11;
      10'h2e4: color = 2'b11;
      10'h2e5: color = 2'b11;
      10'h2e6: color = 2'b11;
      10'h2e7: color = 2'b11;
      10'h2e8: color = 2'b11;
      10'h2e9: color = 2'b11;
      10'h2ea: color = 2'b11;
      10'h2eb: color = 2'b11;
      10'h2ec: color = 2'b11;
      10'h2ed: color = 2'b11;
      10'h2ee: color = 2'b10;
      10'h2ef: color = 2'b10;
      10'h2f0: color = 2'b11;
      10'h2f1: color = 2'b11;
      10'h2f2: color = 2'b11;
      10'h2f3: color = 2'b11;
      10'h2f4: color = 2'b11;
      10'h2f5: color = 2'b11;
      10'h2f6: color = 2'b11;
      10'h2f7: color = 2'b11;
      10'h2f8: color = 2'b11;
      10'h2f9: color = 2'b11;
      10'h2fa: color = 2'b11;
      10'h2fb: color = 2'b11;
      10'h2fc: color = 2'b11;
      10'h2fd: color = 2'b11;
      10'h2fe: color = 2'b10;
      10'h2ff: color = 2'b10;
      10'h300: color = 2'b10;
      10'h301: color = 2'b10;
      10'h302: color = 2'b11;
      10'h303: color = 2'b11;
      10'h304: color = 2'b11;
      10'h305: color = 2'b11;
      10'h306: color = 2'b11;
      10'h307: color = 2'b11;
      10'h308: color = 2'b11;
      10'h309: color = 2'b11;
      10'h30a: color = 2'b11;
      10'h30b: color = 2'b11;
      10'h30c: color = 2'b11;
      10'h30d: color = 2'b11;
      10'h30e: color = 2'b11;
      10'h30f: color = 2'b11;
      10'h310: color = 2'b10;
      10'h311: color = 2'b10;
      10'h312: color = 2'b11;
      10'h313: color = 2'b11;
      10'h314: color = 2'b11;
      10'h315: color = 2'b11;
      10'h316: color = 2'b11;
      10'h317: color = 2'b11;
      10'h318: color = 2'b11;
      10'h319: color = 2'b11;
      10'h31a: color = 2'b11;
      10'h31b: color = 2'b11;
      10'h31c: color = 2'b11;
      10'h31d: color = 2'b11;
      10'h31e: color = 2'b11;
      10'h31f: color = 2'b11;
      10'h320: color = 2'b10;
      10'h321: color = 2'b10;
      10'h322: color = 2'b11;
      10'h323: color = 2'b11;
      10'h324: color = 2'b11;
      10'h325: color = 2'b11;
      10'h326: color = 2'b11;
      10'h327: color = 2'b11;
      10'h328: color = 2'b11;
      10'h329: color = 2'b11;
      10'h32a: color = 2'b11;
      10'h32b: color = 2'b11;
      10'h32c: color = 2'b11;
      10'h32d: color = 2'b11;
      10'h32e: color = 2'b11;
      10'h32f: color = 2'b11;
      10'h330: color = 2'b10;
      10'h331: color = 2'b10;
      10'h332: color = 2'b11;
      10'h333: color = 2'b11;
      10'h334: color = 2'b11;
      10'h335: color = 2'b11;
      10'h336: color = 2'b11;
      10'h337: color = 2'b11;
      10'h338: color = 2'b11;
      10'h339: color = 2'b11;
      10'h33a: color = 2'b11;
      10'h33b: color = 2'b11;
      10'h33c: color = 2'b11;
      10'h33d: color = 2'b11;
      10'h33e: color = 2'b11;
      10'h33f: color = 2'b11;
      10'h340: color = 2'b11;
      10'h341: color = 2'b11;
      10'h342: color = 2'b10;
      10'h343: color = 2'b10;
      10'h344: color = 2'b11;
      10'h345: color = 2'b11;
      10'h346: color = 2'b11;
      10'h347: color = 2'b11;
      10'h348: color = 2'b11;
      10'h349: color = 2'b11;
      10'h34a: color = 2'b11;
      10'h34b: color = 2'b11;
      10'h34c: color = 2'b11;
      10'h34d: color = 2'b11;
      10'h34e: color = 2'b11;
      10'h34f: color = 2'b11;
      10'h350: color = 2'b11;
      10'h351: color = 2'b11;
      10'h352: color = 2'b10;
      10'h353: color = 2'b10;
      10'h354: color = 2'b11;
      10'h355: color = 2'b11;
      10'h356: color = 2'b11;
      10'h357: color = 2'b11;
      10'h358: color = 2'b11;
      10'h359: color = 2'b11;
      10'h35a: color = 2'b11;
      10'h35b: color = 2'b11;
      10'h35c: color = 2'b11;
      10'h35d: color = 2'b11;
      10'h35e: color = 2'b11;
      10'h35f: color = 2'b11;
      10'h360: color = 2'b11;
      10'h361: color = 2'b11;
      10'h362: color = 2'b10;
      10'h363: color = 2'b10;
      10'h364: color = 2'b11;
      10'h365: color = 2'b11;
      10'h366: color = 2'b11;
      10'h367: color = 2'b11;
      10'h368: color = 2'b11;
      10'h369: color = 2'b11;
      10'h36a: color = 2'b11;
      10'h36b: color = 2'b11;
      10'h36c: color = 2'b11;
      10'h36d: color = 2'b11;
      10'h36e: color = 2'b11;
      10'h36f: color = 2'b11;
      10'h370: color = 2'b11;
      10'h371: color = 2'b11;
      10'h372: color = 2'b10;
      10'h373: color = 2'b10;
      10'h374: color = 2'b11;
      10'h375: color = 2'b11;
      10'h376: color = 2'b11;
      10'h377: color = 2'b11;
      10'h378: color = 2'b11;
      10'h379: color = 2'b11;
      10'h37a: color = 2'b11;
      10'h37b: color = 2'b11;
      10'h37c: color = 2'b11;
      10'h37d: color = 2'b11;
      10'h37e: color = 2'b11;
      10'h37f: color = 2'b11;
      10'h380: color = 2'b11;
      10'h381: color = 2'b11;
      10'h382: color = 2'b11;
      10'h383: color = 2'b11;
      10'h384: color = 2'b10;
      10'h385: color = 2'b10;
      10'h386: color = 2'b11;
      10'h387: color = 2'b11;
      10'h388: color = 2'b11;
      10'h389: color = 2'b11;
      10'h38a: color = 2'b11;
      10'h38b: color = 2'b11;
      10'h38c: color = 2'b11;
      10'h38d: color = 2'b11;
      10'h38e: color = 2'b11;
      10'h38f: color = 2'b11;
      10'h390: color = 2'b11;
      10'h391: color = 2'b11;
      10'h392: color = 2'b11;
      10'h393: color = 2'b11;
      10'h394: color = 2'b10;
      10'h395: color = 2'b10;
      10'h396: color = 2'b11;
      10'h397: color = 2'b11;
      10'h398: color = 2'b11;
      10'h399: color = 2'b11;
      10'h39a: color = 2'b11;
      10'h39b: color = 2'b11;
      10'h39c: color = 2'b11;
      10'h39d: color = 2'b11;
      10'h39e: color = 2'b11;
      10'h39f: color = 2'b11;
      10'h3a0: color = 2'b11;
      10'h3a1: color = 2'b11;
      10'h3a2: color = 2'b11;
      10'h3a3: color = 2'b11;
      10'h3a4: color = 2'b10;
      10'h3a5: color = 2'b10;
      10'h3a6: color = 2'b11;
      10'h3a7: color = 2'b11;
      10'h3a8: color = 2'b11;
      10'h3a9: color = 2'b11;
      10'h3aa: color = 2'b11;
      10'h3ab: color = 2'b11;
      10'h3ac: color = 2'b11;
      10'h3ad: color = 2'b11;
      10'h3ae: color = 2'b11;
      10'h3af: color = 2'b11;
      10'h3b0: color = 2'b11;
      10'h3b1: color = 2'b11;
      10'h3b2: color = 2'b11;
      10'h3b3: color = 2'b11;
      10'h3b4: color = 2'b10;
      10'h3b5: color = 2'b10;
      10'h3b6: color = 2'b11;
      10'h3b7: color = 2'b11;
      10'h3b8: color = 2'b11;
      10'h3b9: color = 2'b11;
      10'h3ba: color = 2'b11;
      10'h3bb: color = 2'b11;
      10'h3bc: color = 2'b11;
      10'h3bd: color = 2'b11;
      10'h3be: color = 2'b11;
      10'h3bf: color = 2'b11;
      10'h3c0: color = 2'b11;
      10'h3c1: color = 2'b11;
      10'h3c2: color = 2'b11;
      10'h3c3: color = 2'b11;
      10'h3c4: color = 2'b11;
      10'h3c5: color = 2'b11;
      10'h3c6: color = 2'b10;
      10'h3c7: color = 2'b10;
      10'h3c8: color = 2'b11;
      10'h3c9: color = 2'b11;
      10'h3ca: color = 2'b11;
      10'h3cb: color = 2'b11;
      10'h3cc: color = 2'b11;
      10'h3cd: color = 2'b11;
      10'h3ce: color = 2'b11;
      10'h3cf: color = 2'b11;
      10'h3d0: color = 2'b11;
      10'h3d1: color = 2'b11;
      10'h3d2: color = 2'b11;
      10'h3d3: color = 2'b11;
      10'h3d4: color = 2'b11;
      10'h3d5: color = 2'b11;
      10'h3d6: color = 2'b10;
      10'h3d7: color = 2'b10;
      10'h3d8: color = 2'b11;
      10'h3d9: color = 2'b11;
      10'h3da: color = 2'b11;
      10'h3db: color = 2'b11;
      10'h3dc: color = 2'b11;
      10'h3dd: color = 2'b11;
      10'h3de: color = 2'b11;
      10'h3df: color = 2'b11;
      10'h3e0: color = 2'b11;
      10'h3e1: color = 2'b11;
      10'h3e2: color = 2'b11;
      10'h3e3: color = 2'b11;
      10'h3e4: color = 2'b11;
      10'h3e5: color = 2'b11;
      10'h3e6: color = 2'b10;
      10'h3e7: color = 2'b10;
      10'h3e8: color = 2'b11;
      10'h3e9: color = 2'b11;
      10'h3ea: color = 2'b11;
      10'h3eb: color = 2'b11;
      10'h3ec: color = 2'b11;
      10'h3ed: color = 2'b11;
      10'h3ee: color = 2'b11;
      10'h3ef: color = 2'b11;
      10'h3f0: color = 2'b11;
      10'h3f1: color = 2'b11;
      10'h3f2: color = 2'b11;
      10'h3f3: color = 2'b11;
      10'h3f4: color = 2'b11;
      10'h3f5: color = 2'b11;
      10'h3f6: color = 2'b10;
      10'h3f7: color = 2'b10;
      10'h3f8: color = 2'b11;
      10'h3f9: color = 2'b11;
      10'h3fa: color = 2'b11;
      10'h3fb: color = 2'b11;
      10'h3fc: color = 2'b11;
      10'h3fd: color = 2'b11;
      10'h3fe: color = 2'b11;
      10'h3ff: color = 2'b11;
   endcase
end
endmodule
