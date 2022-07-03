module ris_controller(
  input          clock,
  input          reset,
  output         io_data_channel_ready,
  input          io_data_channel_valid,
  input  [255:0] io_data_channel_bits,
  output [31:0]  io_out_data,
  output         io_out_clk,
  output         io_out_le
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [255:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  _T_2 = ~reset; // @[ris.scala 18:31]
  reg [30:0] out_data; // @[ris.scala 19:31]
  reg [255:0] data_reg; // @[ris.scala 23:31]
  reg [3:0] value; // @[Counter.scala 62:40]
  reg [8:0] value_1; // @[Counter.scala 62:40]
  wire  shift_clk = value_1 == 9'h0; // @[ris.scala 27:39]
  wire  wrap = value_1 == 9'h1f3; // @[Counter.scala 74:24]
  wire [8:0] _value_T_1 = value_1 + 9'h1; // @[Counter.scala 78:24]
  wire  wrap_1 = value == 4'h8; // @[Counter.scala 74:24]
  wire [3:0] _value_T_3 = value + 4'h1; // @[Counter.scala 78:24]
  wire [255:0] _data_reg_T = {{1'd0}, data_reg[255:1]}; // @[ris.scala 38:38]
  wire [8:0] _io_out_clk_T_1 = value_1 - 9'h1; // @[ris.scala 46:42]
  wire  _io_out_clk_T_2 = _io_out_clk_T_1 > 9'hfa; // @[ris.scala 46:47]
  assign io_data_channel_ready = 1'h1; // @[ris.scala 20:63]
  assign io_out_data = {{1'd0}, out_data}; // @[ris.scala 19:62]
  assign io_out_clk = value <= 4'h8 & value >= 4'h1 & _io_out_clk_T_1 > 9'hfa; // @[ris.scala 45:61 46:24 48:24]
  assign io_out_le = value == 4'h0 & _io_out_clk_T_2; // @[ris.scala 50:38 51:23 53:23]
  always @(posedge clock or posedge _T_2) begin
    if (_T_2) begin // @[ris.scala 30:24]
      out_data <= 31'h55aa55aa; // @[ris.scala 32:41 35:30 19:31]
    end else if (shift_clk) begin // @[ris.scala 19:31]
      if (value <= 4'h7) begin
        out_data <= {{30'd0}, data_reg[248]};
      end
    end
  end
  always @(posedge clock or posedge _T_2) begin
    if (_T_2) begin // @[ris.scala 30:24]
      data_reg <= 256'h0; // @[ris.scala 32:41 38:26 39:48 40:26 23:31]
    end else if (shift_clk) begin // @[ris.scala 23:31]
      if (value <= 4'h7) begin
        data_reg <= _data_reg_T;
      end else if (wrap_1) begin
        data_reg <= io_data_channel_bits;
      end
    end
  end
  always @(posedge clock or posedge _T_2) begin
    if (_T_2) begin // @[ris.scala 30:24]
      value <= 4'h0; // @[Counter.scala 78:15 88:{20,28}]
    end else if (shift_clk) begin // @[Counter.scala 62:40]
      if (wrap_1) begin
        value <= 4'h0;
      end else begin
        value <= _value_T_3;
      end
    end
  end
  always @(posedge clock or posedge _T_2) begin
    if (_T_2) begin // @[Counter.scala 88:20]
      value_1 <= 9'h0; // @[Counter.scala 88:28]
    end else if (wrap) begin // @[Counter.scala 78:15]
      value_1 <= 9'h0;
    end else begin
      value_1 <= _value_T_1;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  out_data = _RAND_0[30:0];
  _RAND_1 = {8{`RANDOM}};
  data_reg = _RAND_1[255:0];
  _RAND_2 = {1{`RANDOM}};
  value = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  value_1 = _RAND_3[8:0];
`endif // RANDOMIZE_REG_INIT
  if (_T_2) begin
    out_data = 31'h55aa55aa;
  end
  if (_T_2) begin
    data_reg = 256'h0;
  end
  if (_T_2) begin
    value = 4'h0;
  end
  if (_T_2) begin
    value_1 = 9'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
